<cfcomponent output ="false">

	<cfscript>
		instance.controllers = {};
		instance.settings = {};
		instance.services = {}; //Services we want to inject into controllers
	
		function init(settings){
			instance.settings = arguments.settings;
			return this;
		}
	
	
		function getController(controllerName){
				if(StructKeyExists(instance.controllers, controllerName) AND NOT instance.settings.reload){
					return instance.controllers[controllerName];
				}
				
				try	{
					instance.controllers[controllerName] = CreateObject("component", instance.settings.controllerPath & "." & controllerName).init(instance.settings,application.reactor, this);
					return instance.controllers[controllerName];
				}
				catch(any excpt){
					REQUEST.event.addError("system", "controller '#instance.settings.controllerPath#.#controllerName#' not found");
				}			
		
			return "";		
		}
	
		function execute(ControllerAction, event){
		
		
		}	
	
	</cfscript>

</cfcomponent>
