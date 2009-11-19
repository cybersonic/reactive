<cfcomponent output="false" extends="reactive.Application">
	<cfscript>
		this.name = "YourApplicationName";
		this.friendlyName = "A friendly name for your application";
		this.datasource = "yourappdsn";
		instance.reactor = {
				dsn = this.datasource,
				project = this.name,
				mapping = "/model",
				type = "mysql",
				mode = "production",
				configPath = "/config/reactor.xml.cfm"
		}
		instance.settings.reload = false;
	</cfscript>
</cfcomponent>