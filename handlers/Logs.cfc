component extends="coldbox.system.EventHandler"{
	property name="logModel" inject="Log";
	property name="logActionModel" inject="LogAction";
	property name="securityService" inject="services.Security";

	function preHandler( event, rc, prc, action, eventArguments){
		prc.title = 'Logs';
		prc.smallTitle = 'Logs';
	}

	function index(event,rc,prc){
		setNextEvent("Logs.list");
	}

	function list(event,rc,prc) {
		var criteria = {};

		if(structKeyExists(rc, 'handler') AND rc.handler NEQ "") {
			criteria.handler = rc.handler;
		}

		if(structKeyExists(rc, 'action') AND rc.action NEQ "") {
			criteria.action = rc.action;
		}
		
		prc.logs = logModel.findAllWhere(criteria, 'timeStamp desc');
		event.setView(view = 'Logs/index');
	}

	function logActions( event, rc, prc ){
		var criteria = {};

		if(structKeyExists(rc, 'objectName') AND rc.objectName NEQ "") {
			criteria.objectName = rc.objectName;
		}

		if(structKeyExists(rc, 'objectId') AND rc.objectId NEQ "") {
			criteria.objectId = rc.objectId;
		}
		
		prc.logs = logActionModel.findAllWhere(criteria, 'timeStamp desc');

		event.setView( "Logs/logActions" );
	}

	function view(event,rc,prc) {
		prc.log = logModel.get(rc.id);
		event.setView(view = 'Logs/view');	
	}
}