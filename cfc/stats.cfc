<cfcomponent output="true">

	<cffunction name="getStats" access="public" output="true" returntype="any">
		
		<cfargument name="PlayerID" 	type="numeric" 	required="true" />
		<cfargument name="GradeID" 		type="numeric" 	required="false" 	default="0" />
		<cfargument name="EventID" 		type="numeric" 	required="false" 	default="1" />
		
			<cfscript>
				var thisAverage = 0;
			</cfscript>
		
			<cfquery name="qGetGrade" datasource="metro">
				select 	handicap_id AS PlayersGradeID
				from players  
				where player_id = #arguments.PlayerID#
			</cfquery>
		
			<cfquery name="qGetAverage" datasource="metro">
				select 	@gamesPlayed 	:= count(r.player_id) AS matchesPlayed,
						@lagsWon 		:= SUM(r.lag) AS lagsWon,
						@gamesWon 		:= SUM(r.games_won) AS gamesWon,
						@gamesLost 		:= SUM(r.games_lost) AS gamesLost,
						SUM(r.runouts) 	AS runouts,
						sum(r.points) 	AS totalPoints
				from results r 
				where player_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.PlayerID#">
				and fixture_id IN 	(
									select f.fixture_id
									from fixtures f
										inner join  players p1 ON f.home_player_id = p1.player_id
										inner join  players p2 ON f.away_player_id = p2.player_id
									where ( 
										  	(f.home_player_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.PlayerID#">
										  		OR 
										  	f.away_player_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.PlayerID#">) 
										  	<!--- Get graded if results only if gradeID is passed --->
										  	<cfif GradeID GT 0>
											  	and 
											  	<cfif arguments.GradeID EQ qGetGrade.PlayersGradeID>
													(p1.handicap_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.GradeID#">
														AND 
													p2.handicap_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.GradeID#">) 
												<cfelse>
													(p1.handicap_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.GradeID#"> 
														OR 
													p2.handicap_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.GradeID#">) 
												</cfif>
											</cfif>
										  )
									and f.status_id = 1
									and f.event_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.EventID#">
									)
				
			</cfquery>
			<cftry>
				<cfset thisAverage = DecimalFormat(evaluate((qGetAverage.gamesWon-qGetAverage.gamesLost)/qGetAverage.matchesPlayed))>
				<cfcatch>
					<!--- <cfdump var="#cfcatch#"> --->
				</cfcatch>
			</cftry>
			
		<cfreturn thisAverage />
	</cffunction>

</cfcomponent>