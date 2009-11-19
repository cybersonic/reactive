<cfcomponent output="false" extends="Controller">

	<cfscript>
		
		instance.scaffold = "list,edit,delete,save,view";
		instance.record = "";
		instance.gateway = "";
		instance.object = "";
		function onRequestStart(event){
			var l = {};
			if(ListFindNoCase(instance.scaffold, event.getControllerAction())){
				Evaluate(event.getControllerAction() & "(event)");			
			}
			
			if(NOT FileExists(expandPath(event.getView()))){
				event.setView("/reactive/scaffold/#event.getControllerAction()#.cfm");
			}
			
		}
		
		
	
	</cfscript>
	
	<cffunction name="list" access="private" output="false">
		<cfargument name="event">
				<cfscript>
					var objectGateway = getGateway(instance.object);
				</cfscript>
				
				
			<cfdump var="#objectGateway#">
		
			
			<cfabort>
		<!--- What are we scaffolding? --->
		
	</cffunction>
	
	
	<cffunction name="edit" access="private" output="false">
		<cfargument name="event">

	</cffunction>

	<cffunction name="delete" access="private" output="false">
		<cfargument name="event">

	</cffunction>
	
	<cffunction name="save" access="private" output="false">
		<cfargument name="event">

	</cffunction>
	
	<cffunction name="save" access="private" output="false">
		<cfargument name="event">

	</cffunction>
	<cffunction name="view" access="private" output="false">
		<cfargument name="event">

	</cffunction>

</cfcomponent>