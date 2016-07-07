<cfquery name="getPlayers" datasource="metro">
	select 	p.*
	from players p
	inner join player_event pe on  p.player_id = pe.player_id
	where event_id = 2
	order by p.first_name
</cfquery>

<cfdump var="#getPlayers#">

<cfoutput query="getPlayers">

	<cfquery name="getPostponedCount" datasource="metro">
		select count(fixture_id) AS postponedCount
		from fixtures f
		where f.event_id = 2
		and f.status_id = <cfqueryparam cfsqltype="cf_sql_integer" value="6">
		and (
			f.home_player_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#getPlayers.player_id#"> 
			OR 
			f.away_player_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#getPlayers.player_id#"> 
			)
	</cfquery>

	<p>#getPostponedCount.postponedCount# - #first_name# #last_name#</p>

</cfoutput>