component {
	property name="UserModel" 			inject="User";
	property name="RoleModel" 			inject="Role";
	property name="TeamModel" 			inject="Team";
	property name="VacationTypeModel" 	inject="VacationType";
	property name="VacationStatusModel" inject="VacationStatus";
	property name="messageBox" 			inject="messagebox@cbmessagebox";
	property name="Authentication" 		inject="services.Security";
	property name="VacationModel" 		inject="Vacation";
	property name="MailerModel"			inject="services.Mailer";
	
	function preHandler() {
		prc.title = "Users";
		prc.smallTitle = "list";
		prc.roles = RoleModel.findAllByIsActive(1);
	}

	function index(){
		setNextEvent("Users.list");
	}
	
	function list(event,rc,prc){
		var users = UserModel.findAllByIsActive(1);
		prc.users = users;

		event.setView( view='Users/list' );
	}	
	
	function create(event,rc,prc){
		prc.title = "Create User";
		prc.action = "Users.createUser";
		prc.formClass = "";
		prc.image = "";
		prc.id = "";
		prc.fileField = UserModel.getUserpicService().fileField;

        prc.roles = RoleModel.findAllByIsActive(1);
        prc.team = TeamModel.findAllByIsActive(1);

		event.setView( view="Users/create", layout="Modal" );
	}

	function createUser(event,rc,prc) {
		validateEmail(rc.id, rc.email);

        var salt = Hash(GenerateSecretKey("AES"), "SHA-512");
        var hashedPassword = Hash(rc.password & salt, "SHA-512");

        if(!isNull(UserModel.findByUsername(rc.username))) {
            messageBox.warning("Username already exists");
            prc.title = "Create User";
			prc.action = "Users.createUser";
			prc.formClass = "";
	        prc.roles = RoleModel.findAllByIsActive(1);
        	prc.team = TeamModel.findAllByIsActive(1);

            event.setView( view="Users/create", layout="Modal" );
            return;
        }

		var newUser = UserModel.new();
		var role = RoleModel.get(rc.roleId);
		var team = TeamModel.get(rc.teamId);
		newUser.populate(memento=rc);
		newUser.setPassword(hashedPassword);
		newUser.setSalt(salt);

		// Set role
		newUser.setRole(role);

		// Set team
		newUser.setTeam(team);

		var isCreated = UserModel.save(newUser);
		rc.objectID = newUser.getId();
		if (!isCreated) {
			throw(message='The username has not inserted!', type="DatabaseError", detail="Error whille invokine model.save() method");
		}

		var coordinates = {
			x: rc.x,
			y: rc.y,
			width: rc.width,
			height: rc.height
		};
		var filename = UserModel.saveImage(newUser, coordinates);
		if (filename != "") {
			newUser.setImage(filename);
		} else {
			newUser.setImage(javacast("null", ""));
		}

		UserModel.save(newUser);
		if (rc.roleId EQ 2) {
			team.setLead(newUser);
			TeamModel.save(team);
		}

		setNextEvent("Users.list");
	}
	
	function delete(){
		prc.title = "Delete User";
		prc.action = "Users.deleteUser";
		prc.formClass = "";
		prc.userId = rc.id;

		event.setView( view = "Users/delete", layout = "Modal" );
	}
	
	function deleteUser(event,rc,prc){
		var user = UserModel.get(rc.userId);

		user.setIsActive(0);
		var isDeleted = UserModel.save(user);
		rc.objectID = user.getId();
		if(isDeleted){
			messageBox.info("User is deleted!");
			setNextEvent("Users.index");
		} else {
			messageBox.error("User is not deleted!");
			setNextEvent("Users.index");
		}
	}	

	function edit (event,rc,prc){
		var user = UserModel.get(rc.id);
		if(SESSION.user.role != "Manager" AND SESSION.user.permissions.indexOf('IT') == -1 AND SESSION.user.id != user.getId()) {
			messageBox.error(message = "You don't have permisions to edit this user!");
			return setNextEvent( "Users.list" );
		}

		prc.title = "Edit User";
		prc.formClass = "edit-user";
		prc.id = rc.id;
		prc.username = user.getUsername();
		prc.firstName = user.getFirstName();
		prc.lastName = user.getLastName();
		prc.email = user.getEmail();
		prc.roleId = user.getRole().getId();
		prc.teamId = user.getTeam().getId();
        prc.image = IsNull(user.getImage()) ? "" : user.getImage();
        prc.vacDays = user.getVacDays();
        prc.roles = RoleModel.findAllByIsActive(1);
        prc.team = TeamModel.findAllByIsActive(1);
		prc.action = "Users.editUser";
		prc.fileField = user.getUserpicService().fileField;

		event.setView( view="Users/edit", layout="Modal" );
	}

	function editImage(event, rc, prc) {
		if(SESSION.user.role != "Manager" AND SESSION.user.permissions.indexOf('IT') == -1 AND SESSION.user.id != user.getId()) {
			messageBox.error(message = "You don't have permisions to edit this user!");
			return setNextEvent( "Users.list" );
		}

		prc.id = rc.id;
		prc.title = "Change Image";
		prc.action = "Users.changeImage";
		prc.formClass = "";
		prc.fileField = UserModel.getUserpicService().fileField;
		var image = UserModel.get(rc.id).getImage();
		prc.image = IsNull(image) ? "" : image;

		event.setView(view = "Users/partials/userpicFormControls", layout = "Modal");
	}

	function changeImage(event, rc, prc) {
		var user = UserModel.get(rc.id);
		if(SESSION.user.role != "Manager" AND SESSION.user.permissions.indexOf('IT') == -1 AND SESSION.user.id != user.getId()) {
			messageBox.error(message = "You don't have permisions to edit this user!");
			return setNextEvent( "Users.list" );
		}

		var coordinates = {
			x: rc.x,
			y: rc.y,
			width: rc.width,
			height: rc.height
		};
		var filename = UserModel.saveImage(user, coordinates);
		if (filename != "") {
			rc.image = filename;
		} else if (!IsNull(user.getImage())) {
			rc.image = user.getImage();
		}

		user.populate(memento = rc);
		isSaved = UserModel.save(user);
		rc.objectID = user.getId();
		if (isSaved) {
			messageBox.info("Successfully updated user!");
			setNextEvent("Users.list");
		} else {
			messageBox.error("Error");
		}
	}

	private function validateEmail(userId, email) {
		var users = UserModel.getAll();
		var check = "";
		for (user in users) {
			if (userId != "") {	
				check = user.getEmail() == email && user.getId() != userId;
			} else {
				check = user.getEmail() == email;
			}

			if (check) {
				messageBox.error(message = "The email: #email# is existing. Try another email.");
				setNextEvent("Users.list");
			}
		}
	}

	function editUser (event,rc,prc) {
		validateEmail(rc.id, rc.email);

		var users = UserModel.findAllByIsActive(1);
		prc.users = users;

		/*var confirmChanges = Authentication.login(SESSION.User.username, rc.passwordCurrent);

		if (!confirmChanges) {
			messageBox.warning("Wrong password for " & "SESSION.User.username" & ".");
			event.setView( view='Users/list' );
		}*/

		if (rc.passwordNew NEQ "" && rc.passwordNew EQ rc.passwordConfirm) {
	        var salt = Hash(GenerateSecretKey("AES"), "SHA-512");
        	var hashedPassword = Hash(rc.passwordNew & salt, "SHA-512");
			rc.password = hashedPassword;
			rc.salt = salt;
		}

		var user = UserModel.get(rc.id);
		if(SESSION.user.role != "Manager" AND SESSION.user.permissions.indexOf('IT') == -1 AND SESSION.user.id != user.getId()) {
			messageBox.error(message = "You don't have permisions to edit this user!");
			return setNextEvent( "Users.list" );
		}
		
		var coordinates = {
			x: rc.x,
			y: rc.y,
			width: rc.width,
			height: rc.height
		};
		var filename = UserModel.saveImage(user, coordinates);
		if (filename != "") {
			rc.image = filename;
		} else if (!IsNull(user.getImage())) {
			rc.image = user.getImage();
		}

		user.populate(memento = rc);
		isSaved = UserModel.save(user);
		rc.objectID = user.getId();
		if (isSaved) {
			messageBox.info("Successfully updated user!");
			setNextEvent("Users.list");
		} else {
			messageBox.error("Error");
		}
	}

	function view (event, rc, prc) {
		prc.title = "User";
		prc.smallTitle = "profile";
		prc.user = UserModel.get(rc.id);
		prc.user.usedVacations = getUsedVacationDays(rc.id);
		
		event.setView('Users/view');
	}

	//TODO: Methods confirm and request
	function confirmation (event,rc,prc) {
		prc.vacation = VacationModel.get(2);
		event.setView( view='Users/confirmation' );
		// Send mail
	}

	function reject () {
		dump('reject');
		abort;
	}

	function approve () {
		dump('approve');
		abort;
	}
	
	function getUsedVacationDays(userId){
		prc.vacationTypes = VacationTypeModel.findAllByIsActive(1);
		prc.user.usedVacations = ArrayNew(1);
		
		for(vacationTypeObj in  prc.vacationTypes){
			
			var vacType = StructNew();
			vacType.ID = vacationTypeObj.getId();
			vacType.Name = vacationTypeObj.getName();
			vacType.UsedDays = checkUsedVacation(userId, vacType.ID);
			
			arrayAppend(prc.user.usedVacations, vacType);
		}
		
		return prc.user.usedVacations;
	}
	
	function checkUsedVacation(userId, typeId) {
		var userVacation = UserModel.get(userID).getVacations();
		
		usedVacation = 0; 

		for (vacation in userVacation) {
			if (
				!vacation.getIsActive() 
				OR vacation.getType().getId() NEQ typeId
			) {
				continue;
			}

			// checks for vacations in the begging of the current year
			if (DateDiff("y", Year(vacation.getFromDate()), Year(Now())) GT 0
				AND DateDiff("y", Year(vacation.getToDate()), Year(Now())) EQ 0) {
				startDate = CreateDate(Year(Now()), 1, 1);
				endDate = vacation.getToDate();
				
				while (startDate LT endDate) {
					startDate = dateAdd('d', 1, startDate);
					if (!listFind('1,7', dayOfWeek(startDate))) {
						usedVacation++;
					}
				}
			} 
			// check for vacations in the end of the current year
			else if (DateDiff("y", Year(vacation.getFromDate()), Year(Now())) EQ 0
				AND DateDiff("y", Year(vacation.getToDate()), Year(Now())) LT 0) {
				startDate = vacation.getFromDate();
				endDate = CreateDate(Year(Now()), 12, 31);
				
				while (startDate LT endDate) {
					startDate = dateAdd('d', 1, startDate);
					if (!listFind('1,7', dayOfWeek(startDate))) {
						usedVacation++;
					}
				}
			} 
			// checks for vacations in the current year
			else {
				usedVacation += vacation.getLength();
			}
		}
		
		return usedVacation;
	}

	function mailingPrepare(event, rc, prc) {
		action = rEReplace(rc.objectAction, "([a-z])([A-Z])", "\1 \2", "ALL");	
		data = VacationModel.get(rc.vacationId);	
		status = VacationStatusModel.findWhere({ name = action });
		subject = status.getName();
		userRole = data.getUser().getRole().getId();

		if (action NEQ "Fill-in Request") {
			data.sendTo = checkSendTo(userRole);
		}
				
		if (action EQ "Team Lead Approved" OR action EQ "Manager Approved") {
			UserModel.calculateUserVacDays(data.getUser().getId(), data.getLength());

			if (data.getUser().getRole().getId() EQ 3) {
				data.approvedBy = "Lead";
			} else {
				data.approvedBy = "Manager";
				data.sendFromEmail = UserModel.get(SESSION.user.id).getEmail();
				data.sendFromFirstName = UserModel.get(SESSION.user.id).getFirstName();
				data.sendFromLastName = UserModel.get(SESSION.user.id).getLastName();
			}
		}

		if (action EQ "Manager Rejected") {
			UserModel.calculateUserVacDays(data.getUser().getId(), (data.getLength() * -1));
			data.sendFromEmail = UserModel.get(SESSION.user.id).getEmail();
			data.sendFromFirstName = UserModel.get(SESSION.user.id).getFirstName();
			data.sendFromLastName = UserModel.get(SESSION.user.id).getLastName();
		}
		
		rc.objectId = rc.vacationId;

		data.setStatus(status);

		if (StructKeyExists(rc, "rejectedMessage")) {
			data.setRejectedMessage(rc.rejectedMessage);
		}
		
		VacationModel.save(data);			
		MailerModel.mailingActions(data, subject);

		setNextEvent( event = "Vacations.view", queryString = "#rc.vacationId#" );
	}

	function writeRejectedMessage(event,rc,prc){
		prc.title = "Message";
		prc.action = "Users.mailingPrepare";
		prc.vacationId = rc.id;
		prc.objectAction = rc.rejectedBy & " Rejected";
		prc.objectName = "Vacation";
		prc.responsible = rc.rejectedBy;
		prc.vacationId = rc.id;
		prc.formClass = "";

		event.setView( view = "Vacations/rejectedMessage", layout = "Modal" );
	}
	function sessionUserImage(event, rc, prc) {
		var user = UserModel.get(SESSION.user.id);
		if (IsNull(user.getImage()) || user.getImage() == "") {
			userImage = "/includes/images/no-user-image.png";
		} else {
			userImage = APPLICATION.files.server & "users/" & user.getImage();
		}
		
		var mimeType = FileGetMimeType(userImage);

		cfheader(name = "Content-Type", value = mimeType);
		cfcontent(file = userImage);
	}

	function getImage(event, rc, prc) {
		var userImage = "";
		if (rc.image == "") {
			userImage = "/includes/images/no-user-image.png";
		} else {
			userImage = APPLICATION.files.server & "users/" & rc.image;
		}

		var mimeType = FileGetMimeType(userImage);
		cfheader(name = "Content-Type", value = mimeType);
		cfcontent(file = userImage);
	}

	function checkSendTo(userRole) {
		var sendTo = StructNew();
		sendToApprove = "";
		sendToNotify = "";

		switch(userRole){
			case 1:
				// role Team Lead
				roleToApprove = "2,4,5";
				roleToNotify = "";
				break;
			case 2:
				// role Manager
				roleToApprove = "4,5";
				roleToNotify = "";
				break;
			case 3:
			case 4:
			case 5:
				roleToApprove = "";
				roleToNotify = "2";
				break;	
			default:
				roleToApprove = "2";
				roleToNotify = "2";
				break;
		}

		if (roleToApprove NEQ "") {
			for (role in roleToApprove) {
				users = UserModel.findAllWhere({role = RoleModel.get(role)});
				for (user in users) {
					sendToApprove = ListAppend(sendToApprove, user.getEmail()); 
				}
			}
		}

		if (roleToNotify NEQ "") {
			for (role in roleToNotify) {
				users = UserModel.findAllWhere({role = RoleModel.get(role)});
				for (user in users) {
					sendToNotify = ListAppend(sendToNotify, user.getEmail()); 
				}
			}
		}
		
		sendTo.sendToApprove = sendToApprove;
		sendTo.sendToNotify = sendToNotify;

		return sendTo;
	}

	function checkEmail(email) {
		var users = UserModel.getAll();
		for (user in users) {
			if (user.getEmail() == email) {
				return false;
			}
		}

		return true;
	}

}
