﻿component{

	// Configure ColdBox Application
	function configure(){

		// coldbox directives
		coldbox = {
			//Application Setup
			appName 				= "Vacation Module",
			eventName 				= "event",

			//Development Settings
			reinitPassword			= "",
			handlersIndexAutoReload = true,

			//Implicit Events
			defaultEvent			= "Security.login",
			requestStartHandler		= "",
			requestEndHandler		= "",
			applicationStartHandler = "Main.onAppInit",
			applicationEndHandler	= "",
			sessionStartHandler 	= "",
			sessionEndHandler		= "",
			missingTemplateHandler	= "",

			//Extension Points
			applicationHelper 			= "includes/helpers/ApplicationHelper.cfm",
			viewsHelper					= "",
			modulesExternalLocation		= [],
			viewsExternalLocation		= "",
			layoutsExternalLocation 	= "",
			handlersExternalLocation  	= "",
			requestContextDecorator 	= "",
			controllerDecorator			= "",

			//Error/Exception Handling
			exceptionHandler		= "main.onException",
			onInvalidEvent			= "",
			customErrorTemplate		= "",

			//Application Aspects
			handlerCaching 			= true,
			eventCaching			= false,
			proxyReturnCollection 	= false,
			orm = { 
                injection = {
                    enabled = true
                }
            }
		};

		// Debugger Settings
		debugger = {
		    // Activate debugger for everybody
		    debugMode = false,
		    // Setup a password for the panel
		    debugPassword = "",
		    enableDumpVar = true,
		    persistentRequestProfiler = true,
		    maxPersistentRequestProfilers = 10,
		    maxRCPanelQueryRows = 50,
		    showTracerPanel = true,
		    expandedTracerPanel = true,
		    showInfoPanel = true,
		    expandedInfoPanel = true,
		    showCachePanel = true,
		    expandedCachePanel = false,
		    showRCPanel = true,
		    expandedRCPanel = false,
		    showModulesPanel = true,
		    expandedModulesPanel = false,
		    showRCSnapshots = false,
		    wireboxCreationProfiler=false
		};

		// custom settings
		settings = {
			maxAllowedVacationDays = 5
		};

		// environment settings, create a detectEnvironment() method to detect it yourself.
		// create a function with the name of the environment so it can be executed if that environment is detected
		// the value of the environment is a list of regex patterns to match the cgi.http_host.
		environments = {
			development = "localhost,^lucee,vacation.local,vacation.44km.local"
		};

		// Module Directives
		modules = {
			//Turn to false in production
			autoReload = false,
			// An array of modules names to load, empty means all of them
			include = [],
			// An array of modules names to NOT load, empty means none
			exclude = []
		};

		//LogBox DSL
		logBox = {
			// Define Appenders
			appenders = {
				coldboxTracer = { class="coldbox.system.logging.appenders.ConsoleAppender" }
			},
			// Root Logger
			root = { levelmax="INFO", appenders="*" },
			// Implicit Level Categories
			info = [ "coldbox.system" ]
		};

		//Layout Settings
		layoutSettings = {
			defaultLayout = "Main.cfm",
			defaultView   = "index.cfm"
		};

		//Interceptor Settings
		interceptorSettings = {
			throwOnInvalidStates = false,
			customInterceptionPoints = "log"
		};

		//Register interceptors as an array, we need order
		interceptors = [
			//SES
			{
				class="coldbox.system.interceptors.SES",
				properties={}
			},
			{
				class = "modules.cbsecurity.interceptors.Security", 
				name = "CBSecurity",
				properties = {
					useRegex = true, 
					rulesSource = "json", 
					validatorModel = "Services.Security",
					rulesFile = "config/security.json.cfm"
				}
			},
			{
        		class = "interceptors.Logger",
        		name = "Logger",
	        	properties = {}
	    	}
		];
		
		layouts = [
			{ name = "Security",
		 	  file = "Security.cfm",
			  views = "Security.login"
			}
		];
		
		messagebox = {
			template = "/views/_templates/messagebox.cfm",
    		styleOverride   = true
		};
		
		/*
		// flash scope configuration
		flash = {
			scope = "session,client,cluster,ColdboxCache,or full path",
			properties = {}, // constructor properties for the flash scope implementation
			inflateToRC = true, // automatically inflate flash data into the RC scope
			inflateToPRC = false, // automatically inflate flash data into the PRC scope
			autoPurge = true, // automatically purge flash data for you
			autoSave = true // automatically save flash scopes at end of a request and on relocations.
		};

		//Register Layouts
		

		//Conventions
		conventions = {
			handlersLocation = "handlers",
			viewsLocation 	 = "views",
			layoutsLocation  = "layouts",
			modelsLocation 	 = "models",
			eventAction 	 = "index"
		};

		//Datasources
		datasources = {
			mysite   = {name="mySite", dbType="mysql", username="root", password="pass"},
			blog_dsn = {name="myBlog", dbType="oracle", username="root", password="pass"}
		};
		*/

	}

	/**
	* Development environment
	*/
	function development(){
		coldbox.customErrorTemplate = "/coldbox/system/includes/BugReport.cfm";
		coldbox.handlerCaching = false;
		coldbox.reinitPassword = "";
		coldbox.handlersIndexAutoReload = true;
	}

}
