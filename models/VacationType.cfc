/**
* A cool VacationType entity
*/
component persistent="true" table="VacationType" extends="cborm.models.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" column="id" generator="native" setter="false";
	
	// Properties
	property name = "name" ormType="String";
	property name = "daysLimit" ormType="numeric" default ="null";
	property name = "isActive" ormType="boolean" default="1";
 	
	// property name = "vacationTypeId" ormtype = "int" cfc = "Vacation" fkcolumn = "typeId" fieldtype = "one-to-many";
	property name = "vacations" cfc = "Vacation" fkcolumn = "typeId" fieldtype = "one-to-many";

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

