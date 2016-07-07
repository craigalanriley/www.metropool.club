<cfcomponent output="true">
	
	<!--- Application name, should be unique --->
	<cfset this.name = "ApplicationName">
	<!--- How long application vars persist --->
	<cfset this.applicationTimeout = createTimeSpan(0,0,0,0)>
	<!--- Should client vars be enabled? --->
	<cfset this.clientManagement = false>
	<!--- Where should we store them, if enable? --->
	<cfset this.clientStorage = "registry">
	<!--- Where should cflogin stuff persist --->
	<cfset this.loginStorage = "session">
	<!--- Should we even use sessions? --->
	<cfset this.sessionManagement = true>
	<!--- How long do session vars persist? --->
	<cfset this.sessionTimeout = createTimeSpan(0,5,0,0)>
	<!--- Should we set cookies on the browser? --->
	<cfset this.setClientCookies = true>
	
	<!--- define custom coldfusion mappings. Keys are mapping names, values are full paths  --->
	<cfset this.mappings = structNew()>
	<!--- define a list of custom tag paths. --->
	<cfset this.customtagpaths = "">
	
	<cfset this.mappings[ "/cfcPath" ] = "/cfc" />
	
	<cfscript>
	
		objFixtures = CreateObject("component","cfc.fixtures");
		objPlayers 	= CreateObject("component","cfc.players");
		objStats 	= CreateObject("component","cfc.stats");
		
		// writeDump(this.mappings);
	</cfscript>

	


	
	<!--- Run when application starts up --->
	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		
		<cfset Application.metroKey = "gizmo"> 
		<cfset Application.DSN 		= "metro"> 
		
		<cfswitch expression="#CGI.SERVER_NAME#">
			<cfcase value="localhost">
				<cfset Application.Home = "http://localhost:8500/www.metropool.club">
				<cfset Application.MetroAppID = "1482838855321210">
			</cfcase>
			<cfdefaultcase>
				<cfset Application.Home = "http://www.metropool.club">
				<cfset Application.MetroAppID = "1454153441523085">
			</cfdefaultcase>
		</cfswitch>
		
		<cfreturn true>
	</cffunction>

	<!--- Run when application stops --->
	<cffunction name="onApplicationEnd" returnType="void" output="false">
		<cfargument name="applicationScope" required="true">
	</cffunction>

	<!--- Fired when user requests a CFM that doesn't exist. --->
	<cffunction name="onMissingTemplate" returnType="boolean" output="false">
		<cfargument name="targetpage" required="true" type="string">
		<cfreturn true>
	</cffunction>
	
	<!--- Run before the request is processed --->
	<cffunction name="onRequestStart" returnType="boolean" output="false">
		
		
		
		
		<cfif isDefined("URL.peekaboo")>
			<cfset session.peekaboo = true>
		</cfif>
		<cfif isDefined("URL.clearSession")>
			<cfset StructClear(session)>
		</cfif>	
		
		<cfreturn true>
	</cffunction>

	<!--- Runs before request as well, after onRequestStart --->
	<!--- 
	WARNING!!!!! THE USE OF THIS METHOD WILL BREAK FLASH REMOTING, WEB SERVICES, AND AJAX CALLS. 
	DO NOT USE THIS METHOD UNLESS YOU KNOW THIS AND KNOW HOW TO WORK AROUND IT!
	EXAMPLE: http://www.coldfusionjedi.com/index.cfm?mode=entry&entry=ED9D4058-E661-02E9-E70A41706CD89724
	--->
	<cffunction name="onRequest" returnType="void">
		<cfargument name="thePage" type="string" required="true">
		<cfinclude template="#arguments.thePage#">
	</cffunction>

	<!--- Runs at end of request --->
	<cffunction name="onRequestEnd" returnType="void" output="true">
		<cfargument name="thePage" type="string" required="true">
		<cfif isDefined("showSession")>
			<cfdump var="#session#">
		</cfif>
	</cffunction>

	<!--- Runs on error --->
	<cffunction name="onError" returnType="void" output="false">
		<cfargument name="exception" required="true">
		<cfargument name="eventname" type="string" required="true">
		<cfdump var="#arguments#"><cfabort>
	</cffunction>

	<!--- Runs when your session starts --->
	<cffunction name="onSessionStart" returnType="void" output="false">
	</cffunction>

	<!--- Runs when session ends --->
	<cffunction name="onSessionEnd" returnType="void" output="false">
		<cfargument name="sessionScope" type="struct" required="true">
		<cfargument name="appScope" type="struct" required="false">
	</cffunction>
</cfcomponent>