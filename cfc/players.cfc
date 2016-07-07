<cfcomponent output="true">


	<cffunction name="getEventPlayers" access="public" output="true" returntype="Query">
		<cfargument name="EventID" 		type="numeric" required="true" />
		<cfargument name="HandicapID" 	type="numeric" required="false" default="0" />
		
			<cfquery name="getPlayers" datasource="metro">
				select p.*, CONCAT(`first_name`, ' ', `last_name`) AS full_name
				from players p
				inner join  player_event pe ON p.player_id = pe.player_id
				where pe.event_id = #arguments.EventID#
				<cfif arguments.HandicapID>
				 	and p.handicap_id = #arguments.HandicapID#
				</cfif>
				order by first_name, last_name, player_id
				limit 28
			</cfquery>

		<cfreturn getPlayers />
	</cffunction>
	
	<cffunction name="getPlayerList" access="public" output="true" returntype="any">
		<cfargument name="EventID" 		type="numeric" 	required="false" 	default="1" />
		<cfargument name="HandicapID" 	type="any"	 	required="false" 	default="0" />
		
			<cfscript>
				var PlayerList = "";
			</cfscript>
		
			<cfquery name="getPlayers" datasource="metro">
				select p.player_id
				from players p
				inner join  player_event pe ON p.player_id = pe.player_id
				where pe.event_id = #arguments.EventID#
				<cfif arguments.HandicapID>
				 	and p.handicap_id = #arguments.HandicapID#
				</cfif>
				order by player_id
			</cfquery>
			<cfset PlayerList = ValueList(getPlayers.player_id)>

		<cfreturn PlayerList />
	</cffunction>
	
	
</cfcomponent>