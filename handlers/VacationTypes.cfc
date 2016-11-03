component{
	
	property name="messageBox" inject="messagebox@cbmessagebox";
	property name="VacationTypeModel" inject="VacationType";

	function preHandler(){
		prc.title = "Vacation Types";
		prc.smallTitle = "list";
		prc.objectName = "VacationType";
		prc.objectID = "id";
	}
	
	function index(event,rc,prc){
		setNextEvent("vacationTypes/list");	
	}

	function list(event,rc,prc){
		prc.VacationType = VacationTypeModel.findAllByIsActive(1);
		event.setView( "vacationTypes/list" );
	}

	function create(event,rc,prc) {
		prc.title = 'Create Vacation Type';
		prc.action = 'vacationTypes.add';
		prc.formClass = 'createType';
		vacationTypes = vacationTypeModel.new();
		prc.vacationTypes = vacationTypes.getAll();
		event.setView(view = 'vacationTypes/create', layout = "modal");
	}

	function add( event, rc, prc ){
		prc.existVacationTypes = vacationTypeModel.getAll();
		prc.existVacationTypes = vacationTypeModel.findAllByIsActive(1);
		if(isNull(prc.existVacationTypes[1].findByName(rc.name))){
			var VacationType = VacationTypeModel.new();
			prc.vacationType = VacationType;
			VacationType.populate(memento = rc);
			var isSuccess = VacationTypeModel.save(VacationType);
			rc.ObjectId = vacationType.getId();
			
		}else{
			
			messageBox.warning("The vacation type is allready exists.");

		}	
		setNextEvent("VacationTypes/list");
	 // 	if(rc.name EQ ""){
		// 	
		// }else{
			
		// }
	 }

	function edit(event,rc,prc){
		prc.title = 'Edit Vacation Type';
		prc.action = 'vacationTypes.update';
		prc.formClass = '';
		prc.vacationType = vacationTypeModel.get(rc.id);
		event.setView( view = "vacationTypes/edit", layout="Modal" );
	}

	function update( event, rc, prc ){
		var vacationType = vacationTypeModel.get(rc.id);
		vacationType.populate(memento = rc);
		var isSuccess = vacationTypeModel.save(vacationType);
		rc.ObjectId = vacationType.getId();
		messageBox.info("Successfully updated vacation type!");
		setNextEvent('vacationTypes/index');
	}
		
	function delete(event,rc,prc){
		prc.title = "Delete Vacation Type";
		prc.action = "VacationTypes.deleteType";
		prc.formClass = "";
		prc.vacationTypeId = rc.id;

		event.setView( view = "VacationTypes/delete", layout = "Modal" );
	}
	
	
	function deleteType(event,rc,prc){
		var vacationType = vacationTypeModel.get(rc.vacationTypeId);
		if(vacationType.getIsActive(default = true)){
			vacationType.setIsActive(default = false);
			vacationType.populate(memento = rc);
			var successDelete = vacationTypeModel.save(vacationType);
			rc.ObjectId = vacationType.getId();
			
			messageBox.info("Successfully deleted vacation type!");
			setNextEvent( "vacationTypes/index" );
		}else{
			setNextEvent( "vacationTypes/index" );
		}	
	}

	function checkMaxLength(typeId) {
		var daysLimit = VacationTypeModel.get(typeId).getDaysLimit();
		
		return isNull(daysLimit) ? 0 : daysLimit;
	}

	function getTypesByName(typename) {
		var types = VacationTypeModel.findAllByName(typename);
		writeOutput(ArrayLen(types));
		exit;
	}
}
