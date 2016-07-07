<cfcomponent output="true">

	<cffunction name="getResults" access="public" output="true" returntype="Query">
		<cfargument name="EventID" 		type="numeric" 	required="true" 	default="1" />
		<cfargument name="FixtureList" 	type="any" 	  	required="false" 	default="" />
		
			<cfquery name="getPlayers" datasource="metro">
				select 	p.first_name, p.last_name, p.handicap_id,
						
						CONCAT(LEFT(p.first_name, 1), '. ', p.last_name) AS player_short,
				
						@gamesPlayed := count(r.player_id) AS gamesPlayed,
					  	@lagsWon := SUM(r.lag) AS lagsWon,
					  	@gamesWon := SUM(r.games_won) AS gamesWon,
					  	SUM(r.games_lost) AS gamesLost,
					  	SUM(r.runouts) AS runouts,
					   	SUM(r.games_won)-SUM(r.games_lost) AS gamesDiff,
					   	sum(r.points) AS totalPoints,
					   	CONCAT(FORMAT(SUM(r.lag)/count(r.player_id)*100,0),'%') AS lagPercent,
					   	SUM(CASE WHEN r.games_won = 7 THEN 1 ELSE 0 END) AS matchesWon,
					   	SUM(CASE WHEN r.games_won < 7 THEN 1 ELSE 0 END) AS matchesLost
				from results r
				inner join  players p ON r.player_id = p.player_id
				inner join  fixtures f ON r.fixture_id = f.fixture_id
				where r.status_id = 1
				and f.event_id = 2
				<cfif listLen(arguments.FixtureList)>
					and r.fixture_id IN (#arguments.FixtureList#)
				</cfif>
				group by r.player_id
				order by totalPoints DESC, gamesDiff DESC, gamesWon DESC, gamesLost DESC, runouts DESC
			</cfquery>

		<cfreturn getPlayers />
	</cffunction>
	
	<cffunction name="updateResults" access="remote" output="true" returnType="any" returnFormat="json" >
		<cfargument name="EventID" 			type="numeric" 	required="true" 	default="1" />
		<cfargument name="FixtureID" 		type="numeric" 	required="true" 	default="0" />
		<cfargument name="ResultID" 		type="numeric" 	required="true" 	default="0" />
		<cfargument name="homePlayerID"		type="numeric" 	required="true" 	default="0" />
		<cfargument name="awayPlayerID"		type="numeric" 	required="true" 	default="0" />
		<cfargument name="lag" 				type="numeric" 	required="true" 	default="0" />
		<cfargument name="homeRunouts"		type="numeric" 	required="true" 	default="0" />
		<cfargument name="awayRunouts"		type="numeric" 	required="true" 	default="0" />
		<cfargument name="homeScore"		type="numeric" 	required="true" 	default="0" />
		<cfargument name="awayScore"		type="numeric" 	required="true" 	default="0" />
		<cfargument name="fixtureStatus"	type="numeric" 	required="true" 	default="0" />
		<cfargument name="rescheduledWeek"	type="numeric" 	required="false" 	default="0" />
		<cfargument name="startTime"		type="string" 	required="false" 	default="0" />

		<cftry>
		
			<cfscript>
				
				var result 			= "{}";
				var homelag 		= 0;
				var	awayLag 		= 1;
				var homePoints 		= 0;
				var awayPoints 		= 0;
				var	resultStatus 	= 0;
				var raceLength		= 7;
				var rescheduledDate = CreateODBCDateTime(now()); // Only used if rescheduledWeek is GT 0
				
				// Set lag value
				if (arguments.lag EQ 0)
					{
					homelag = 1;
					awayLag = 0;
					};
					
				// Set status level
				if ((arguments.homeScore EQ raceLength) OR (arguments.awayScore EQ raceLength))
					{
					// If either player has "raceLength" set result status to 1 so counted in league table
					resultStatus  = 1;
					// If either player has 9 and status isnt forfeit set to result
					if (fixtureStatus NEQ 2)
						{
						fixtureStatus = 1;
						};
					}
				else{
					// If neither player has 9 frames set result status to 0 so not counted in league table
					resultStatus  = 0;
					// If frames are less than 9 and status is auto set to live scoring
					if (fixtureStatus EQ 0)
						{
						fixtureStatus = 3;
						};
					};
				
					
				// Set points
				if ((arguments.homeScore EQ raceLength))
					{
					homePoints  = 2;
					awayPoints  = 0;
					};
				if ((arguments.awayScore EQ raceLength))
					{
					homePoints  = 0;
					awayPoints  = 2;
					};
				
			</cfscript>

			<cftransaction>
			
				<!--- Home Result --->
				<cfquery name="getHomeResultID" datasource="metro">
					SELECT result_id
					from results
					WHERE fixture_id = #arguments.FixtureID# 
					AND player_id = #arguments.homePlayerID#
					LIMIT 1
				</cfquery> 
				<cfif getHomeResultID.RecordCount>
					<cfquery name="updateHomeResult" datasource="metro">
						UPDATE results
						SET games_won = #arguments.homeScore#,
							games_lost = #arguments.awayScore#,
							runouts = #arguments.homeRunouts#,
							points = #homePoints#,
							lag = #homelag#,
							status_id = #resultStatus#
						WHERE fixture_id = #arguments.FixtureID# 
						AND player_id = #arguments.homePlayerID#
						LIMIT 1
					</cfquery> 
				<cfelse>
					<cfquery name="insertHomeResult" datasource="metro">
						INSERT INTO results(fixture_id, player_id, games_won, games_lost, runouts, points, lag, status_id)
						VALUES 	(
								#arguments.FixtureID#, 
								#arguments.homePlayerID#,
								#arguments.homeScore#,
								#arguments.awayScore#,
								#arguments.homeRunouts#,
								#homePoints#,
								#homelag#,
								#resultStatus#
								)
					</cfquery>
				</cfif>
			
				<!--- Away Result --->
				<cfquery name="getAwayResultID" datasource="metro">
					SELECT result_id
					from results
					WHERE fixture_id = #arguments.FixtureID# 
					AND player_id = #arguments.awayPlayerID#
					LIMIT 1
				</cfquery> 
				<cfif getHomeResultID.RecordCount>
					<cfquery name="updateAwayResult" datasource="metro">
						UPDATE results
						SET games_won = #arguments.awayScore#,
							games_lost = #arguments.homeScore#,
							runouts = #arguments.awayRunouts#,
							points = #awayPoints#,
							lag = #awaylag#,
							status_id = #resultStatus#
						WHERE fixture_id = #arguments.FixtureID# 
						AND player_id = #arguments.awayPlayerID#
						LIMIT 1
					</cfquery>
				<cfelse>
					<cfquery name="insertAwayResult" datasource="metro">
						INSERT INTO results(fixture_id, player_id, games_won, games_lost, runouts, points, lag, status_id)
						VALUES 	(
								#arguments.FixtureID#, 
								#arguments.awayPlayerID#,
								#arguments.awayScore#,
								#arguments.homeScore#,
								#arguments.awayRunouts#,
								#awayPoints#,
								#awaylag#,
								#resultStatus#
								)
					</cfquery>
				</cfif>
				
			</cftransaction>
			

			<!--- Update Fixture Status if it is not null --->
			<cfif fixtureStatus GT 0>
				<cfquery name="hasBeenRescheduled" datasource="metro">
					UPDATE fixtures
					SET status_id = #fixtureStatus#,
					    scheduled_time = concat(date(scheduled_time), ' #arguments.startTime#')
					where fixture_id = #arguments.FixtureID#
				</cfquery>
			</cfif>
			
			<!--- Check to see if rescheduled round has been changed? --->
			<cfquery name="hasBeenRescheduled" datasource="metro">
				select * from fixtures 
				where fixture_id = #arguments.FixtureID#
				and round_rescheduled = #arguments.rescheduledWeek#
			</cfquery>
			<!--- If it has been changed update timestamp and round rescheduled --->
			<cfif NOT hasBeenRescheduled.RecordCount>
				<cfquery name="updateFixtureStatus" datasource="metro">
					UPDATE 	fixtures
					SET  	round_rescheduled = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.rescheduledWeek#">,
							date_rescheduled = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#rescheduledDate#">
					WHERE 	fixture_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.FixtureID#">
				</cfquery>
			</cfif>
			
			<cfset sleep(500)>

			<cfcatch type="any">
				<cfdump var="#cfcatch#">
			</cfcatch>
			
		</cftry>
			
		<cfreturn result />
	</cffunction>
	
	
	<cffunction name="getRunouts" access="public" output="true" returntype="Query">
		<cfargument name="EventID" 		type="numeric" 	required="true" 	default="1" />
		<cfargument name="HandicapID" 	type="numeric" required="false" 	default="0" />
		
			<cfquery name="getTotalBreaks" datasource="metro">
				select 	p1.player_id AS home_id,
						CONCAT(p3.first_name, ' ', p3.last_name) AS player, 
						
						CONCAT(LEFT(p3.first_name, 1), '. ', p3.last_name) AS player_short,
						
						p3.handicap_id AS grade,
						p2.player_id AS away_id,
						r.player_id AS player_id, r.runouts, r.games_won, r.games_lost, r.lag,
						p1.handicap_id AS home_handicap_id,
						p2.handicap_id AS away_handicap_id,
						@homeStart := IF(p1.handicap_id > p2.handicap_id, (((p1.handicap_id-p2.handicap_id) * 1)+1), 0) AS homeStart,
						@awayStart := IF(p2.handicap_id > p1.handicap_id, (((p2.handicap_id-p1.handicap_id) * 1)+1), 0) AS awayStart,
					  	@gamesPlayed := r.games_won + r.games_lost - @homeStart - @awayStart  AS GamesPlayed,
					  	@totalBreaks := IF(r.lag = 0, floor(@gamesPlayed/2), CEILING(@gamesPlayed/2))  AS totalBreaks
				from 	results r
					inner join  fixtures f ON r.fixture_id = f.fixture_id
					inner join  players p1 ON f.home_player_id = p1.player_id
					inner join  players p2 ON f.away_player_id = p2.player_id
					inner join  players p3 ON r.player_id = p3.player_id
				where f.status_id = 1
				and f.event_id = #arguments.EventID#
			</cfquery>
			
			<cfquery name="getRunouts" dbtype="query">
				select 	player, player_short,
						count(home_id) AS GamesPlayed,
						sum(lag) AS lagsWon,
						max(grade) AS grade,
						sum(GamesPlayed) AS totalGames,
						sum(totalBreaks) AS totalBreaks, 
						sum(runouts) AS totalRunouts,
						(sum(runouts)/sum(totalBreaks))*100 AS totalPercent
				from getTotalBreaks
				group by player, player_short
				order by grade, totalRunouts DESC, totalPercent DESC, lagsWon DESC
			</cfquery>
		

		<cfreturn getRunouts />
	</cffunction>
	
</cfcomponent>