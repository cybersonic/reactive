<cfcomponent output="false">


	<cfscript>
		instance.reactor = ""
		instance.settings = {};
		function init(settings,reactor,controllerService){
			instance.reactor 			= arguments.reactor;
			instance.settings 			= arguments.settings;
			instance.controllerService 	= arguments.controllerService;
			return this;
		}
		
		
		function onMissingMethod(missingMethodName,missingMethodArguments){
			return true;
		}
		
		
		function execute(eventName){
				if(Not ListLen(eventName, ".") EQ 2){
					throw("Event name needs to be in the format <controller>.<action>");
				}
				REQUEST.event.set(instance.settings.eventValue,arguments.event);
				var Controller = instance.controllerService.getController(ListGetAt(eventName,1,"."));
				
				Evaluate("Controller.#ListGetAt(eventName,2,".")#(event)");				
				return;
		}
			
	
	</cfscript>
	<cffunction name="throw" output="false">
		<cfargument name="message">
		<cfthrow message="#arguments.message#">
	</cffunction>
</cfcomponent>