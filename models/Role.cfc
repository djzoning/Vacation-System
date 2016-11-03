/**
* A cool Role entity
*/
component persistent="true" table="Role" extends="cborm.models.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" column="id" generator="native" setter="false";
	
	// Properties
	property name="name" ormtype="string";
	property name="isActive" ormtype="boolean" default=1;
	
	// Validation
	this.constraints = {
		// Example: age = { required=true, min="18", type="numeric" }
	};
	
	// Constructor
	function init(){
		super.init( useQueryCaching="false" );
		return this;
	}
}

