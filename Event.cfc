<cfcomponent output="false">
		<cfscript>
			instance.values		= {};
			instance.settings	= {};
			instance.controller = {};
			instance.errors 	= {};
						
			function init(settings){
				instance.settings = arguments.settings;
				for(var i=1;i LTE ListLen(instance.settings.scopePrecidence); i++){
					var scope = ListGetAt(instance.settings.scopePrecidence,i);
					var scopeStruct = Evaluate(scope);
					StructAppend(instance.values,scopeStruct,true);	
				}
				return this;
			}
			
			function setController(controller){
				instance.controller = arguments.controller;
			}
			function getController(){
				return instance.controller;
			}
			function get(keyName, keyDefaultValue=""){
				if(StructKeyExists(instance.values, keyName)){
					return instance.values[keyName];
				}
				return keyDefaultValue;
			}
		
			function set(keyName, keyValue){
				instance.values[keyName] = keyValue;
			}
		
			//getthe view
			function getView(){
				return instance.settings.viewpath & getControllerName() & "/" & getControllerAction() & ".cfm";
			}
			
			function setView(view){
				instance.controller.action = arguments.view;
			}
		
			function getLayout(){
				if(StructKeyExists(instance.settings, "layout")){
					return instance.settings.layoutpath & instance.settings.layout & ".cfm";
				}
				return instance.settings.layoutpath & instance.settings.defaultLayout & ".cfm";
			}
			
			function setLayout(layout){
				instance.settings.layout = arguments.layout;
			}

		
			function getAll(){
				return instance.values;
			}
			
			function exists(keyName){
				return StructKeyExists(instance.values, keyName);
			}
			
			function addError(name,error){
				instance.errors[name] = error;
			}
			
			
			function hasErrors(name = ""){
				
				if(NOT StructIsEmpty(instance.errors)){
						return true;
				}
				return false;
			}
			
			function hasError(name=""){
				if(StructKeyExists(instance.errors,arguments.name)){
					return true;
				}
				
				return false;
			}
			
			function getErrors(){
				return instance.errors;
			}
			
			function getError(name){
				if(Len(arguments.name) AND StructKeyExists(instance.errors,arguments.name)){
					return instance.errors[arguments.name];
				}
			}
			
			function writeError(name,template="${error}"){
				if(hasError(name)){
				return Replace(arguments.template, "${error}", getError(name));
				}
				return "";
			}
			
			
			function getControllerName(){
				var EventName = get(instance.settings.eventValue, instance.settings.defaultEvent);
				if(Len(ListGetAt(EventName,1,"."))){
					return ListGetAt(EventName,1,".");
				}
				return ListGetAt(instance.settings.defaultEvent,1,".");
			}
			
			function getControllerAction(){
				var EventName = get(instance.settings.eventValue,instance.settings.defaultEvent);
				if(ListLen(EventName,".") GTE 2){
					return ListGetAt(EventName,2,".");
				}
				return ListGetAt(instance.settings.defaultEvent,2,".");
			}
			
			function setControllerService(ControllerService){
				instance.ControllerService = arguments.ControllerService;
			}
		</cfscript>
		
		<cffunction name="renderView">
			<cfset var event = this>
			<cfinclude template="#event.getView()#">
		</cffunction>
</cfcomponent>