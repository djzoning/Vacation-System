component extends="coldbox.system.EventHandler" {

	property name="Vacation" inject="Vacation";
	property name="Formatter" inject="services.Formatter";
	property name="Type" inject="VacationType";
	property name="Status" inject="VacationStatus";
	property name="Team" inject="Team";
	property name="User" inject="User";

	function preHandler(event, action, eventArguments, rc, prc) {
		prc.title = "Calendar";
		prc.smallTitle = "";
		prc.objectName = "Calendar";
		prc.objectID = "";
	}

	function index(event,rc,prc){
		var criteria = {isActive: true};
		var userCriteria = StructCopy(criteria);
		if(StructKeyExists(rc, "id")) {
			userCriteria.User = User.get(rc.id);
		}

		var statuses = Status.executeQuery(query = "SELECT DISTINCT category FROM VacationStatus", asQuery = false);

		var vacations = Vacation.findAllWhere(userCriteria);
		var jsonFormatter = new models.services.FullCalendarJSONFormatter();
		var formattedVacations = Formatter.format(collection: vacations, formatter: jsonFormatter);
		var types = Type.findAllWhere(criteria);
		var teams = Team.findAllWhere(criteria);
		var data = {
			vacations: formattedVacations,
			types: types,
			statuses: statuses,
			teams: teams
		}

		event.setView( view = "Calendar/index", args = data );
	}

	function get(event,rc,prc){
		// todo: implement filter by teams, users, type, status
		
		var vacations = Vacation.getAll();
		var jsonFormatter = new models.services.FullCalendarJSONFormatter();
		var formattedVacations = Formatter.format(collection: vacations, formatter: jsonFormatter);
		
		return formattedVacations;
	}
}