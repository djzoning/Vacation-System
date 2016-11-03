component persistent="true" table="LogRequest" extends="cborm.models.ActiveEntity" {

	// Primary Key
	property name="id" fieldtype="id" column="id" generator="identity" setter="false";
	
	// Properties
	property name="action" ormType="String";
	property name="handler" ormType="String";
	property name="htmlBaseUrl" ormType="String";
	property name="sesBaseUrl" ormType="String";
	property name="httpMethod" ormType="String";
	property name="rc" ormType="text";
	property name="timeStamp" ormType="timestamp";
	property name="user" cfc="User" fieldtype="many-to-one" fkcolumn="userId";
	
	// Constructor
	function init(){
		super.init( useQueryCaching="false" );
		return this;
	}

	function getFromPrc(object, property = "") {
		var jsonPrc = this.getPrc();
		var sPrc = deserializeJSON(jsonPrc);
		
		if(structKeyExists(sPrc, object)) {
			result = sPrc[object];
			
			if(ARGUMENTS.property NEQ "" AND structKeyExists(result, property)) {
				result = result[property];
			}

			return result;
		}

		return false;
	}
}