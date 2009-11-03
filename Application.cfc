<cfcomponent output="false">


	<cfscript>
		 this.applicationTimeout = createTimeSpan(0,2,0,0);
		 this.clientManagement = false;
		 this.clientStorage = "registry";
		 this.loginStorage = "session";
		 this.sessionManagement = true;
		 this.sessionTimeout = createTimeSpan(0,0,20,0);
		 
		 instance.settings = {
		 		scopePrecidence 	= "FORM,URL",
		 		layoutpath 			= "/layouts/",
		 		defaultLayout		= "main",
		 		viewpath			= "/views/",
		 		defaultView			= "index",
		 		eventValue			= "action",
		 		defaultEvent		= "home.index",
		 		controllerLocation	= "/controllers/",
		 		controllerPath		= "controllers",
		 		reload				= "true"
		 };
		 
		 instance.security = {
		 		securelist			= "app",
		 		redirect			= "home.welcome",
		 		whitelist			= "home,login,register"
		 	
		 
		 }
		 
	
		 
		 function onApplicationStart(){
		 	 application.controllerService 	= CreateObject("component", "reactive.ControllerService").init(instance.settings);
 		 	 application.reactor 			= CreateObject("Component", "reactor.reactorFactory").init(expandPath("config/reactor.xml.cfm"));
			 return true;
		 }
	
		function onRequestStart(thePage){
			if(isDefined("url.init")){
				onApplicationStart();
			}
			
		
			
			var Event = CreateObject("component", "Event").init(instance.settings); 
				Event.setControllerService(application.controllerService);

			var l = {};
			//Implement some security
			if(ListFindNoCase(instance.security.securelist,Event.getControllerName())){
				redirect("#CGI.script_name#?#variables.settings.eventValue#=#variables.security.redirect#");
			
			}
			
			var Controller = application.controllerService.getController(Event.getControllerName());
			//Now call the method that we want
			if(isObject(Controller)){
				if(StructKeyExists(Controller, "onRequestStart")){
					Controller.onRequestStart(Event);
				}
				Evaluate("Controller.#Event.getControllerAction()#(Event)");

			
			}
			
			

			REQUEST.Event = Event;
			//Now lets see what we are requesting
			return true;
		}
		
		function onRequest(thePage){
			include(REQUEST.Event);
		}
		
		function onRequestEnd(){
			var Controller = application.controllerService.getController(REQUEST.Event.getControllerName())
			if(isObject(Controller)){
				Controller.onRequestEnd();
			}
		}
		
	</cfscript>


	<cffunction name="redirect">
		<cfargument name="url">
		<cflocation url="#arguments.url#" addtoken="false">
	</cffunction>
	<cffunction name="include">
		<cfargument name="event">
		<cfset var Event = arguments.event>
		<cfinclude template="#arguments.event.getLayout()#">
	</cffunction>




</cfcomponent>