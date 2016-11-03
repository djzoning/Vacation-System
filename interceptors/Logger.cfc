component {
	property name="logModel" inject="Log";
	property name="logActionModel" inject="LogAction";
	property name="mailer" inject="services.Mailer";

	this.logGet = false;

    function postProcess(event) {
    	try {
			var rc	= event.getCollection();
    		var memento = structNew();

    		memento.httpMethod = event.gethttpMethod();
    		if(!this.logGet AND memento.httpMethod EQ 'GET') {
	    		return;
	    	}

    		memento.action = event.getCurrentAction();
	    	memento.handler = event.getCurrentHandler();
	    	memento.htmlBaseUrl = event.getHtmlBaseUrl(); 
	    	memento.sesBaseUrl = event.getSesBaseUrl(); 
	    	memento.rc = serializeJson(rc);
	    	memento.timeStamp = now();

	    	if(structKeyExists(SESSION,"user")) {
	    		memento.User = SESSION.User.Id;
	    	}

	    	if(structKeyExists(rc,"ObjectId")) {
	    		var logAction = logActionModel.new();
				memento.ObjectName = rc.ObjectName;
				memento.ObjectAction = rc.ObjectAction;
				memento.ObjectId = rc.ObjectId;
				logAction.populate(memento = memento)
				logActionModel.save(logAction);
	    	}
	    	else {
	    		logRecord = logModel.new();
		    	logRecord.populate(memento = memento);
		    	logModel.save(logRecord);
	    	}
    	}
    	catch(any ex) {
    		mailer.sendErrorMail(ex);
    	}
    }
}
