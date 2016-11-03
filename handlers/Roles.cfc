component{
	property name="RoleModel" inject="Role";
	property name="messageBox" inject="messagebox@cbmessagebox";
	
	function preHandler() {
		prc.title = "Roles";
		prc.smallTitle = "list";
        prc.objectName = "Role";
        prc.objectID = "";
	}

	function index(event,rc,prc){
		setNextEvent("Roles/list");
	}	
	
	function list(){
		var roles = RoleModel.new();
		roles = roles.findAllByIsActive(1);
		prc.roles = roles;
		
		event.setView("Roles/list");
	}
	
	function create(){
		prc.title = "Create Role";
		prc.action = "Roles.add";
		prc.formClass = "";
		event.setView(view="Roles/create", layout="Modal");
	}

	function add(event,rc,prc){
		prc.title = "Add Role";
		var role = RoleModel.findByName(rc.name);

		if(isNull(role)){
			role = RoleModel.new();
		}
		role.setName(rc.name);
		role.setIsActive(1);

		var isSet = RoleModel.save(role);
		rc.ObjectId = role.getId();

		if (isSet) {
			messageBox.info("Role " & rc.name & " is added!");
			setNextEvent("Roles/index");
		} else {
			messageBox.error("There was a problem saving role " & rc.name & "!");
			setNextEvent("Roles/index");
		}
	}	

	function delete(event,rc,prc){
		prc.title = "Delete Role";
		prc.action = "Roles.deleteRole";
		prc.formClass = "";
		prc.roleId = rc.id;

		event.setView( view = "Roles/delete", layout = "Modal" );
	}
	
	function deleteRole(event,rc,prc){
		var role = RoleModel.get(rc.roleId);
		role.setIsActive(0);
		RoleModel.save(role);
		rc.ObjectId = role.getId();
		messageBox.info("Successfully deleted role!");
		setNextEvent("Roles.index");
	}

	function edit(event,rc,prc){
		prc.id = rc.id;
		prc.action = "Roles.save";
		prc.title = "Edit Role";
		prc.formClass = "";
		prc.role = RoleModel.get(rc.id);
		event.setView(view = "Roles/edit", layout="Modal");
	}

	function save(event,rc,prc){
		var role = RoleModel.get(rc.id);
		role.setName(rc.name);
		RoleModel.save(role);
		rc.ObjectId = role.getId();
		messageBox.info("Successfully updated role!");
		setNextEvent("Roles.index");
	}
}