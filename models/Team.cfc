/**
* A cool Team entity
*/
component persistent = "true" table = "Team" extends = "cborm.models.ActiveEntity"{

	// Primary Key
	property name = "id" fieldtype = "id" column = "id" generator = "native" setter = "false";
	
	// Properties
	property name = "name" ormType = "string";
	property name = "maxVacationers" ormType = "int";
	property name = "isActive" ormType = "boolean" default = "1";
	
	property name = "lead" cfc = "User" fieldtype = "one-to-one" fkcolumn = "leadId";
	property name = "users" singularname = "user" cfc = "User" fkcolumn = "teamId" fieldtype = "one-to-many" type = "array";
	// Validation
	this.constraints = {
		name = { required = true }
	};
	
	// Constructor
	function init(){
		super.init( useQueryCaching = "false" );
		return this;
	}
}

