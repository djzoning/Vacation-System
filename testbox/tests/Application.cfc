/**
* Copyright Since 2005 Ortus Solutions, Corp
* www.ortussolutions.com
**************************************************************************************
*/
component{
	this.name = "A TestBox Runner Suite " & hash( getCurrentTemplatePath() );
	// any other application.cfc stuff goes below:
	this.sessionManagement = true;

	// any mappings go here, we create one that points to the root called test.
	this.mappings[ "/tests" ] = getDirectoryFromPath( getCurrentTemplatePath() );
	// Map back to its root
	rootPath = REReplaceNoCase( this.mappings[ "/tests" ], "tests(\\|/)", "" );
	this.mappings[ "/testbox" ] = rootPath;
	
	// Map CBORM
	this.mappings[ "/cborm" ]   		= "/modules/cborm";
    this.ormEnabled       				= true;
    this.datasource          			= "Vacation";
    this.ormSettings      				= {
        cfclocation 		= "models",
        dbcreate    		= "update",
        logSQL         		= true,
        flushAtRequestEnd 	= false,
        autoManageSession 	= false,
        eventHandling       =  true,
        eventHandler      	= "cborm.models.EventHandler"
    };

	// Map resources
	this.mappings[ "/coldbox" ] = this.mappings[ "/tests" ] & "resources/coldbox";
	
	// any orm definitions go here.

	// request start
	public boolean function onRequestStart( String targetPage ){
		return true;
	}
}