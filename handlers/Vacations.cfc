component {
	property name = "VacationModel" 		inject = "Vacation";
	property name = "UserModel" 			inject = "User";
	property name = "VacationTypeModel" 	inject = "VacationType";
	property name = "VacationStatusModel"	inject = "VacationStatus";
	property name = "TeamModel"				inject = "Team";
	property name = "MailerModel"			inject = "services.Mailer";
	property name = "messageBox" 			inject = "messagebox@cbmessagebox";

	function preHandler() {
		prc.title = "Vacations";
		prc.smallTitle = "";
		prc.action = "";
		prc.formClass = "";
		prc.objectName = "Vacation";
        prc.objectID = "";
	}

	function index(event,rc,prc){
		setNextEvent("Vacations.list");
	}

	function list(event,rc,prc) {
		prc.title = "Vacations";
		prc.smallTitle = "list";
		prc.vacations = VacationModel.findAllByIsActive(1);
		
		event.setView( "Vacations/list" );
	}

	function create(event,rc,prc){
		prc.title = "Create Vacation";
		prc.action = "Vacations.prepareInsert";
		prc.formClass = "vacation";

		prc.loggedUser = SESSION.user.id;
		prc.userTeamId = SESSION.user.team.id;

		prc.availableDays = UserModel.get(prc.loggedUser).getVacDays();
		prc.status = VacationStatusModel.findByName("Pending").getId();
		prc.users = UserModel.newCriteria(entityName = "Users")
			.isTrue("isActive")
			.ne("id", prc.loggedUser)
			.eq("team", TeamModel.get(prc.userTeamId))
			.list();
		prc.types = VacationTypeModel.findAllByIsActive(1);

		// add empty options for select2
		var type = VacationTypeModel.new();
		type.setName('');
		arrayPrepend(prc.types, type);

		var user = UserModel.new();
		user.setFirstName('');
		arrayPrepend(prc.users, user);

		if (structKeyExists(rc, "messages")) {
			messageBox.error(messageArray = rc.messages);
		} else {
			messageBox.info(message = "You have #prc.availableDays# available days left!");
		}

		if (structKeyExists(rc, "vacation")) {
			prc.vacation = structKeyExists(rc, "vacation") ? rc.vacation : structNew(); 
			event.setView( view = "Vacations/create", args = "#prc.vacation#", layout = "Modal");
		} else { 
			event.setView( view = "Vacations/create", layout = "Modal");
		}
	}

	function view(event,rc,prc) {
		prc.title = "Vacation";
		prc.smallTitle = "view";
		prc.vacation = VacationModel.get(rc.id);
		prc.rightsToApprove = "";
		statusId = prc.vacation.getStatus().getId();
		
		if (prc.vacation.getIsActive()) {
			statusId = prc.vacation.getStatus().getId();

			switch(statusId) {
				case 1:
				case 2:
				case 3:
					prc.vacation.statusClass = "label-info";
					break;
				case 4:
				case 6:
				case 7:
					prc.vacation.statusClass = "label-danger";
					break;
				case 5:
				case 8:
					prc.vacation.statusClass = "label-success";
					break;
				default:
					prc.vacation.statusClass = "label-info";
				break;
			}

			// check if the FromDate is after current moment => -1
			// and if FromDate is today => 0
			prc.isApprovable = DateCompare(DateFormat(Now()), DateFormat(prc.vacation.getFromDate())) NEQ 1 ? true : false;

			prc.rightsToApprove = UserModel.getSessionUserRightsToApprove(prc.vacation);

			// check for notifications
			notifications = checkNotifications(prc.vacation);

			prc.maxAllowedPaidAlert = notifications.maxAllowedPaidAlert;
			prc.teamUsersAlert = notifications.teamUsersAlert;
			prc.vacationTypeLengthAlert = notifications.vacationTypeLengthAlert;
			prc.vacationLengthAlert = notifications.vacationLengthAlert;

			// check if the user is lead
			prc.isLead = prc.vacation.getUser().getId() EQ prc.vacation.getUser().getTeam().getLead().getId()
				? true : false;

			event.setView( "Vacations/view" );
		} else {
			messageBox.error(message = "The vacation has been deleted!");
			setNextEvent( "Vacations.list" );
		}
	}

	function prepareInsert(event,rc,prc) {
		rc.fromDate = trim(ListFirst(rc.fromToDate, '-'));
		rc.toDate = trim(ListLast(rc.fromToDate, '-'));

		if (StructKeyExists(rc, "vacationId")) {
			var newVacation = VacationModel.get(rc.vacationId);
			if(SESSION.user.id != newVacation.getUser().getId()) {
				messageBox.error(message = "You don't have permisions to edit this vacation!");
				return setNextEvent( "Vacations.list" );
			}

			length = val(VacationModel.get(rc.vacationId).getLength());
			deputyId = val(VacationModel.get(rc.vacationId).getDeputy().getId());
		} else {
			var newVacation = VacationModel.new();
		}
	
		newVacation.populate(
			memento = rc
		);

		var vacationUser = UserModel.get(rc.userId);
		newVacation.setUser(vacationUser);

		var vacationDeputy = UserModel.get(rc.deputyId);
		newVacation.setDeputy(vacationDeputy);

		var vacationType = VacationTypeModel.get(rc.typeId);
		newVacation.setType(vacationType);

		var vacationStatus = VacationStatusModel.get(rc.statusId);
		newVacation.setStatus(vacationStatus);

		prc.validationResults = validateModel(
			target = newVacation, 
			constraints = newVacation.constraints
		);
		
		prc.vacation = newVacation;

		if (!prc.validationResults.hasErrors()) {
			try {
				var result = VacationModel.save(newVacation);
				rc.objectId = newVacation.getId();

				if (!result) {
					throw(
						message = "Not successful submitting of vacation.",
						details = result
					);
				} else {
					// send mail to fill-in
					if (!StructKeyExists(rc, "vacationId")
						OR 
						(
							StructKeyExists(rc, "vacationId") 
								AND 
							deputyId NEQ val(rc.deputyId)
						)
					) {
						MailerModel.mailingActions(
							data = prc.vacation,
							subject = "Fill-in Request"
						);

						if (StructKeyExists(rc, "vacationId")) {
							changeVacationStatus(rc.vacationId, 1);
						}
					}

					messageBox.info("Successful submitting of vacation!");
				}	
				
				setNextEvent( event = "Vacations.view", queryString = newVacation.getId() );
			}
			catch(Any e) {
				writeDump(e);
				abort;
			} 
		} else {
			messageBox.error(messageArray = prc.validationResults.getAllErrors());

			setNextEvent( event = "Vacations.list" );
		}
	}

	function edit(event,rc,prc){
		if (structKeyExists(rc, "id")) {
			prc.vacation = VacationModel.get(rc.id);
		} else {
			prc.vacation = VacationModel.get(rc.getId());
		}

		if(SESSION.user.id != prc.vacation.getUser().getId()) {
			messageBox.error(message = "You don't have permisions to edit this vacation!");
			return setNextEvent( "Vacations.list" );
		}

		if (prc.vacation.getIsActive()) {
			prc.action = "Vacations.prepareInsert";
			prc.title = "Edit Vacation";
			prc.formClass = "vacation";
			
			prc.availableDays = UserModel.get(SESSION.user.id).getVacDays();
			prc.daysLimit = prc.vacation.getType().getDaysLimit();
			prc.users = UserModel.newCriteria(entityName = "Users")
				.isTrue("isActive")
				.ne("id", SESSION.user.id)
				.eq("team", TeamModel.get(SESSION.user.team.id))
				.list();
			prc.types = VacationTypeModel.findAllByIsActive(1);
			
			rc.loggedUser = SESSION.user.id;

			prc.vacation.fromToDate = DateFormat(prc.vacation.getFromDate(), 'mm/dd/yyyy') & ' - ' & DateFormat(prc.vacation.getToDate(), 'mm/dd/yyyy');
			prc.title = "#prc.vacation.getUser().getFirstName()# - #prc.vacation.getType().getName()# Leave";
			
			// check for notifications
			notifications = checkNotifications(prc.vacation);

			prc.maxAllowedPaidAlert = notifications.maxAllowedPaidAlert;
			prc.teamUsersAlert = notifications.teamUsersAlert;
			prc.vacationTypeLengthAlert = notifications.vacationTypeLengthAlert;
			prc.vacationLengthAlert = notifications.vacationLengthAlert;			

			event.setView( view = "Vacations/edit", layout = "Modal" );
		} else {
			messageBox.error(message = "The vacation was deleted.");
			setNextEvent( "Vacations.list" );
		}
	}

	function delete(event,rc,prc){
		prc.title = "Delete Vacation";
		prc.action = "Vacations.deleteVacation";
		prc.vacationId = rc.id;

		event.setView( view = "Vacations/delete", layout = "Modal" );
	}

	function deleteVacation(event,rc,prc) {
		vacation = VacationModel.get(rc.vacationId);

		if (SESSION.user.id != vacation.getUser().getId()) {
			messageBox.error(message = "You don't have permisions to delete this vacation!");
			return setNextEvent( "Vacations.list" );
		}

		vacation.setIsActive(0);
		rc.objectId = rc.vacationId;
		var result = VacationModel.save(vacation);
		
		if (DateCompare(NOW(), vacation.getFromDate()) LT 0) {
			var user = UserModel.get(vacation.getUser().getId());
			userVacDays = val(user.getVacDays());
			vacationLength = val(vacation.getLength());
			user.setVacDays(userVacDays + vacationLength);
			UserModel.save(user);
		}

		if (result) {
			messageBox.info(message = "Successfully deleted vacation!");
		} else {
			messageBox.error(message = "There was a problem deleting vacation!");
		}

		setNextEvent( "Vacations.list" );
	}

	function checkTeamUsersInVacation(startDate, endDate, teamId) {
		result = StructNew();
		vacationsCount = 0;

		maxAllowedUsers = TeamModel.get(teamId).getMaxVacationers();
		result.maxAllowedUsers = maxAllowedUsers;

   		users = UserModel.findAllWhere(entityName = "Users", criteria = {
			isActive = true,
			team = TeamModel.get(teamId)
		});

		var criteria = VacationModel.newCriteria();
		vacationsCount = criteria
            .OR(
                criteria.restrictions.between('fromDate', ParseDateTime(startDate), ParseDateTime(endDate)),
                criteria.restrictions.between('toDate', ParseDateTime(startDate), ParseDateTime(endDate))
            )
            .isIn('user', users).count();
           
		result.vacationsCount = vacationsCount;
		
		return serializeJSON(result);
	}

	function changeVacationStatus(vacationId, statusId) {
		var status = VacationStatusModel.get(statusId);
		var vacation = VacationModel.get(vacationId);

		vacation.setStatus(status);
		VacationModel.save(vacation);

		return;
	}

	function checkNotifications(vacation) {
		teamUsersCheck = deserializeJSON(checkTeamUsersInVacation(
			vacation.getFromDate(), 
			vacation.getToDate(),
			vacation.getUser().getTeam().getId()
		));

		result.maxAllowedPaidAlert = val(vacation.getLength()) GT val(getSetting('maxAllowedVacationDays')) ? val(getSetting('maxAllowedVacationDays')) : 0;
		result.teamUsersAlert = val(teamUsersCheck.MAXALLOWEDUSERS) LT val(teamUsersCheck.VACATIONSCOUNT) ? val(teamUsersCheck.VACATIONSCOUNT) : 0;
		result.vacationTypeLengthAlert = val(vacation.getType().getDaysLimit()) LTE val(vacation.getLength()) ? val(vacation.getType().getDaysLimit()) : 0;
		result.vacationLengthAlert = val(vacation.getLength()) GTE (val(vacation.getUser().getVacDays()) + vacation.getLength()) ? 1 : 0;
	
		return result;
	}
}
