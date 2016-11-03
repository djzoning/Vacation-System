component persistent="true" table="User" extends="cborm.models.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" column="id" generator="native" setter="false";
	
	// Properties
	property name="username" ormtype="string";
	property name="password" ormtype="string";
	property name="salt" ormtype="string";
	property name="vacDays" ormtype="number";
	property name="firstName" ormtype="string";
	property name="lastName" ormtype="string";
	property name="email" ormtype="string";
	property name="role" cfc="Role" fieldtype="many-to-one" fkcolumn="roleId";
	property name="isActive" ormtype="boolean" default = "1";
	property name="image" ormtype="string" default="";

	property name = "vacations" singularname = "vacation" cfc = "Vacation" fkcolumn = "userId" fieldtype = "one-to-many" type = "array";
	property name = "team" cfc = "Team" fieldtype = "many-to-one" fkcolumn = "teamId";
	property name = "UserpicService" inject = "services.UserpicService" persistent = false;
	
	// Validation
	this.constraints = {
		// Example: age = { required=true, min="18", type="numeric" }
	};
	
	// Constructor
	function init(){
		super.init( useQueryCaching="false" );
		return this;
	}
	
	function saveImage(user, coordinates) {
		return UserpicService.saveImage(user, coordinates);
	}

	public function getSessionUserRightsToApprove(vacation) {
		var statusId = vacation.getStatus().getId();
		var userIsLead = !isNull(vacation.getUser().getTeam().getLead()) ? (vacation.getUser().getId() EQ vacation.getUser().getTeam().getLead().getId()
			? true : false) : false;
		var isManager = SESSION.user.role == 'Manager' OR SESSION.user.role == 'CTO' OR SESSION.user.role == 'President'
			? true : false;

		if (vacation.getDeputy().getId() == SESSION.user.id AND statusId <= 2) {
			return "Fill-in";	
		}

		// manager review the request
		if ((isManager AND statusId EQ 5) OR (isManager AND statusId EQ 3)) {
			return "Manager";
		}
		
		// team lead review the request
		if (
			statusId EQ 3 // fill-in approved
				AND
			!isNull(vacation.getUser().getTeam().getLead()) // lead is setup to the team
				AND 
			vacation.getUser().getTeam().getLead().getId() == SESSION.user.id // team lead of the user is logged in
		) {
			if (userIsLead) {
				return "";
			}

			return "TeamLead";
		} 

		return "";
	}

	public function calculateUserVacDays(userId, length) {
		var user = this.get(userId);
		userVacDays = user.getVacDays();

		var newVacDays = userVacDays - length;
		user.setVacDays(newVacDays);

		this.save(user);
	}
}

