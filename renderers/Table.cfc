<!--- @@Copyright: Copyright (c) 2009 Railo Technologies. All rights reserved. --->
<!--- @@License: --->
<cfcomponent output="false">
	
	<cffunction name="render" access="public" returntype="string">
		<cfargument name="event">
		<cfargument name="opts" default="#{}#">
	
		<cfif Not StructKeyExists(opts, "data")>
			<cfthrow message="data is required to render a table">
		</cfif>
		<cfset data = QueryNew("null")>
		<cfif NOT isQuery(opts.data)>
			<cfset data = opts.data.getQuery()>
		<cfelse>
			<cfset data = opts.data>
		</cfif>

		<cfdump eval=data>
		<cfabort>
	
	
		<cfreturn "table">
	</cffunction>
	
</cfcomponent>