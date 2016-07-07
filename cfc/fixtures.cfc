<cfcomponent output="true">
	
	<cffunction name="getFixtures" access="public" output="true" returntype="any">
		<cfargument name="roundID" 		type="numeric" 	required="false" 	default="0" />
		<cfargument name="statusID" 	type="string"	required="false" 	default="" />
		<cfargument name="playerID" 	type="any"		required="false" 	default="0" />
		<cfargument name="eventID" 		type="numeric" 	required="false" 	default="1" />
		<cfargument name="Rescheduled" 	type="boolean" 	required="false" 	default="false" />
		
			<cfquery name="qFixtures" datasource="#Application.DSN#">
				/* Not Played */
				select 	f.fixture_id,
						f.home_player_id,
						f.away_player_id,
						f.round,
						f.status_id,
						fs.status,
						f.scheduled_time,
						f.round_rescheduled,
						
						p1.handicap_id AS home_handicap_id,
						p2.handicap_id AS away_handicap_id,
						
						@homeStart := IF(p1.handicap_id > p2.handicap_id, ((p1.handicap_id-p2.handicap_id) * 2), 0) AS homeStart,
						@awayStart := IF(p2.handicap_id > p1.handicap_id, ((p2.handicap_id-p1.handicap_id) * 2), 0) AS awayStart,
						
						@homeStart7 := IF(p1.handicap_id > p2.handicap_id, ((p1.handicap_id-p2.handicap_id) * 1)+1, 0) AS homeStart7,
						@awayStart7 := IF(p2.handicap_id > p1.handicap_id, ((p2.handicap_id-p1.handicap_id) * 1)+1, 0) AS awayStart7,
						
						CONCAT(p1.first_name, ' ', p1.last_name) AS home_player,
						CONCAT(p2.first_name, ' ', p2.last_name) AS away_player,
						
						CONCAT(p1.first_name, '.', left(p1.last_name,2)) AS home_player_short,
						CONCAT(p2.first_name, '.', left(p2.last_name,2)) AS away_player_short,
						
						coalesce(r1.`games_won`, @homeStart) AS homeScore,
						coalesce(r1.`games_lost`, @awayStart) AS awayScore,
						
						coalesce(r1.`games_won`, @homeStart7) AS homeScore7,
						coalesce(r1.`games_lost`, @awayStart7) AS awayScore7,
						
						coalesce(r1.`runouts`, 0) AS homeRunouts,
						coalesce(r2.`runouts`, 0) AS awayRunouts,
						
						coalesce(r1.`lag`, 0) AS homeLag,
						coalesce(r2.`lag`, 0) AS awayLag,
						
						coalesce(r1.`result_id`, 0) AS result_id,
						
						ro.round_date,
						date_rescheduled
						
				from fixtures f
						inner join  players p1 ON f.home_player_id = p1.player_id
						inner join  players p2 ON f.away_player_id = p2.player_id
						left outer join results r1 ON (f.fixture_id = r1.fixture_id AND f.home_player_id = r1.player_id)
						left outer join results r2 ON (f.fixture_id = r2.fixture_id AND f.away_player_id = r2.player_id)
						left outer join fixture_status fs ON f.status_id = fs.status_id
						left outer join rounds ro ON f.round = ro.round_id
				where f.event_id = #arguments.eventID#
				<cfif ListLen(arguments.statusID)>
					and f.status_id IN (#arguments.statusID#)
				</cfif>
				<cfif arguments.playerID>
					and ((f.home_player_id = #arguments.playerID#) OR (f.away_player_id = #arguments.playerID#))
				</cfif>

				<cfif arguments.Rescheduled>
					and f.round_rescheduled =  #arguments.roundID#
				<cfelse>
					<cfif arguments.roundID>
						and f.round = #arguments.roundID#
					</cfif>
				</cfif>
				<cfif arguments.Rescheduled>
					order by f.date_rescheduled
				<cfelse>
					order by f.round, f.scheduled_time, f.status_id, f.fixture_id
				</cfif>
			</cfquery>

		<cfreturn qFixtures />
	</cffunction>
	
	<cffunction name="getGradedFixtures" access="public" output="true" returntype="any" hint="Get ">
		<cfargument name="EventID" 		type="numeric" 	required="true" 	default="1" />
		<cfargument name="HandicapID" 	type="any"		required="true" 	default="" />
		
			<cfscript>
				var FixtureList = "0";
			</cfscript>
		
			<cfquery name="getFixtureIDs" datasource="#Application.DSN#">
				select f.fixture_id
				from fixtures f
				inner join  players p1 ON f.home_player_id = p1.player_id
				inner join  players p2 ON f.away_player_id = p2.player_id
				where 	f.event_id = #arguments.EventID#

				-- and 	p1.handicap_id = p2.handicap_id 
				<cfif ListLen(arguments.HandicapID)>
					and p1.handicap_id IN (#arguments.HandicapID#)
					and p2.handicap_id IN (#arguments.HandicapID#)
				</cfif>
				and f.status_id IN (1,2)
			</cfquery>
			<cfif getFixtureIDs.RecordCount>
				<cfset FixtureList = ValueList(getFixtureIDs.fixture_id)>
			</cfif>

		<cfreturn FixtureList />
	</cffunction>
	
	<cffunction name="getGradedNotPlayed" access="public" output="true" returntype="query">
		<cfargument name="FixtureList" 	type="any" 	  	required="false" 	default="0" />
		<cfargument name="HandicapID" 	type="any"		required="false" 	default="0" />
		<cfargument name="EventID" 		type="numeric" 	required="false" 	default="2" />
		
			<cfscript>
				var PlayedPlayerList 	= 0;
			</cfscript>

			<!--- Get players that have played --->
			<cfquery name="getPlayersThatHavePlayedGradedMatch" datasource="#Application.DSN#">
				select distinct(r.player_id)
				from results r
				where r.fixture_id IN (#arguments.FixtureList#)
				order by r.player_id
			</cfquery>
			<cfif getPlayersThatHavePlayedGradedMatch.RecordCount>
				<cfset PlayedPlayerList = ValueList(getPlayersThatHavePlayedGradedMatch.player_id)>
			</cfif>
			<!--- Get players that have not played --->
			<cfquery name="getPlayersGradedPlayersThatHaveNotPlayed" datasource="#Application.DSN#">
				select p.*, CONCAT(LEFT(p.first_name, 1), '. ', p.last_name) AS player_short
				from players p
				inner join  player_event pe ON p.player_id = pe.player_id
				where pe.event_id = #arguments.EventID#
				<cfif arguments.HandicapID NEQ 0>
					and p.handicap_id IN (#arguments.HandicapID#)
				</cfif>
				<cfif arguments.FixtureList NEQ 0>
					and NOT p.player_id IN (#PlayedPlayerList#)
				</cfif>
				ORDER BY p.first_name
			</cfquery>

		<cfreturn getPlayersGradedPlayersThatHaveNotPlayed />
	</cffunction>
	
	
	<cffunction name="getRound" access="public" output="true" returntype="struct">
		<cfargument name="EventID" type="numeric" required="false" 	default="2" />
		
			<cfscript>
				var whichRound 	= structNew();

				var whichRound.prevRound = 0;
				var whichRound.nextRound = 1;
			</cfscript>
			
			<!--- Get latest round or results --->
			<cfquery name="getPrevRound" datasource="#Application.DSN#">
				select round_name AS PrevRound
				from rounds
				where round_date < DATE(now())
				and event_id = #EventID#
				order by round_id DESC
				limit 1
			</cfquery>
			<cfif getPrevRound.RecordCount>
				<cfset whichRound.prevRound = getPrevRound.PrevRound>
				<cfset whichRound.nextRound = getPrevRound.PrevRound + 1>
			</cfif>

		<cfreturn whichRound />
	</cffunction>
	
	
</cfcomponent>