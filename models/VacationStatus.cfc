/**
* A cool VacationStatus entity
*/
component persistent="true" table="VacationStatus" extends="cborm.models.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" column="id" generator="native" setter="false";
	
	// Properties
	property name="name" ormtype="string";
	property name="isActive" ormtype="boolean" default="true";
	property name="category" ormtype="string";
	
	property name = "vacations" cfc = "Vacation" fkcolumn = "statusId" fieldtype = "one-to-many";

	// Validation
	this.constraints = {
		// Example: age = { required=true, min="18", type="numeric" }
	};
	
	public function addInitStatus(){
		var pendingStatus = findWhere({'name' = 'Pending'});
	
		if(! isNull(pendingStatus)) {
			return true;
		}

		var newStatus = new();
		newStatus.setName('Pending');
		newStatus.setCategory('Pending');
		// writeDump(newStatus); abort;
		save(newStatus);
		
		return save(newStatus);	
	}

	// Constructor
	function init(){
		super.init( useQueryCaching="false" );
		return this;
	}
}

