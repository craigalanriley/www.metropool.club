
<cfset thisPage = "Fixtures &amp; Results">
<cfinclude template="includes/inc_header.cfm">

    <section id="title" class="tournament-blue" style="padding: 50px">
        <div class="container">
            <div class="row">
				
                <div class="col-sm-6">
                    <h1><cfoutput>#thisPage#</cfoutput></h1>
                    <p>Use the simple navigation below to view all the seasons fixtures</p>
                </div>
                <div class="col-sm-6 hidden-xs">
                    <ul class="breadcrumb pull-right">
                        <li><a href="index.cfm">Home</a></li>
                        <li class="active"><cfoutput>#thisPage#</cfoutput></li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
	
	<section>
		<div class="container">
			
			<cfscript>

				EventID = 2;
							
				objFixtures = CreateObject("component","cfc.fixtures");
				
				if (isDefined("URL.round"))
					{
					CurrentRound = URL.round;
					}
				else{
					whichRound	= objFixtures.getRound(); // writeDump(whichRound);
					CurrentRound = whichRound.nextRound;
					}
				
				// Get Fixtures
				getFixtures = objFixtures.getFixtures(eventID=#EventID#, statusID='1,2,3,4,6', roundID=CurrentRound); // writeDump(getFixtures);


				getRescheduled = objFixtures.getFixtures(eventID=#EventID#, statusID='1,2,3,4,6', roundID=CurrentRound, Rescheduled = true); // writeDump(getRescheduled);
				
			</cfscript>
			
			<cfquery name="getRoundDate" datasource="metro">
				select round_date 
				from rounds 
				where round_name = #CurrentRound#
				and event_id = #EventID#
			</cfquery>
			
			<cfquery name="getTotalRounds" datasource="metro">
				select count(round_id) AS TotalRounds
				from rounds 
				where event_id = #EventID#
			</cfquery>
					
	    	<div class="row">
			 	<div class="col-lg-2"></div>
			 	<div class="col-lg-8 text-center">
								
					<cfoutput>
						<!--- Full Nav --->
						<div class="visible-lg visible-md visible-sm">
							<ul class="pagination  pagination-sm" style="padding:0!important;  !important; border: 1px solid ##ccc !important; margin-bottom: 20px">
								 <li class="<cfif CurrentRound EQ 1>disabled</cfif>"><a href="?round=#CurrentRound-1#">BACK</a></li>
								 <cfloop from="1" to="#getTotalRounds.TotalRounds#" index="round">
								 	<li class="<cfif round EQ CurrentRound>active</cfif>"><a href="?round=#round#">#round#</a></li>
								 </cfloop>
								 <li class="<cfif CurrentRound EQ #getTotalRounds.TotalRounds#>disabled</cfif>"><a href="?round=#CurrentRound+1#">NEXT</a></li>
							</ul>
						</div>
						<!--- Phone Nav --->
						<div class="visible-xs">
							<ul class="pagination  pagination-sm" style="padding:0!important;  !important; border: 1px solid ##ccc !important; margin-bottom: 20px">
								 <li class="<cfif CurrentRound EQ 1>disabled</cfif>"><a href="?round=#CurrentRound-1#">BACK</a></li>
								 <li class="active"><a href="?round=#CurrentRound#">#CurrentRound#</a></li>
								 <li class="<cfif CurrentRound EQ #getTotalRounds.TotalRounds#>disabled</cfif>"><a href="?round=#CurrentRound+1#">NEXT</a></li>
							</ul>
						</div>
					</cfoutput>
					
					<!--- <br /><h2 class="text-danger">League Fixtures</h2> --->
			 	
					<div class="panel table-responsive" style="background-color: #000000; color: #fff">
			    		<div class="panel-heading text-center"><cfoutput><strong>ROUND #CurrentRound# - <span class="text-default">#DateFormat(getRoundDate.round_date, "dd mmmm yyyy")#</span></strong></cfoutput></div>
					   	<table class="table" border="0">
						   	<tbody>
							   	<cfset Match 		= 0>
							   	<cfset prevRound 	= 0>
								<cfif getFixtures.RecordCount>
								   	<cfoutput query="getFixtures">
									   	<cfif round GT prevRound>
											<tr style="background-color: ##651616; color: silver;">
												<td class="fixture-rows">&nbsp;</td>
												<td class="fixture-rows text-center hidden-xs" title="Grade Match">GM</td>
												<td class="fixture-rows text-left">Match</td>
												<td class="fixture-rows text-left">Time</td>
												<td class="fixture-rows text-right">Player 1</td>
												<td class="fixture-rows text-center" width="0">
													<span class="hidden-xs hidden-sm">(Race to 7)</span>
												</td>
												<td class="fixture-rows text-left">Player 2</td>
											</tr>
											<cfset prevRound = getFixtures.round>
										</cfif>
									   	
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

										<cfif isDefined("prev_time") AND (scheduled_time NEQ prev_time)>
											<tr>
												<td colspan="8" style="background-color: ##555555; height: 5px"></td>
											</tr>
										</cfif>

										<tr style="background-color: ##333; color: white;">
											<td class="fixture-rows">
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
														<cfset fixtureClass = "fixture-pending">
													</cfcase>
													<cfcase value="4">
														<i class="fa fa-circle-o text-success" title="#status#"></i>
														<cfset fixtureClass = "fixture-pending">
													</cfcase>
													<cfcase value="6">
														<i class="fa fa-times-circle text-muted" title="#status#"></i>
														<cfset fixtureClass = "fixture-postponed">
													</cfcase>
													<cfdefaultcase></cfdefaultcase>
												</cfswitch>
											</td>

											<cfset aLeagueGrades = "1,2">
											<cfset bLeagueGrades = "3,4">
											<td class="hidden-xs fixture-rows text-center">
												<cfif (ListFind(aLeagueGrades, home_handicap_id) AND ListFind(aLeagueGrades, away_handicap_id)) OR (ListFind(bLeagueGrades, home_handicap_id) AND ListFind(bLeagueGrades, away_handicap_id))>
													<span class="glyphicon glyphicon-star" style="color: gold"></span>
												<cfelse>
													&nbsp;
												</cfif>
											</td>
											<td class="text-left fixture-rows #fixtureClass#">M<cfif fixture_id LT 10>0</cfif>#fixture_id#</td>
											<td class="text-left fixture-rows #fixtureClass#">
												<cfif right(scheduled_time, 10) EQ "00:00:00.0">
													TBC
												<cfelse>
													#LCase(TimeFormat(scheduled_time, "htt"))#
												</cfif>
											</td>
											<td class="#homeGradeClass# fixture-rows text-right">
												<span class="visible-xs visible-sm">#home_player_short#</span>
												<span class="hidden-xs hidden-sm">#home_player#</span>
											</td>
											<td class="text-center fixture-rows #fixtureClass#">
												<cfif ListFind("1,2", status_id)>
													<!--- Result --->
													<sup style="font-size:9px">
														<cfif homeRunouts>#homeRunouts#<cfelse>&nbsp;</cfif>
													</sup>
													#ToString(HomeScore7)#&nbsp;-&nbsp;#ToString(AwayScore7)#
													<sup style="font-size:9px">
														<cfif awayRunouts>#awayRunouts#<cfelse>&nbsp;</cfif>
													</sup>
												<cfelseif ListFind("3", status_id)>
													<!--- Live Scoring --->
													<code>#ToString(HomeScore7)#&nbsp;-&nbsp;#ToString(AwayScore7)#</code>
												<cfelseif ListFind("6", status_id)>
													<!--- Postponed --->
													<span class=" #fixtureClass#">
														#ToString(HomeScore7)#&nbsp;-&nbsp;#ToString(AwayScore7)#
													</span>
												<cfelse>
													<!--- Fixtures --->
													#ToString(HomeScore7)#&nbsp;-&nbsp;#ToString(AwayScore7)#
												</cfif>	
											</td>
											<td class="#awayGradeClass# fixture-rows text-left">
												<span class="visible-xs visible-sm">#away_player_short#</span>
												<span class="hidden-xs hidden-sm">#away_player#</span>
											</td>
										</tr>
										<cfset prev_time = scheduled_time>
									</cfoutput>

									<!--- Rescheduled Waitlist --->
								   	<tr>
										<td colspan="8" class="text-center" style="background-color: #000; color: white">
											<strong>Rescheduled Waitlist</strong>
										</td>
									</tr>
									<cfif NOT getRescheduled.RecordCount>	
										<tr>
											<td class="text-default text-center" colspan="8" style="padding: 50px; background-color: #333">Matches to be played on a first come first served basis</td>
										</tr>
									<cfelse>
										<cfset x = 0> 
										<cfset FixtureClass = "fixture-pending">
										<tr style="background-color: #651616; color: silver;">
											<td class="fixture-rows">&nbsp;</td>
											<td class="fixture-rows text-center hidden-xs" title="Grade Match">GM</td>
											<td class="fixture-rows text-left">Match</td>
											<td class="fixture-rows text-left">Time</td>
											<td class="fixture-rows text-right">Player 1</td>
											<td class="fixture-rows text-center" width="0">
												<span class="hidden-xs hidden-sm">(Race to 7)</span>
											</td>
											<td class="fixture-rows text-left">Player 2</td>
										</tr>
									   	<cfoutput query="getRescheduled">
									   		<cfset x = x + 1> 
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
											<cfswitch expression="#status_id#">
												<cfcase value="1">
													<cfset fixtureClass = "fixture-result">
												</cfcase>
												<cfcase value="2">
													<cfset fixtureClass = "fixture-result">
												</cfcase>
												<cfcase value="3">
													<cfset fixtureClass = "fixture-pending">
												</cfcase>
												<cfcase value="4">
													<cfset fixtureClass = "fixture-pending">
												</cfcase>
												<cfcase value="6">
													<cfset fixtureClass = "fixture-pending">
												</cfcase>
												<cfdefaultcase></cfdefaultcase>
											</cfswitch>
											<tr style="background-color: ##333; color: white;">
												<td class="fixture-rows #fixtureClass#">
													#x#.
												</td>
												<cfset aLeagueGrades = "1,2">
												<cfset bLeagueGrades = "3,4">
												<td class="hidden-xs fixture-rows text-center">
													<cfif (ListFind(aLeagueGrades, home_handicap_id) AND ListFind(aLeagueGrades, away_handicap_id)) OR (ListFind(bLeagueGrades, home_handicap_id) AND ListFind(bLeagueGrades, away_handicap_id))>
														<span class="glyphicon glyphicon-star" style="color: gold"></span>
													<cfelse>
														&nbsp;
													</cfif>
												</td>
												<td class="text-left fixture-rows #fixtureClass#">M<cfif fixture_id LT 10>0</cfif>#fixture_id#</td>
												<td class="text-left fixture-rows #fixtureClass#">
													<cfset rescheduledTime = DateFormat(date_rescheduled, "dd mmm") & " @ " &TimeFormat(date_rescheduled, "HH:mm:ss")>
													<abbr title="#rescheduledTime#">TBC</abbr>
												</td>
												<td class="#homeGradeClass# fixture-rows text-right">
													<span class="visible-xs visible-sm">#home_player_short#</span>
													<span class="hidden-xs hidden-sm">#home_player#</span>
												</td>
												<td class="text-center fixture-rows #fixtureClass#">
													<cfif ListFind("1,2", status_id)>
														<!--- Result --->
														<sup style="font-size:9px">
															<cfif homeRunouts>#homeRunouts#<cfelse>&nbsp;</cfif>
														</sup>
														#ToString(HomeScore7)#&nbsp;-&nbsp;#ToString(AwayScore7)#
														<sup style="font-size:9px">
															<cfif awayRunouts>#awayRunouts#<cfelse>&nbsp;</cfif>
														</sup>
													<cfelseif ListFind("3", status_id)>
														<!--- Live Scoring --->
														<code>#ToString(HomeScore7)#&nbsp;-&nbsp;#ToString(AwayScore7)#</code>
													<cfelseif ListFind("6", status_id)>
														<!--- Postponed --->
														<span class=" #fixtureClass#">
															#ToString(HomeScore7)#&nbsp;-&nbsp;#ToString(AwayScore7)#
														</span>
													<cfelse>
														<!--- Fixtures --->
														#ToString(HomeScore7)#&nbsp;-&nbsp;#ToString(AwayScore7)#
													</cfif>	
												</td>
												<td class="#awayGradeClass# fixture-rows text-left">
													<span class="visible-xs visible-sm">#away_player_short#</span>
													<span class="hidden-xs hidden-sm">#away_player#</span>
												</td>
											</tr>
										</cfoutput>
									</cfif>
									<!--- <tr>
										<td colspan="8" style="background-color: ##555555; height: 5px"></td>
									</tr> --->
								<cfelse>
									<tr>
										<th>Match</th>
										<th>Time</th>
										<th class="text-right">Player 1</th>
										<th class="text-center" width="0">(Race to 7)</th>
										<th class="text-left">Player 2</th>
										<th class="text-center hidden-xs text-center" title="Grade Match">GM</th>
									</tr>	
									<tr>
										<td class="text-danger text-center" colspan="8" style="padding: 50px">Full fixtures will appear here shortly</td>
									</tr>
								</cfif>
								<cfoutput>
								   	<tr>
										<td colspan="8" class="text-left" style="background-color: ##651616; color: white">Fixture key</td>	
									</tr>
								</cfoutput>
							</tbody>
						</table>
						<!--- Fixture Key --->
			    		<div class="panel-body text-left" style="background-color: ##333 !important;">
			    			<cfinclude template="includes/inc_legend.cfm">
						</div>
					</div><!--- End Panel --->
					
				</div><!--- End Col --->
			</div><!--- End Row --->	
		
		</div><!--- Container Row --->	
    </section>
	
    
<cfinclude template="includes/inc_footer.cfm">