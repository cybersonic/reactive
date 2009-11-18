<cfcomponent output="false">
	
	<cffunction name="init" access="public" returntype="Renderer">
		<cfreturn this>
	</cffunction>
	
	<cfscript>
		instance.settings = {};
		instance.renderers = {};
		function init(settings){
			instance.settings = settings;
			return this;
		}
		function render(renderType,event,opts={}){
			
			//see if there is an override renderer, and use it, or use the base renderer or just fail and go hurrumph
			//we might also cache this
			var renderer = "";
			if(StructKeyExists(instance.renderers, renderType)){
				return instance.renderers[renderType].render(event,opts);
			}
			
			if(FileExists(expandPath("/renderers/#renderType#.cfc"))){
				instance.renderers[renderType] = CreateObject("component", "renderers.#renderType#");
				return instance.renderers[renderType].render(event,opts);
			}
			else {
				instance.renderers[renderType] = CreateObject("component", "reactive.renderers.#renderType#");
				return instance.renderers[renderType].render(event,opts);
			}
		}
	</cfscript>
	
</cfcomponent>