// component 
// {
// 	// Pre execution process
// 	function preProcess( requird any event, required struct interceptData ) {
// 		var prc = event.getPrivateCollection();
// 		var rc	= event.getCollection();
// 		var loggingIn = false;
// 		//var sessionStorage = getInstance( 'sessionStorage@cbstorages' );
// 		var messageBox = getInstance( 'messagebox@cbmessagebox' );
		
// 		event.setSESBaseURL( "http://" & cgi.http_host );
		
// 		// Is the user logging in
// 		if ( event.getCurrentEvent() EQ "Security.loginUser"
// 			OR event.getCurrentEvent() EQ "Security.login" ) {
// 			loggingIn = true;
// 		}

// 		// Login Check
// 		//if ( (NOT sessionStorage.exists("isLoggedIn") OR NOT sessionStorage.getVar("isLoggedIn") ) 
// 		if ( (NOT structKeyExists(SESSION, "User") OR NOT structKeyExists(SESSION.User, "id")) AND NOT loggingIn ) {
// 			// Override the incoming event.
// 			Event.overrideEvent("Security.login");
// 			if( messageBox.isEmptyMessage() ) {
// 				messageBox.warn("Please log in to access the Application");
// 			}
// 		} else {
// 			/************************ NAVIGATION EXIT HANDLERS ***********************************/
// 			// Global Exit Handlers
// 			//prc.xehViewOrders 	= "Orders.viewOrders";
// 			prc.goToURL = CGI.HTTP_REFERER;
// 		}
// 	}
// }