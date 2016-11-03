component extends="coldbox.system.EventHandler"{	
	property name="VacationModel" inject="Vacation";
	property name="UserModel" inject="User";
	property name="LogActionModel" inject="LogAction";

	any function preHandler( event, rc, prc, action, eventArguments ){
		prc.title = "Vacation Module";
		prc.smallTitle = "";
	}

	any function index(event, rc, prc){
		event.setView("dashboard/index");
	}

	function vacations(event, rc, prc, boolean widget = false){
		param name="rc.filter" default="";

		switch(rc.filter){
			case "today" : {
				prc.vacations = VacationModel.getTodayVacations();
				break;
			}

			case "week" : {
				prc.vacations = VacationModel.getThisWeeksVacations();
				break;
			}

			case "month" : {
				prc.vacations = VacationModel.getThisMonthsVacations();
				break;
			}

			default: {
				prc.vacations = VacationModel.getTodayVacations();
			}
		}

		if(structKeyExists(rc, "tableOnly")) {
			return renderView("Dashboard/partials/vacationsTable", prc);
		}
		
		if(ARGUMENTS.widget) {
			return renderView("Dashboard/vacations", prc);
		}

		event.setView( view = "Dashboard/vacations" );
	}

	function quickActions(event, rc, prc, boolean widget = false){
		var completedActions = LogActionModel.getUserSpecialActions(SESSION.user.id, 'mailingPrepare');
		prc.requestsCompleted = VacationModel.getCompletedRequests(completedActions);
		prc.requestsPending = VacationModel.getPendingRequests();
		prc.logAction = LogActionModel;
		prc.UserModel = UserModel;

		if(ARGUMENTS.widget) {
			return renderView("Dashboard/quickactions", prc);
		}

		event.setView( view = "Dashboard/quickactions");
	}

	function usersActions(event, rc, prc, boolean widget = false){
		prc.actionsTo = "Users";
		prc.actions = LogActionModel.list(
			sortOrder = 'timestamp desc',
			max = 20,
			asQuery = false
		);

		if(ARGUMENTS.widget) {
			return renderView("Dashboard/usersActions", prc);
		}

		event.setView( "Dashboard/usersActions" );
	}

	function teamActions(event, rc, prc, boolean widget = false){
		prc.actionsTo = "Team";
		prc.actions = LogActionModel.getTeamActions(SESSION.user.team.id, 10);

		if(ARGUMENTS.widget) {
			return renderView("Dashboard/usersActions", prc);
		}

		event.setView( "Dashboard/usersActions" );
	}

	function recentActivities(event, rc, prc, boolean widget = false, limit = 0){
		param name="rc.id" default="#SESSION.user.Id#";
		prc.userActions = LogActionModel.getUserActions(SESSION.user.Id, ARGUMENTS.limit);

		if(ARGUMENTS.limit != 0) {
			prc.withFooter = true;
		}

		if(ARGUMENTS.widget) {
			return renderView("Dashboard/recentActivities", prc);
		}

		event.setView( "Dashboard/recentActivities" );
	}
}