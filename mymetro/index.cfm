
<cfset thisEventID = 2>

<cfif isDefined("URL.Logout")>
	<cfscript>
		StructClear(Session);
	</cfscript>
</cfif> 

<cfif isDefined("FORM.Action")>
	
	<cfif NOT CompareNoCase(FORM.email, "info@metropool.club") AND NOT CompareNoCase(FORM.password, "Sydney13!")>
		<!--- Check if Admin? --->
		<cfset Session.PlayerID=0>
	<cfelse>
		<!--- Check if Player? --->
		<cfquery name="checkLogin" datasource="#Application.DSN#">
			select p.player_id
			from players p
			INNER JOIN player_event pe ON p.player_id = pe.player_id
			WHERE pe.event_id = <cfqueryparam value="#thisEventID#" cfsqltype="cf_sql_integer">
			AND p.email = <cfqueryparam value="#FORM.email#" cfsqltype="cf_sql_varchar">
			AND p.password = <cfqueryparam value="#FORM.password#" cfsqltype="cf_sql_varchar">
		</cfquery>
		<cfif checkLogin.RecordCount EQ 1>
			<cfset Session.PlayerID = checkLogin.player_id>
		<cfelse>
			<cfset ErrorMessage = "Login failed, please try again">
		</cfif>
		<!--- <cfdump var="#checkLogin#">
		<cfdump var="#Session#"> --->
	</cfif>
</cfif>	



<cfparam name="ErrorMessage" 	default="">
<cfparam name="SuccessMessage" 	default="">
<cfparam name="FORM.email" 		default="">
<cfparam name="FORM.password" 	default="">
<cfparam name="FORM.playerID" 	default="">
<cfparam name="URL.playerID" 	default="">
<cfparam name="URL.roundID" 	default="">

<cfset eventRaceLength = 7> <!--- Get From DB --->
<cfset eventId = 2> <!--- Get From DB --->


<cfset thisPage = "My Metro">
<cfinclude template="../includes/inc_header.cfm">

<section id="title" class="tournament-blue">
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <h1><cfoutput>#thisPage#</cfoutput></h1>
                <p>Login to see your personal fixtures and enter your match results</p>
            </div>
            <div class="col-sm-6">
                <ul class="breadcrumb pull-right">
                    <li><a href="index.cfm?Logout=true">LOGOUT</a></li>
                </ul>
            </div>
        </div>
    </div>
</section><!--/#title-->


<cfif NOT isDefined("Session.PlayerID")>
	
	<section id="login">
		<div class="container">
			<div class="row">
				<div class="col-md-4 hidden-xs"></div>
				<div class="col-md-4 col-xs-12">
					<cfif len(ErrorMessage)>
			   			<div class="alert alert-danger text-center" style=""><cfoutput>#ErrorMessage#</cfoutput></div>
			   		</cfif>
			   		<cfif len(SuccessMessage)>
			   			<div class="alert alert-success text-center"><cfoutput>#SuccessMessage#</cfoutput></div>
			   		</cfif>
			   		<div class="panel panel-default">
		  				<div class="panel-heading"><strong>Login</strong></div>
						<div class="panel-body">
							    
							    <div class="col-lg-1"></div>
						    	<div class="col-lg-10">
						    		<br />
								    <!--- <div class="form-group">
							    		<button type="button" class="btn btn-primary btn-lg btn-block" onclick="Login()"> 
										  	<i class="fa fa-facebook fa-lg"></i> &nbsp; Login with Facebook
										</button>
						    		</div>
								    <div class="form-group text-center text-muted">
										OR
									</div> --->
									<form action="?" method="post" class="form-horizontal" role="form" id="regForm">
									    <input type="hidden" name="Action" value="true">
									    <div class="form-group">
										    <div class="input-group">
											    <span class="input-group-addon">
													<span class="glyphicon glyphicon-user"></span>
												</span>
											  	<input name="email" type="text" class="form-control" id="Email" placeholder="Email" value="<cfoutput>#FORM.email#</cfoutput>">
											</div>
										</div>
									    <div class="form-group">
										    <div class="input-group">
											    <span class="input-group-addon">
													<span class="glyphicon glyphicon-lock"></span>
												</span>
											  	<input name="Password" type="password" class="form-control" id="password" placeholder="Password" value="<cfoutput>#FORM.Password#</cfoutput>">
											</div>
											</div>
									    <div class="form-group">
								      		<button class="btn btn-primary btn-block active" id="btnReg"> Login</button>
								      	</div>
									</form>
								</div>
						</div>
					</div>	
					   		
				</div>
			</div>
		</div>
	</section>

