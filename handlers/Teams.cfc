component {
	property name = "TeamModel" 	inject = "Team";
	property name = "UserModel" 	inject = "User";
	property name = "RoleModel" 	inject = "Role";
	property name = "messageBox" 	inject = "messagebox@cbmessagebox";
	
	function preHandler(){
		prc.title = "Teams";
		prc.smallTitle = "list";
        prc.objectName = "Team";
        prc.objectID = "";
        prc.formClass = "";
	}
	
	function index(event,rc,prc){
		setNextEvent("Teams.list");
	}	

	function list(event,rc,prc){
		prc.teams = TeamModel.findAllByIsActive(1);
		event.setView( "Teams/list" );
	}	

	function create(event,rc,prc){
		prc.title = "Create Team";
		prc.action = "Teams.prepareInsert";
		prc.formClass = "";
		event.setView(view = "Teams/create", layout = "Modal");
	}

	function prepareInsert(event,rc,prc){
		if (StructKeyExists(rc, "teamId")) {
			var newTeam = TeamModel.get(rc.teamId);
		} else {
			var newTeam = TeamModel.new();
		}
		
		if (StructKeyExists(rc, "lead") AND rc.lead EQ "") {
			StructDelete(rc, "lead");
		}
		
		newTeam.populate(memento = rc);

		prc.team = newTeam;

		try {
			var result = TeamModel.save(newTeam);
			rc.ObjectId = newTeam.getId();

			// set team lead 
			if (StructKeyExists(rc, "lead") AND rc.lead NEQ "") {
				var user = UserModel.get(rc.lead);
				
				leadRole = RoleModel.get(rc.lead);
				user.setRole(leadRole);
				UserModel.save(user);
				rc.ObjectId = user.getId();
			}

			if (!result) {
				throw(
					message = "Unsuccessful submitting of team.",
					details = result
				);
			} else {
				messageBox.info("Successfully saved team!");
			}	

			setNextEvent( "Teams.list" );
		}
		catch(Any e) {
			writeDump(e);
			abort;
		} 		
	}	

	function edit(event,rc,prc){
		prc.title = "Edit Team";
		prc.action = "Teams.prepareInsert";
		prc.formClass = "";

		teamId = structKeyExists(rc, "id") ? val(rc.id) : val(rc.getId());
		var user = UserModel.new();

		prc.team = TeamModel.get(teamId);

		prc.users = prc.team.getUsers();
		user.setFirstName('');
		arrayPrepend(prc.users, user);
		
		event.setView(view = "Teams/edit", layout = "Modal" );
	}	

	function delete(event,rc,prc){
		prc.title = "Delete Team";
		prc.modalTitle = "Delete Team";
		prc.action = "Teams.deleteTeam";
		prc.teamId = rc.id;

		event.setView( view = "Teams/delete", layout = "Modal" );
	}

	function deleteTeam(event,rc,prc) {
		team = TeamModel.get(rc.teamId);
		team.setIsActive(0);	
		var result = TeamModel.save(team);
		rc.ObjectId = team.getId();

		if (result) {
			messageBox.info(message = "Successfully deleted #team.getName()# team!");
		} else {
			messageBox.error(message = "There was a problem deleting team!");
		}

		setNextEvent( "Teams.list" );
	}	
}