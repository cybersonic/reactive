<cfcomponent output ="false">

	<cfscript>
		instance.controllers = {};
		instance.settings = {};
	
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
					dump(excpt);
					abort;
				}			
		
			return "";		
		}
	
		function execute(ControllerAction, event){
		
		
		}	
	
	</cfscript>

</cfcomponent>
