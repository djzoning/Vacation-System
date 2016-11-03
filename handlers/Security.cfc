component  output="false"
{
	property name="messageBox" inject="messagebox@cbmessagebox";
	property name="securityService" inject="services.Security";
	
	// Method Security
	this.allowedMethods = { 
		loginUser = "POST"
		//, 
		//doLostPassword = "POST" 
	};
	
	// Default Action
	function index(event, rc, prc) {
		setNextEvent("Security.login");
	}
	
	function login(event,rc,prc){
		if (structKeyExists(SESSION, "User") AND structKeyExists(SESSION.User, "id")) {
			setNextEvent("Main.index");
		}

		event.setView( view = "Users/login", layout = "Security");
	}

	function loginUser( event, rc, prc ){
		var isLoggedIn = securityService.login(rc.username, rc.password);

		if (isLoggedIn) {
			if(rc['_securedURL'] NEQ "") {
				setNextEvent(uri = rc["_securedURL"]);
				return;
			}

			setNextEvent("Main.index");
		}

		messageBox.error("Invalid Logon Information. Please try again.");
		setNextEvent("Security.login");
	}

	function logout( event, rc, prc ){
		securityService.logout();
		messageBox.warning("You are logged out now. Goodbye!");
		setNextEvent("Security.login");
	}

	function resetPassword(event, rc, prc) {
		var result = securityService.resetPassword(rc.email);
		if(! result) {
			messageBox.warning("Invalid Email.");
		}
		else {
			messageBox.info("Your new password was sent. Please check your E-Mail.");
		}

		setNextEvent("Security.login");
	}
}