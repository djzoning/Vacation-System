component persistent="true" table="LogError" extends="Log" joincolumn="id"{
	property name="exception" ormType="text";

	// Constructor
	function init(){
		super.init( useQueryCaching="false" );
		return this;
	}
}