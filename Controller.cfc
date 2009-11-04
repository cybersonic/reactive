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
				var Controller = instance.controllerService.getController(ListGetAt(eventName,1,"."));
				REQUEST.event.set(instance.settings.eventValue,arguments.eventName);
				
				Evaluate("Controller.#ListGetAt(eventName,2,".")#(REQUEST.event)");				
				return;
		}
			
		function getRecord(objectName){
			return instance.reactor.createRecord(objectName);
		}
		function getGateway(objectName){
			return instance.reactor.createGateway(objectName);
		}
	
	</cfscript>
	<cffunction name="throw" output="false">
		<cfargument name="message">
		<cfthrow message="#arguments.message#">
	</cffunction>
	
	<cffunction name="redirect">
		<cfargument name="url">
		<cflocation url="index.cfm?#instance.settings.eventValue#=#arguments.url#" addtoken="false">
	</cffunction>

</cfcomponent>