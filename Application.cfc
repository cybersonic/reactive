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
		 
		 instance.reactor = {};
		
		 instance.security = {
		 		securelist			= "app",
		 		redirect			= "home.welcome",
		 		whitelist			= "home,login,register"
		 }
		 
	
		 
		 function onApplicationStart(){
		 	 application.controllerService 	= CreateObject("component", "reactive.ControllerService").init(instance.settings);

			//need to create this using a reactorConfig
 		 	 application.reactor 			= CreateObject("Component", "reactor.reactorFactory").init(expandPath("config/reactor.xml.cfm"));


			 application.Renderer			= CreateObject("Component", "reactive.Renderer").init(instance.settings);
			return true;
		 }
	
		function onRequestStart(thePage){
			if(isDefined("url.init") OR instance.settings.reload){
				onApplicationStart();
			}
			
		
			
			var Event = CreateObject("component", "Event").init(instance.settings); 
				Event.setControllerService(application.controllerService);
				Event.setRenderer(application.Renderer);
			var l = {};
			//Implement some security
			
			
			if(ListFindNoCase(instance.security.securelist,Event.getControllerName()) AND NOT isUserLoggedIn()){
				redirect("#CGI.script_name#?#instance.settings.eventValue#=#instance.security.redirect#");
			
			}
			REQUEST.Event = Event;
			var Controller = application.controllerService.getController(Event.getControllerName());
			//Now call the method that we want
			if(isObject(Controller)){
				if(StructKeyExists(Controller, "onRequestStart")){
					Controller.onRequestStart(Event);
				}
				Evaluate("Controller.#Event.getControllerAction()#(Event)");

			
			}
			
			

			
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