<cfelse>

	<section id="MyMetro">

		<cfif isDefined("SESSION.PlayerID") AND SESSION.PlayerID GT 0>
			<cfset FORM.playerID = SESSION.playerID>
			<cfset FORM.roundID = 0>
		<cfelseif isNumeric(FORM.playerID)>
			<cfset FORM.playerID = FORM.playerID>
		<cfelseif isNumeric(URL.playerID)>
			<cfset FORM.playerID = URL.playerID>
		<cfelse>
			<cfset FORM.playerID = 0>
		</cfif>

		<cfif isNumeric(URL.roundID)>
			<cfset FORM.roundID = URL.roundID>
		</cfif>

	   	<cfscript>
		   	
		   	// writeDump(FORM);
			
			if (NOT isDefined("FORM.roundID") )
				{
				whichRound	= objFixtures.getRound(); // writeDump(whichRound);
				FORM.roundID = whichRound.nextRound;
				}
				
			getFixtures = objFixtures.getFixtures(
													EventID		= eventId,
													playerID	= FORM.playerID,
													roundID		= FORM.roundID
												 );

			getRescheduled = objFixtures.getFixtures(eventID=#EventID#, statusID='1,2,3,4,6', roundID=FORM.roundID, Rescheduled = true); // writeDump(getRescheduled);

			// writeDump(getFixtures);
												 
			// getMasterStats			= objStats.getStats(PlayerID = #FORM.playerID#, GradeID = 1); // writeDump(getMasterStats);
												 
			// getAdvancedStats		= objStats.getStats(PlayerID = #FORM.playerID#, GradeID = 2); // writeDump(getAdvancedStats);
												 
			// getIntermediateStats 	= objStats.getStats(PlayerID = #FORM.playerID#, GradeID = 3); // writeDump(getIntermediateStats);
												 
			// getOpenStats			= objStats.getStats(PlayerID = #FORM.playerID#, GradeID = 4); // writeDump(getOpenStats);
			
		</cfscript>
		
		<div class="container">

		<div class="row">
			<!--- RIGHT COLUMN --->
		 	<div class="col-lg-2 text-left"></div>
		 	<div class="col-lg-8 text-left">

				<!--- Only Show Search to Admins --->
	    		<cfif SESSION.PlayerID EQ 0>
					<cfquery name="getTotalRounds" datasource="metro">
						select count(round_id) AS TotalRounds
						from rounds 
						where event_id = #EventID#
					</cfquery>
		    		<!--- Search Bar --->
	    			<form action="?" method="post">
					    <div class="row" style="margin: 20px 0 20px 0">
					        <div class="col-xs-1 col-sm-1 hidden-xs hidden-sm"></div>
					        <div class="col-xs-4">
					            <div class="input-group">
									<span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
						    		<select name="roundID" class="form-control">
										<option value="0">Show All Weeks</option>
										<cfloop from="1" to="#getTotalRounds.TotalRounds#" index="w">
											<cfoutput><option value="#w#" <cfif FORM.roundID EQ w>selected</cfif>>Week #w#</option></cfoutput>
										</cfloop>
									</select>
					            </div>
					        </div>
					        <div class="col-xs-4">
					            <div class="input-group text-left">
									<span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
									<cfscript>
										allPlayers = objPlayers.getEventPlayers(EventID=#eventId#);
									</cfscript>
						    		<select name="playerID" class="form-control">
										<option value="0">Show All Players</option>
										<cfoutput query="allPlayers">
											<option value="#player_id#" <cfif FORM.playerID EQ player_id>selected</cfif>>#full_name#</option>
										</cfoutput>
									</select>
					            </div>
					        </div>
					        <div class="col-xs-4 col-sm-1 text-right">
					            <div class="input-group">
									<button type="submit" class="btn btn-primary">Search</button>
					            </div>
					        </div>
					        <div class="col-xs-1 hidden-xs hidden-sm"></div>
					    </div>
					</form>
	    		</cfif>
	    		<!--- End Search --->

			
				<!--- Fixtures/Results Panel --->
			   	<cfset Match 		= 0>
			   	<cfset prevRound 	= 0>
				<div class="panel panel-default table-responsive">
		    		<div class="panel-heading text-left" style="background-color: #666; color: #fff"><cfoutput><strong>MY FIXTURES</strong></cfoutput></div>
					<table class="table" border="0">
					   	<tbody>
							<cfif getFixtures.RecordCount>
								<tr class="active">
									<th class="">&nbsp;</th>
									<th class="text-center hidden-xs hidden-sm" title="Grade Match">GM</th>
									<th class="text-left">Match</th>
									<th class="text-center hidden-xs hidden-sm">Week</th>
									<th class="text-left">Date</th>
									<th class="text-right">Player 1</th>
									<th class="text-center" width="0">
										<span class="hidden-xs hidden-sm">(Race to 7)</span>
									</th>
									<th class="text-left">Player 2</th>
									<th>&nbsp;</th>
								</tr>
							   	<cfoutput query="getFixtures">
								   	<cfset Match = Match + 1>
									<cfswitch expression="#home_handicap_id#">
										<cfcase value="1"><cfset homeGradeClass = "text-danger"></cfcase>
										<cfcase value="2"><cfset homeGradeClass = "text-warning"></cfcase>
										<cfcase value="3"><cfset homeGradeClass = "text-success"></cfcase>
										<cfcase value="4"><cfset homeGradeClass = "text-primary"></cfcase>
									</cfswitch>
									<cfswitch expression="#away_handicap_id#">
										<cfcase value="1"><cfset awayGradeClass = "text-danger"></cfcase>
										<cfcase value="2"><cfset awayGradeClass = "text-warning"></cfcase>
										<cfcase value="3"><cfset awayGradeClass = "text-success"></cfcase>
										<cfcase value="4"><cfset awayGradeClass = "text-primary"></cfcase>
									</cfswitch>
									<cfif result_id EQ 0>
										<cfset HomeScore7 = HomeStart7>
										<cfset AwayScore7 = AwayStart7>
									</cfif>
									<!--- Round Spacer --->
								   	<cfif (round NEQ prevRound) AND (FORM.playerID GT 0)>
										<tr style="background-color: ##fff">
											<td colspan="9" style="background-color: ##eee; height: 5px"></td>
										</tr>
										<cfset prevRound = round>
									</cfif>
									<!--- Row Data --->
									<tr <cfif status_id EQ 6>style="background-color: ##FEFEFE"</cfif>>
										<td>
											<cfswitch expression="#status_id#">
												<cfcase value="1">
													<i class="fa fa-circle text-success" title="#status#"></i>
													<cfset fixtureClass = "fixture-result">
												</cfcase>
												<cfcase value="2">
													<i class="fa fa-spinner fa-frown-o text-success" title="#status#"></i>
													<cfset fixtureClass = "fixture-result">
												</cfcase>
												<cfcase value="3">
													<i class="fa fa-spinner fa-spin text-success" title="#status#"></i>
													<cfset fixtureClass = "fixture-result">
												</cfcase>
												<cfcase value="4">
													<i class="fa fa-circle-o text-success" title="#status#"></i>
													<cfset fixtureClass = "fixture-result">
												</cfcase>
												<cfcase value="6">
													<i class="fa fa-times-circle text-muted" title="#status#"></i>
													<cfset fixtureClass = "fixture-postponed">
												</cfcase>
												<cfdefaultcase></cfdefaultcase>
											</cfswitch>
										</td>
										<td class="text-center hidden-xs hidden-sm">
											<cfset aLeagueGrades = "1,2">
											<cfset bLeagueGrades = "3,4">
											<cfif (ListFind(aLeagueGrades, home_handicap_id) AND ListFind(aLeagueGrades, away_handicap_id)) OR (ListFind(bLeagueGrades, home_handicap_id) AND ListFind(bLeagueGrades, away_handicap_id))>
												<span class="glyphicon glyphicon-star" style="color: gold"></span>
											<cfelse>
												&nbsp;
											</cfif>
										</td>
										<td class="text-muted text-left">M<cfif fixture_id LT 10>0</cfif>#fixture_id#</td>
										<td class="text-left text-left hidden-xs hidden-sm">#ROUND#</td>
										<td class="text-left text-left">

											<span class="hidden-xs hidden-sm">
												#DateFormat(scheduled_time, "dd mmm yyyy")# @ 
												<cfif right(scheduled_time, 10) EQ "00:00:00.0">
													TBC
												<cfelse>
													#LCase(TimeFormat(scheduled_time, "htt"))#
												</cfif>
											</span>
											<span class="visible-xs visible-sm">
												#DateFormat(scheduled_time, "dd mmm")#
											</span>

										</td>
										<td class="#homeGradeClass# text-right" <cfif SESSION.PlayerID EQ home_player_id>style="font-weight: bold"</cfif>>
											<span class="visible-xs visible-sm">#home_player_short#</span>
											<span class="hidden-xs hidden-sm">#home_player#</span>
										</td>
										<td class="text-center" width="0">
											<span class="homeScore#fixture_id#">#HomeScore7#</span> - <span class="awayScore#fixture_id#">#AwayScore7#</span>
										</td>
										<td class="#awayGradeClass# text-left"<cfif SESSION.PlayerID EQ away_player_id>style="font-weight: bold"</cfif>>
											<span class="visible-xs visible-sm">#away_player_short#</span>
											<span class="hidden-xs hidden-sm">#away_player#</span>
										</td>
										<td>
											<!--- Edit Score Admin Only --->
											<cfif Session.PlayerID EQ 0>
												<span fixtureID="#fixture_id#" class="glyphicon glyphicon-chevron-down btnEditForm" style="cursor: pointer"></span>
											</cfif>
										</td>
										<!--- 
										<td class="text-right">
										  	<a href="##fl1" class="featherLink" fixtureID="#fixture_id#" resultID="#result_id#"><span class="glyphicon glyphicon-edit"></span> Edit </a>
										</td> 
										--->
									</tr>
									<tr class="editForm#fixture_id#" style="display:none">
										<td colspan="9" align="center">
											
											<table cellpadding="2" border="0" style="border: 1px solid ##DDD">
												<tr>
													<td colspan="3" class="text-center">
														<cfquery name="getFixtureStatus" datasource="#Application.DSN#">
															select status_id, status
															from fixture_status
														</cfquery>
														<select name="fixtureStatus#fixture_id#" class="form-control">
															<option value="0">Auto Status</option>
															<cfloop query="getFixtureStatus">
																<option value="#status_id#" <cfif getFixtures.status_id EQ status_id>selected</cfif>>[#status_id#] #status#</option>
															</cfloop>
														</select>
													</td>
												</tr>
												<tr>
													<td colspan="3" class="text-center">
														<cfquery name="getMaxRound" datasource="#Application.DSN#">
															select count(round_name) AS totalRounds
															from rounds 
															where event_id = #eventId#
														</cfquery>
														<select name="rescheduledWeek#fixture_id#" class="form-control">
															<option value="0">Not Rescheduled</option>
															<option value="0">Not Rescheduled</option>
															<cfloop from="1" to="#getMaxRound.totalRounds#" index="x">
																<option value="#x#" <cfif x EQ round_rescheduled>selected</cfif>>Week #x#</option>
															</cfloop>
														</select>
													</td>
												</tr>
												<tr>
													<td colspan="3" class="text-center">
														<cfset startHour = TimeFormat(scheduled_time, "h")>
														<div class="btn-group" data-toggle="buttons">
															<label class="btn btn-default <cfif startHour EQ 7>active</cfif>">
											                    <input type="radio" name="startTime#fixture_id#" value="19:00:00" <cfif startHour EQ 7>checked</cfif> /> 7pm
											                </label>
															<label class="btn btn-default <cfif startHour EQ 8>active</cfif>">
											                    <input type="radio" name="startTime#fixture_id#" value="20:00:00" <cfif startHour EQ 8>checked</cfif> /> 8pm
											                </label>
															<label class="btn btn-default <cfif startHour EQ 12>active</cfif>">
											                    <input type="radio" name="startTime#fixture_id#" value="00:00:00" <cfif startHour EQ 12>checked</cfif> /> TBC
											                </label>
														</div>
													</td>
												</tr>
												<tr>
													<td class="text-center"><input type="radio" name="lag#fixture_id#" value="0" <cfif homeLag EQ 1>checked</cfif>></td>
													<td class="text-center">Lag</td>
													<td class="text-center"><input type="radio" name="lag#fixture_id#" value="1" <cfif awayLag EQ 1>checked</cfif>></td>
												</tr>
												<tr>
													<td>
														<select name="homeRunouts#fixture_id#" class="form-control">
															<cfloop from="0" to="#eventRaceLength#" index="hr">
																<option value="#hr#"<cfif homeRunouts EQ hr>selected</cfif>>#hr#</option>
															</cfloop>
														</select>
													</td>
													<td class="text-center">B&R</td>
													<td>
														<select name="awayRunouts#fixture_id#" class="form-control">
															<cfloop from="0" to="#eventRaceLength#" index="ar">
																<option value="#ar#"<cfif awayRunouts EQ ar>selected</cfif>>#ar#</option>
															</cfloop>
														</select>
													</td>
												</tr>
												<tr>
													<td>
														<select name="homeScore#fixture_id#" class="form-control">
															<cfloop from="0" to="#eventRaceLength#" index="hs">
																<option value="#hs#" <cfif homeScore7 EQ hs>selected</cfif>>#hs#</option>
															</cfloop>
														</select>
													</td>
													<td class="text-center">Score</td>
													<td>
														<select name="awayScore#fixture_id#" class="form-control">
															<cfloop from="0" to="#eventRaceLength#" index="as">
																<option value="#as#" <cfif awayScore7 EQ as>selected</cfif>>#as#</option>
															</cfloop>
														</select>
													</td>
												</tr>
												<!---  <cfif getFixtureStatus.status_id EQ getFixtures.status_id>selected</cfif> --->
												<tr>
													<td colspan="3" class="text-center">
														<button 
																resultID="#result_id#" 
																fixtureID="#fixture_id#" 
																homePlayerID="#home_player_id#" 
																awayPlayerID="#away_player_id#" 
																type="button" 
																class="btn btn-primary saveResult">
																	
																<i id="saveIcon#fixture_id#" class="fa fa-refresh"></i> Save
														</button>
													</td>
												</tr>
											</table>
											
										</td>
									</tr>
								</cfoutput>
								<tr>
									<td colspan="9" style="background-color: #eee;">Showing <strong><cfoutput>#getFixtures.RecordCount#</cfoutput></strong> Scheduled Matches</td>
								</tr>

								<cfif Session.PlayerID EQ 0>

									<!--- Waitlist Games --->
									<cfoutput query="getRescheduled">
									   	<cfset Match = Match + 1>
										<cfswitch expression="#home_handicap_id#">
											<cfcase value="1"><cfset homeGradeClass = "text-danger"></cfcase>
											<cfcase value="2"><cfset homeGradeClass = "text-warning"></cfcase>
											<cfcase value="3"><cfset homeGradeClass = "text-success"></cfcase>
											<cfcase value="4"><cfset homeGradeClass = "text-primary"></cfcase>
										</cfswitch>
										<cfswitch expression="#away_handicap_id#">
											<cfcase value="1"><cfset awayGradeClass = "text-danger"></cfcase>
											<cfcase value="2"><cfset awayGradeClass = "text-warning"></cfcase>
											<cfcase value="3"><cfset awayGradeClass = "text-success"></cfcase>
											<cfcase value="4"><cfset awayGradeClass = "text-primary"></cfcase>
										</cfswitch>
										<cfif result_id EQ 0>
											<cfset HomeScore7 = HomeStart7>
											<cfset AwayScore7 = AwayStart7>
										</cfif>
										<!--- Round Spacer --->
									   	<cfif (round NEQ prevRound) AND (FORM.playerID GT 0)>
											<tr style="background-color: ##fff">
												<td colspan="9" style="background-color: ##eee; height: 5px"></td>
											</tr>
											<cfset prevRound = round>
										</cfif>
										<!--- Row Data --->
										<tr <cfif status_id EQ 6>style="background-color: ##FEFEFE"</cfif>>
											<td>
												<cfswitch expression="#status_id#">
													<cfcase value="1">
														<i class="fa fa-circle text-success" title="#status#"></i>
														<cfset fixtureClass = "fixture-result">
													</cfcase>
													<cfcase value="2">
														<i class="fa fa-spinner fa-frown-o text-success" title="#status#"></i>
														<cfset fixtureClass = "fixture-result">
													</cfcase>
													<cfcase value="3">
														<i class="fa fa-spinner fa-spin text-success" title="#status#"></i>
														<cfset fixtureClass = "fixture-result">
													</cfcase>
													<cfcase value="4">
														<i class="fa fa-circle-o text-success" title="#status#"></i>
														<cfset fixtureClass = "fixture-result">
													</cfcase>
													<cfcase value="6">
														<i class="fa fa-times-circle text-muted" title="#status#"></i>
														<cfset fixtureClass = "fixture-postponed">
													</cfcase>
													<cfdefaultcase></cfdefaultcase>
												</cfswitch>
											</td>
											<td class="text-center hidden-xs hidden-sm">
												<cfset aLeagueGrades = "1,2">
												<cfset bLeagueGrades = "3,4">
												<cfif (ListFind(aLeagueGrades, home_handicap_id) AND ListFind(aLeagueGrades, away_handicap_id)) OR (ListFind(bLeagueGrades, home_handicap_id) AND ListFind(bLeagueGrades, away_handicap_id))>
													<span class="glyphicon glyphicon-star" style="color: gold"></span>
												<cfelse>
													&nbsp;
												</cfif>
											</td>
											<td class="text-muted text-left">M<cfif fixture_id LT 10>0</cfif>#fixture_id#</td>
											<td class="text-left text-left hidden-xs hidden-sm">#ROUND#</td>
											<td class="text-left text-left">

												<span class="hidden-xs hidden-sm">
													#DateFormat(scheduled_time, "dd mmm yyyy")# @ 
													<cfif right(scheduled_time, 10) EQ "00:00:00.0">
														TBC
													<cfelse>
														#LCase(TimeFormat(scheduled_time, "htt"))#
													</cfif>
												</span>
												<span class="visible-xs visible-sm">
													#DateFormat(scheduled_time, "dd mmm")#
												</span>

											</td>
											<td class="#homeGradeClass# text-right" <cfif SESSION.PlayerID EQ home_player_id>style="font-weight: bold"</cfif>>
												<span class="visible-xs visible-sm">#home_player_short#</span>
												<span class="hidden-xs hidden-sm">#home_player#</span>
											</td>
											<td class="text-center" width="0">
												<span class="homeScore#fixture_id#">#HomeScore7#</span> - <span class="awayScore#fixture_id#">#AwayScore7#</span>
											</td>
											<td class="#awayGradeClass# text-left"<cfif SESSION.PlayerID EQ away_player_id>style="font-weight: bold"</cfif>>
												<span class="visible-xs visible-sm">#away_player_short#</span>
												<span class="hidden-xs hidden-sm">#away_player#</span>
											</td>
											<td>
												<!--- Edit Score Admin Only --->
												<cfif Session.PlayerID EQ 0>
													<span fixtureID="#fixture_id#" class="glyphicon glyphicon-chevron-down btnEditForm" style="cursor: pointer"></span>
												</cfif>
											</td>
										</tr>
										<tr class="editForm#fixture_id#" style="display:none">
											<td colspan="9" align="center">
												
												<table cellpadding="2" border="0" style="border: 1px solid ##DDD">
													<tr>
														<td colspan="3" class="text-center">
															<cfquery name="getFixtureStatus" datasource="#Application.DSN#">
																select status_id, status
																from fixture_status
															</cfquery>
															<select name="fixtureStatus#fixture_id#" class="form-control">
																<option value="0">Auto Status</option>
																<cfloop query="getFixtureStatus">
																	<option value="#status_id#" <cfif getFixtures.status_id EQ status_id>selected</cfif>>[#status_id#] #status#</option>
																</cfloop>
															</select>
														</td>
													</tr>
													<tr>
														<td colspan="3" class="text-center">
															<cfquery name="getMaxRound" datasource="#Application.DSN#">
																select count(round_name) AS totalRounds
																from rounds 
																where event_id = #eventId#
															</cfquery>
															<select name="rescheduledWeek#fixture_id#" class="form-control">
																<option value="0">Not Rescheduled</option>
																<option value="0">Not Rescheduled</option>
																<cfloop from="1" to="#getMaxRound.totalRounds#" index="x">
																	<option value="#x#" <cfif x EQ round_rescheduled>selected</cfif>>Week #x#</option>
																</cfloop>
															</select>
														</td>
													</tr>
													<tr>
														<td colspan="3" class="text-center">
															<cfset startHour = TimeFormat(scheduled_time, "h")>
															<div class="btn-group" data-toggle="buttons">
																<label class="btn btn-default <cfif startHour EQ 7>active</cfif>">
												                    <input type="radio" name="startTime#fixture_id#" value="19:00:00" <cfif startHour EQ 7>checked</cfif> /> 7pm
												                </label>
																<label class="btn btn-default <cfif startHour EQ 8>active</cfif>">
												                    <input type="radio" name="startTime#fixture_id#" value="20:00:00" <cfif startHour EQ 8>checked</cfif> /> 8pm
												                </label>
																<label class="btn btn-default <cfif startHour EQ 12>active</cfif>">
												                    <input type="radio" name="startTime#fixture_id#" value="00:00:00" <cfif startHour EQ 12>checked</cfif> /> TBC
												                </label>
															</div>
														</td>
													</tr>
													<tr>
														<td class="text-center"><input type="radio" name="lag#fixture_id#" value="0" <cfif homeLag EQ 1>checked</cfif>></td>
														<td class="text-center">Lag</td>
														<td class="text-center"><input type="radio" name="lag#fixture_id#" value="1" <cfif awayLag EQ 1>checked</cfif>></td>
													</tr>
													<tr>
														<td>
															<select name="homeRunouts#fixture_id#" class="form-control">
																<cfloop from="0" to="#eventRaceLength#" index="hr">
																	<option value="#hr#"<cfif homeRunouts EQ hr>selected</cfif>>#hr#</option>
																</cfloop>
															</select>
														</td>
														<td class="text-center">B&R</td>
														<td>
															<select name="awayRunouts#fixture_id#" class="form-control">
																<cfloop from="0" to="#eventRaceLength#" index="ar">
																	<option value="#ar#"<cfif awayRunouts EQ ar>selected</cfif>>#ar#</option>
																</cfloop>
															</select>
														</td>
													</tr>
													<tr>
														<td>
															<select name="homeScore#fixture_id#" class="form-control">
																<cfloop from="0" to="#eventRaceLength#" index="hs">
																	<option value="#hs#" <cfif homeScore7 EQ hs>selected</cfif>>#hs#</option>
																</cfloop>
															</select>
														</td>
														<td class="text-center">Score</td>
														<td>
															<select name="awayScore#fixture_id#" class="form-control">
																<cfloop from="0" to="#eventRaceLength#" index="as">
																	<option value="#as#" <cfif awayScore7 EQ as>selected</cfif>>#as#</option>
																</cfloop>
															</select>
														</td>
													</tr>
													<!---  <cfif getFixtureStatus.status_id EQ getFixtures.status_id>selected</cfif> --->
													<tr>
														<td colspan="3" class="text-center">
															<button 
																	resultID="#result_id#" 
																	fixtureID="#fixture_id#" 
																	homePlayerID="#home_player_id#" 
																	awayPlayerID="#away_player_id#" 
																	type="button" 
																	class="btn btn-primary saveResult">
																		
																	<i id="saveIcon#fixture_id#" class="fa fa-refresh"></i> Save
															</button>
														</td>
													</tr>
												</table>
												
											</td>
										</tr>
									</cfoutput>
									<tr>
										<td colspan="9" style="background-color: #eee;">Showing <strong><cfoutput>#getRescheduled.RecordCount#</cfoutput></strong> Waitlist Matches</td>
									</tr>
								</cfif>

							<cfelse>
								<tr>
									<th class="hidden-xs hidden-sm">Match</th>
									<th>Time</th>
									<th class="text-right">Player 1</th>
									<th class="text-center" width="0">(Race to 9)</th>
									<th class="text-left">Player 2</th>
									<th class="text-center hidden-xs" title="Grade Match">GM</th>
									<th></th>
								</tr>
								<tr>
									<td colspan="9" class="text-danger text-center" style="padding: 100px; font-size: 56px; font-weight: bolder; color: WhiteSmoke; font-family: Arial;">No Results</td>
								</tr>
							</cfif>
						</tbody>
					</table>
					<!--- Fixture Key --->
		    		<div class="panel-body text-left" style="background-color: ##333 !important;">
					    <cfinclude template="../includes/inc_legend.cfm">
					</div>
				</div>

			</div>
		</div>
		</div>

	</section>
		
		
	<div class="lightbox" id="fl1">
		
		<table width="100%">
			<tr>
				<td style="background-color: black"><img src="<cfoutput>#Application.Home#</cfoutput>/images/logo/logo-metro-xsmall.png" width="300px"/></td>
				<td width="100%"> 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					DATE:  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					START TIME: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<br />
		<br />
		<table width="100%" cellpadding="5">
			<tr>
				<th>Players</th>
				<th class="text-center">Lag</th>
				<th class="text-center">1</th>
				<th class="text-center">2</th>
				<th class="text-center">3</th>
				<th class="text-center">4</th>
				<th class="text-center">5</th>
				<th class="text-center">6</th>
				<th class="text-center">7</th>
				<th class="text-center">8</th>
				<th class="text-center">9</th>
				<th>Total Score</th>
				<th>Total B&R</th>
			</tr>
			<form method="post" action="?">
			<tr>
				<td>Firstname Surname</td>
				<td class="text-center"><input type="radio" value="1" name="lag" class="form-control"></td>
				<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
				<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
				<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
				<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
				<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
				<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
				<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
				<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
				<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
				<td><input type="text" size="4" class="form-control"></td>
				<td>
				<select name="runouts" class="form-control">
					<cfloop from="1" to="9" index="r">
						<cfoutput><option value="#r#">#r#</option></cfoutput>
					</cfloop>
					<option value="0">0</option>
					<option value="1">1</option>
				</select>
				</td>
			</tr>
			<tr>
				<td>Firstname Surname</td>
				<td class="text-center"><input type="radio" value="1" name="lag" class="form-control"></td>
				<td class="text-center"><input type="checkbox" value="0" class="form-control" checked DISABLED></td>
				<td class="text-center"><input type="checkbox" value="0" class="form-control" checked DISABLED></td>
				<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
				<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
				<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
				<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
				<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
				<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
				<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
				<td><input type="text" size="4" class="form-control"></td>
				<td>
				<select name="runouts" class="form-control">
					<cfloop from="1" to="9" index="r">
						<cfoutput><option value="#r#">#r#</option></cfoutput>
					</cfloop>
					<option value="0">0</option>
					<option value="1">1</option>
				</select>
				</td>
			</tr>
			</form>
		</table>
		<div class="text-center"><button class="btn btn-primary" id="btnReg">Save</button></div>
		
	</div>

</cfif>





<script type="text/javascript">	
	
	$(function() 
		{	
				
		$(".btnEditForm").click(function() 
			{
			// Get which grade was clicked
		    thisFixtureID = $(this).attr('fixtureID');
		    
		    $(this).toggleClass("glyphicon-chevron-up");
			$(this).toggleClass("glyphicon-chevron-down");
						    
		    console.log(thisFixtureID);
		    
		    $(".editForm" + thisFixtureID).toggle();
		    
			});
			
		$(".saveResult").click(function() 
			{
			// Get Form Values
		    console.log("save!");	
		    
		    // Get Fixture ID
		    fixtureID = $(this).attr('fixtureID');
		    console.log("fixtureID: " + fixtureID);

		    

		    startTime = $("input[name=startTime" + fixtureID + "]:checked").val();
		    console.log(startTime);



		    
		    $("#saveIcon" + fixtureID).toggleClass( "fa-spin" ); 
		    
		    // Get Fixture Status
		    fixtureStatus = $("select[name=fixtureStatus" + fixtureID + "] option:selected").val();
		    console.log("fixtureStatus: " + fixtureStatus);
		    
		    // Get Rescheduled Week
		    rescheduledWeek = $("select[name=rescheduledWeek" + fixtureID + "] option:selected").val();
		    console.log("rescheduledWeek: " + rescheduledWeek);
		    
		    // Get Result ID
		    resultID = $(this).attr('resultID');
		    console.log("resultID: " + resultID);
		    
		    // Get Player IDs
		    homePlayerID = $(this).attr('homePlayerID');
		    console.log("homePlayerID: " + homePlayerID);
		    awayPlayerID = $(this).attr('awayPlayerID');
		    console.log("awayPlayerID: " + awayPlayerID);
		    
		    // Get Lag Value
		    lag = $("input[name=lag" + fixtureID + "]:checked").val();
		    console.log("lag: " + lag);
		    
		    // Get Runouts
		    homeRunouts = $("select[name=homeRunouts" + fixtureID + "] option:selected").val();
		    console.log("homeRunouts: " + homeRunouts);
		    awayRunouts = $("select[name=awayRunouts" + fixtureID + "] option:selected").val();
		    console.log("awayRunouts: " + awayRunouts);
		    
		    // Get Scores
		    homeScore = $("select[name=homeScore" + fixtureID + "] option:selected").val();
		    console.log("homeScore: " + homeScore);
		    awayScore = $("select[name=awayScore" + fixtureID + "] option:selected").val();
		    console.log("awayScore: " + awayScore);
		    
		    $(".homeScore" + fixtureID).text(homeScore);
		    $(".awayScore" + fixtureID).text(awayScore);
		    
	    	$.ajax({
				// the location of the CFC to run
				url: "../cfc/results.cfc?method=updateResults"
				// send a GET HTTP operation
				, type: "post"
				// tell jQuery we're getting JSON back
				// , dataType: "json"
				// send the data to the CFC
				, data: {
				    	// send the ID entered by the user
				    	EventID: <cfoutput>#eventId#</cfoutput>,
				    	FixtureID: fixtureID,
				    	ResultID: resultID,
				    	homePlayerID: homePlayerID,
				    	awayPlayerID: awayPlayerID,
				    	lag: lag,
				    	homeRunouts: homeRunouts,
				    	awayRunouts: awayRunouts,
				    	homeScore: homeScore,
				    	awayScore: awayScore,
				    	fixtureStatus: fixtureStatus,
				    	rescheduledWeek: rescheduledWeek,
				    	startTime: startTime
				  		}
				// this gets the data returned on success
				, success: function (data)
					{
					// this uses the "jquery.field.min.js" library to easily populate your form with the data from the server
					// alert("Success!");
					console.log("Sucess!" & data);
					// $(".editForm").slideUp("slow");
					
					$("#saveIcon"+ fixtureID).toggleClass( "fa-spin" ); 
					
					}
				// this runs if an error
				, error: function (xhr, textStatus, errorThrown)
					{
				    // show error
				    // alert(errorThrown);
				    console.log(errorThrown);	
				    
				    // $("#btnSave").toggleClass( "fa-spin" ); 
				  	}
				});
			});    
			
		}); // $ Ready End

</script>
	
<cfinclude template="../includes/inc_footer.cfm">




		
			<!--- LEFT COLUMN 
		 	<div class="col-lg-3">
		 	
		 		<!--- Profile Box --->
				<div class="panel panel-default">
					<div class="panel-heading text-left"><cfoutput><strong>PLAYER PROFILE</strong></cfoutput></div>	
					
					<div id="profilePic" class="panel-body text-center"></div>
					<div class="container" style="margin: 10px">
						<div class="row text-center">
							 <div class="col-lg-3 text-left">Name:</div>
							 <div class="col-lg-9 text-left">Craig Riley</div>
						</div>
						<div class="row text-center">
							 <div class="col-lg-3 text-left">Email:</div>
							 <div class="col-lg-9 text-left">craig@thelifeofriley.org</div>
						</div>
						<div class="row text-center">
							 <div class="col-lg-3 text-left"></div>
							 <div class="col-lg-9 text-left">
								 <h3><span class="label label-danger">Master</span></h3>
							</div>
						</div>
					</div>
				</div>
		 	
		 		<!--- Profile Box 
				<div class="panel panel-default">
					<div class="panel-heading text-left"><cfoutput><strong>LEAGUE FEES</strong></cfoutput></div>	
		    		<div class="panel-body text-left">
					    Bla...
					</div>
				</div>--->
		 	
		 		<!--- Master Stats 
				<div class="panel panel-danger">
					<div class="panel-heading text-left"><cfoutput><strong>MASTER STATS</strong></cfoutput></div>	
		    		<div class="panel-body text-danger text-center">
			    		<h5>Average win/loss margin</h5>
			    		<span class="text-center" style="font-size: 50px; font-weight: bolder"><cfif getAdvancedStats GT 0>+</cfif><cfoutput>#getMasterStats#</cfoutput></span>
					</div>
				</div>--->
		 	
		 		<!--- Advanced Stats --->
				<div class="panel panel-warning">
					<div class="panel-heading text-left"><cfoutput><strong>ADVANCED STATS</strong></cfoutput></div>	
		    		<div class="panel-body text-warning text-center">
			    		<h5>Average win/loss margin</h5>
			    		<span class="text-center" style="font-size: 50px; font-weight: bolder"><cfif getAdvancedStats GT 0>+</cfif><cfoutput>#getAdvancedStats#</cfoutput></span>
					</div>
				</div>
		 	
		 		<!--- Intermediate Stats --->
				<div class="panel panel-success">
					<div class="panel-heading text-left"><cfoutput><strong>INTERMEDIATE STATS</strong></cfoutput></div>	
		    		<div class="panel-body text-success text-center">
			    		<h5>Average win/loss margin</h5>
			    		<span class="text-center" style="font-size: 50px; font-weight: bolder"><cfif getAdvancedStats GT 0>+</cfif><cfoutput>#getIntermediateStats#</cfoutput></span>
					</div>
				</div>
		 	
		 		<!--- Open Stats --->
				<div class="panel panel-info">
					<div class="panel-heading text-left"><cfoutput><strong>OPEN STATS</strong></cfoutput></div>	
		    		<div class="panel-body text-info text-center">
			    		<h5>Average win/loss margin</h5>
			    		<span class="text-center" style="font-size: 50px; font-weight: bolder"><cfif getAdvancedStats GT 0>+</cfif><cfoutput>#getOpenStats#</cfoutput></span>
					</div>
				</div>
				
			</div>
			--->

	<!--- 
	<cfif NOT isDefined("Session.PlayerID")>

	  	function facebookInit()
	  		{
			// do what you would like here
			
			
			// Check if the current user is logged in and has authorized the app
	     	FB.getLoginStatus(checkLoginStatus);
	      
	      	// Login in the current user via Facebook and ask for email permission
	      	function authUser() 
	      		{
	        	FB.login(checkLoginStatus, {scope:'email'});
	      		}
	      
	      	// Check the result of the user status and display login button if necessary
	      	function checkLoginStatus(response) 
	      		{
	        	if(response && response.status == 'connected') 
	        	{
	          	console.log("User is authorized: " + response);
	          	
	          	// If logged in get info
	            getUserInfo();
	          
	          	// Hide the login button
	          	// document.getElementById('loginButton').style.display = 'none';
	          
	          	// Now Personalize the User Experience
	          	console.log('Access Token: ' + response.authResponse.accessToken);
	        	} 
	        else{
	          	console.log("User is not authorized: " + response);
	          	
	          	window.location.href="login.cfm";
	          	// Display the login button
	          	// document.getElementById('loginButton').style.display = 'block';
	        	}
	      	}
			
		}
		
		function getUserInfo() 
	  		{
	        FB.api('/me', function(response) 
	        	{
	        	getPhoto();
	        	
	        	console.log("getUserInfo!");
	        	console.log("Name: " + response.name);
	        	console.log("Link: " + response.link);
	        	console.log("Username: " + response.username);
	        	console.log("ID: " + response.id);
	        	console.log("email: " + response.email);
	        	
			   	// str +="<input type='button' value='Get Photo' onclick='getPhoto();'/>";
			    // str +="<input type='button' value='Logout' onclick='Logout();'/>";
		        // If successful login get player ID & set session
	    		});
	    	}
	</cfif>
	
	function getPhoto()
    	{
      	FB.api('/me/picture?type=large', function(response) 
      		{
          	var str="<img src='"+response.data.url+"' />";
          	document.getElementById("profilePic").innerHTML+=str; 
    		});
    	}
	
	window.fbAsyncInit = function () 
		{
	    // Initialize the Facebook JavaScript SDK
	   	FB.init({
	        appId: '1482838855321210',
	        xfbml: true,
	        status: true,
	        cookie: true,
      		});
	
	    // *** here is my code ***
	    if (typeof facebookInit == 'function') 
	    	{
	        facebookInit();
	    	}
		};
		
    function Logout()
    	{
        FB.logout(function()
        	{
        	window.location.href="login.cfm?logout=true";
        	// document.location.reload();
        	});
    	}  
      
      
    (function(d){
    var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
    js = d.createElement('script'); js.id = id; js.async = true;
    js.src = "//connect.facebook.net/en_US/all.js";
    d.getElementsByTagName('head')[0].appendChild(js);
	}(document));
	--->
	



<!--- 	
<script>
		        
	console.log("Console Test");
			
	// Login()
		// FB.login()
			// getUserInfo()
	
	// FB Login
	window.fbAsyncInit = function() 
	  	{
		        
		console.log("fbAsyncInit");
		
	    FB.init(
	    	{
	      	appId      : '1482838855321210', // Metro App ID
	      	// channelUrl : 'http://hayageek.com/examples/oauth/facebook/oauth-javascript/channel.html', // Channel File
	      	status     : true, // check login status
	      	cookie     : true, // enable cookies to allow the server to access the session
	      	xfbml      : true  // parse XFBML
	      	
	      	
	    	});

		
	
		test = FB.getLoginStatus(); 
		console.log(test);

	    FB.Event.subscribe('auth.authResponseChange', function(response)
	    	{
		        
			console.log(response);
	    	
	    		
	     	if (response.status === 'connected')
		    	{
		        // Successful FB login
		        document.getElementById("message").innerHTML += "<br>Connected to Facebook";
		        
		        $("#login").hide();
		        $("#MyMetro").show();
		        
		        console.log("connected!");
		    	}
		    else if (response.status === 'not_authorized')
		    	{
		        // FAILED
		        document.getElementById("message").innerHTML +=  "<br>Failed to Connect";
		        
		        console.log("Not authorized!");
		    	} 
		    else
		    	{
		        // UNKNOWN ERROR
		        document.getElementById("message").innerHTML +=  "<br>Logged Out";
		        
		        $("#login").show();
		        $("#MyMetro").hide();
		        
		        console.log("Unknown Error!");
		    	}
		    });
	    };
 
 
  	function Login()
    	{
        FB.login(function(response) 
        	{
           	if (response.authResponse)
           		{
                getUserInfo();
            	} 
            else{
             	console.log('User cancelled login or did not fully authorize.');
            	}
         	},
        	{scope: 'email,public_profile'});
   		}
   		
 
  	function getUserInfo() 
  		{
        FB.api('/me', function(response) 
        	{
		  	var str="<b>Name</b> : "+response.name+"<br>";
		   		str +="<b>Link: </b>"+response.link+"<br>";
		        str +="<b>Username:</b> "+response.username+"<br>";
		        str +="<b>id: </b>"+response.id+"<br>";
		        str +="<b>Email:</b> "+response.email+"<br>";
		        str +="<input type='button' value='Get Photo' onclick='getPhoto();'/>";
		        str +="<input type='button' value='Logout' onclick='Logout();'/>";
		        // document.getElementById("status").innerHTML=str;

		        // If successful login get player ID & set session
		        /**/
				$.ajax({
					// the location of the CFC to run
					url: "cfc/login.cfc?method=fbLogin"
					// send a GET HTTP operation
					, type: "get"
					// tell jQuery we're getting JSON back
					, dataType: "json"
					// send the data to the CFC
					, data: {
					    	// send the ID entered by the user
					    	fbEmail: response.email,
					    	fbToken: response.id
					  		}
					// this gets the data returned on success
					, success: function (data)
						{
						console.log("Ajax Sucess!");
						// console.log(data);
						}
					// this runs if an error
					, error: function (xhr, textStatus, errorThrown)
						{
						console.log("Ajax Error!");
					    console.log(errorThrown);	
					  	}
					});
				
					
				// Reload Page
				// location.reload();
		        
		        
    		});
    	}

    function getPhoto()
    	{
      	FB.api('/me/picture?type=normal', function(response) 
      		{
          	var str="<br/><b>Pic</b> : <img src='"+response.data.url+"'/>";
          	document.getElementById("status").innerHTML+=str; 
    		});
    	}

    
 
  	// Load the SDK asynchronously
  	(function(d)
	  	{
	    var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
	    if (d.getElementById(id)) {return;}
	    js = d.createElement('script'); js.id = id; js.async = true;
	    js.src = "//connect.facebook.net/en_US/all.js";
	    ref.parentNode.insertBefore(js, ref);
   		}
   	(document));
 
</script> --->



<!--- 
<script>
	
	// This page will either: a) send person to login page, or b) reload page after getting PlayerID
	
	
	window.fbAsyncInit = function() 
	  	{
	    FB.init(
	    	{
	      	appId      : '<cfoutput>#Application.MetroAppID#</cfoutput>', // Metro App ID
	      	// channelUrl : 'http://hayageek.com/examples/oauth/facebook/oauth-javascript/channel.html', // Channel File
	      	status     : true, // check login status
	      	cookie     : true, // enable cookies to allow the server to access the session
	      	xfbml      : true  // parse XFBML
	    	});
		
	    // *** here is my code ***
	    if (typeof facebookInit === 'function') 
	    	{
	        // facebookInit();
			console.log("yes");
	    	}
	    else{
			console.log("no");
	    	};
	    	
	    	
	    };
	
	// FB.getLoginStatus(checkLoginStatus);
	
	console.log("<cfoutput>#Application.MetroAppID#</cfoutput>");
	
		


	(function(d)
		{
    	var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
    	js = d.createElement('script'); js.id = id; js.async = true;
    	js.src = "//connect.facebook.net/en_US/all.js";
    	d.getElementsByTagName('head')[0].appendChild(js);
		}(document));


function facebookInit()
  		{
		// do what you would like here
		console.log("INIT");
		
		// Check if the current user is logged in and has authorized the app
	    FB.getLoginStatus(checkLoginStatus);

	    FB.Event.subscribe('auth.authResponseChange', function(response)
	    	{
	     	if (response.status === 'connected')
		    	{
		        console.log("connected!");
		        
		        // Successful FB login
		        // getUserInfo();
		    	}
		    else if (response.status === 'not_authorized')
		    	{
		        // FAILED
		        console.log("Not authorized!");
		        // Logout();
		    	} 
		    else
		    	{
		        // UNKNOWN ERROR
		        console.log("Unknown Error!");
		        // Logout();
		    	}
		    });
		};
		
	    
	function facebookInit()
	  		{
			// do what you would like here
			
			
			// Check if the current user is logged in and has authorized the app
	     	FB.getLoginStatus(checkLoginStatus);
	      
	      	// Login in the current user via Facebook and ask for email permission
	      	function authUser() 
	      		{
	        	FB.login(checkLoginStatus, {scope:'email'});
	      		};
	      
	      	// Check the result of the user status and display login button if necessary
	      	function checkLoginStatus(response) 
	      		{
	        	if(response && response.status == 'connected') 
		        	{
		          	console.log("User is authorized: " + response);
		          	
		          	// If logged in get info
		            getUserInfo();
		          
		          	// Hide the login button
		          	// document.getElementById('loginButton').style.display = 'none';
		          
		          	// Now Personalize the User Experience
		          	console.log('Access Token: ' + response.authResponse.accessToken);
		        	} 
		        else{
		          	console.log("User is not authorized: " + response);
		          	
		          	window.location.href="login.cfm";
		          	// Display the login button
		          	// document.getElementById('loginButton').style.display = 'block';
		        	};
	      		};
			
			};
	


	function getUserInfo()
		{
        FB.api('/me', function(response) 
        	{
        	
        	console.log("getUserInfo!");
        	console.log("Name: " + response.name);
        	console.log("Link: " + response.link);
        	console.log("Username: " + response.username);
        	console.log("ID: " + response.id);
        	console.log("email: " + response.email);
        	
		   	// str +="<input type='button' value='Get Photo' onclick='getPhoto();'/>";
		    // str +="<input type='button' value='Logout' onclick='Logout();'/>";
	        // If successful login get player ID & set session
    		});
    	};
	
	
	function getPhoto()
    	{
      	FB.api('/me/picture?type=large', function(response) 
      		{
          	var str="<img src='"+response.data.url+"' />";
          	document.getElementById("profilePic").innerHTML+=str; 
    		});
    	}
    	
		
    function Logout()
    	{
        FB.logout(function()
        	{
        	window.location.href="login.cfm?logout=true";
        	// document.location.reload();
        	});
    	}  

</script>

<div id="fb-root"></div>


<cfabort>
 --->