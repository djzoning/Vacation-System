component {
	property name="VacationStatusModel" inject="VacationStatus";
	
	function preHandler() {
		prc.title = "Statuses";
		prc.smallTitle = "list";
		prc.objectName = "VacationStatus";
		prc.objectID = "";
	}

	/**
	* index  
	*/
	function index( event, rc, prc ){
		
		setNextEvent("vacationStatuses/list");
	}

	/**
	* create  
	*/
	function create (event, rc, prc){
		prc.action = 'vacation.add';
		var statusName = "#rc.statusName# By #rc.userRole#";
		prc.statuses = vacationStatusModel.getAll();
		if(ArrayIsEmpty(prc.statuses) or (prc.statuses[1].getName() neq statusname)){
			var status = vacationStatusModel.new();
			status.setName(default = "#statusName#");
			status.setIsActive(default = 1);
			var category = Right(rc.statusName, 1) EQ "e" ? "#rc.statusName#d" : "#rc.statusName#ed";
			status.setCategory("#category#");
			status.populate(memento = rc);
			prc.status = vacationStatusModel.save(status);
			prc.actionVar = "create";
		}
		else{
			if((rc.statusName neq "")and(rc.userRole neq "")){
				rc.statusId = status[1].getId();
				prc.actionVar = "create";
			}   
		}
		event.setView("vacationStatuses/create");
	}

	function list(event, rc, prc){
		prc.vacationStatus=vacationStatusModel.findAllByIsActive(1);
		event.setView("vacationStatuses/list")

	}

	/**
	* edit  
	*/

	/**
	* delete  
	*/
	// function delete( event, rc, prc ){
	//     var status = vacationStatusModel.get(rc.statusId);
	//     if(status.getIsActive(default = true)){
	//         status.setIsActive(default = false);
	//         status.populate(memento = rc);
	//         status.save(status);
	//         setNextEvent( "vacationStatuses/index" );
	//     }
	// }

}
