
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
		
	    	<div class="row">
			 	<div class="col-lg-2"></div>
			 	<div class="col-lg-8 text-center">	
			    	
					<div class="panel panel-danger">
						<!-- Default panel contents -->
						<div class="panel-heading text-left"><strong>GRAND FINALS</strong> - 22-23 November 2014</div>
						<table class="table" border="0">
						   	<tbody>
								<tr>
									<td class="text-left" colspan="4" style="padding: 50px">Please ensure you keep the weekend of <strong class="text-danger">22-23 November 2014</strong> free as both the final round league fixtures and the grand finals will be played over these two days.</td>
								</tr>
							</tbody>
						</table>
					</div><!--- End Panel --->
						
				</div><!--- End Col --->
			</div><!--- End Row --->
			
			<cfscript>
							
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
				getFixtures = objFixtures.getFixtures(statusID='1,2,3,4', roundID=CurrentRound); // writeDump(CurrentRound);
				
			</cfscript>
			
			<cfquery name="getRoundDate" datasource="metro">
				select round_date from rounds 
				where round_id = #CurrentRound#
			</cfquery>
					
	    	<div class="row">
			 	<div class="col-lg-2"></div>
			 	<div class="col-lg-8 text-left">
			 	
					
					<!--- <br />
			 		<h2 class="text-danger">League Fixtures</h2> --->
			 	
					<div class="panel panel-default">
			    		<div class="panel-heading text-left"><cfoutput><strong>WEEK #CurrentRound# - <span class="text-danger">#DateFormat(getRoundDate.round_date, "dddd dd mmmm yyyy")#</span></strong></cfoutput></div>
					   	<table class="table" border="0">
						   	<tbody>
							   	<tr>
									<td colspan="7" style="background-color: ##fff" align="center">
									
									<cfoutput>
									<!--- Full Nav --->
									<div class="visible-lg visible-md visible-sm">
										<ul class="pagination  pagination-sm" style="padding:0!important;  !important; border: 1px solid ##ccc !important; margin-bottom: 20px">
											 <li class="<cfif CurrentRound EQ 1>disabled</cfif>"><a href="?round=#CurrentRound-1#">&laquo;</a></li>
											 <cfloop from="1" to="22" index="round">
											 	<li class="<cfif round EQ CurrentRound>active</cfif>"><a href="?round=#round#">#round#</a></li>
											 </cfloop>
											 <li class="<cfif CurrentRound EQ 22>disabled</cfif>"><a href="?round=#CurrentRound+1#">&raquo;</a></li>
										</ul>
									</div>
									<!--- Phone Nav --->
									<div class="visible-xs">
										<ul class="pagination  pagination-sm" style="padding:0!important;  !important; border: 1px solid ##ccc !important; margin-bottom: 20px">
											 <li class="<cfif CurrentRound EQ 1>disabled</cfif>"><a href="?round=#CurrentRound-1#">&laquo;</a></li>
											 <li class="active"><a href="?round=#CurrentRound#">#CurrentRound#</a></li>
											 <li class="<cfif CurrentRound EQ 21>disabled</cfif>"><a href="?round=#CurrentRound+1#">&raquo;</a></li>
										</ul>
									</div>
									</cfoutput>
									
									</td>	
								</tr>
							   	<cfset Match 		= 0>
							   	<cfset prevRound 	= 0>
								   	<cfif getFixtures.RecordCount>
								   	<cfoutput query="getFixtures">
									   	<cfif round GT prevRound>
											<tr style="background-color: ##fff">
												<th class="hidden-xs hidden-sm">&nbsp;</th>
												<th class="hidden-xs hidden-sm">Match</th>
												<th>Time</th>
												<th class="text-right">Player 1</th>
												<th class="text-center" width="0">(Race to 9)</th>
												<th class="text-left">Player 2</th>
												<th class="text-center hidden-xs" title="Grade Match">GM</th>
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
											<cfset HomeScore = HomeStart>
											<cfset AwayScore = AwayStart>
										</cfif>
										<!--- 
										1-Master
										--->
										<tr>
											<td class="hidden-xs hidden-sm">
												<cfswitch expression="#status_id#">
													<cfcase value="1">
														<i class="fa fa-circle text-muted" title="#status#"></i>
													</cfcase>
													<cfcase value="2">
														<i class="fa fa-spinner fa-frown-o text-muted" title="#status#"></i>
													</cfcase>
													<cfcase value="3">
														<i class="fa fa-spinner fa-spin text-danger" title="#status#"></i>
													</cfcase>
													<cfcase value="4">
														<i class="fa fa-circle-o text-muted" title="#status#"></i>
													</cfcase>
													<cfdefaultcase>
														
													</cfdefaultcase>
												</cfswitch>
											</td>
											<td class="text-muted text-left hidden-xs hidden-sm">M<cfif fixture_id LT 10>0</cfif>#fixture_id#</td>
											<td class="text-left">#TimeFormat(scheduled_time, "HH:MM")#</td>
											<td class="#homeGradeClass# text-right">
												<span class="visible-xs visible-sm">#home_player_short#</span>
												<span class="hidden-xs hidden-sm">#home_player#</span>
											</td>
											<td class="text-center" width="0">
												<cfif status_id EQ 3>
													<code>#ToString(HomeScore)# - #ToString(AwayScore)#</code>
												<cfelseif status_id EQ 2>
													<span style="color: ##CCC"><strong>#ToString(HomeScore)# - #ToString(AwayScore)#</strong></span>
												<cfelse>
													<span class="text-muted">
														<sup style="font-size:9px"><cfif homeRunouts>#homeRunouts#<cfelse>&nbsp;</cfif></sup>
														<strong>#ToString(HomeScore)# - #ToString(AwayScore)#</strong>
														<sup style="font-size:9px"><cfif awayRunouts>#awayRunouts#<cfelse>&nbsp;</cfif></sup>
													</span>
												</cfif>	
											</td>
											<td class="#awayGradeClass# text-left">
												<span class="visible-xs visible-sm">#away_player_short#</span>
												<span class="hidden-xs hidden-sm">#away_player#</span>
											</td>
											<td class="hidden-xs">
											<cfif HomeStart EQ AwayStart>
												<span class="glyphicon glyphicon-star" style="color: gold"></span>
											<cfelse>
												&nbsp;
											</cfif>
											</td>
										</tr>
									</cfoutput>
								<cfelse>
									<tr>
										<th class="hidden-xs hidden-sm">Match</th>
										<th>Time</th>
										<th class="text-right">Player 1</th>
										<th class="text-center" width="0">(Race to 9)</th>
										<th class="text-left">Player 2</th>
										<th class="text-center hidden-xs" title="Grade Match">GM</th>
									</tr>	
									<tr>
										<td class="text-danger" colspan="6" style="padding: 50px">Full fixtures will appear here shortly</td>
									</tr>
								</cfif>
								<cfoutput>
								   	<tr>
										<td colspan="7" class="text-left" style="background-color: ##f5f5f5; color: black">Please Note</td>	
									</tr>
								</cfoutput>
							</tbody>
						</table>
			    		<div class="panel-body text-left">
						    Match times are dependant on previous matches and +2 frame handicap per grade difference have been added.
						    <br /><br />
						    If a player is late for their match they will forfeit 1 frame for every 10 mintes ellapsed after the scheduled start time.
						</div>
					</div><!--- End Panel --->
					
				</div><!--- End Col --->
			</div><!--- End Row --->	
		
		</div><!--- Container Row --->	
    </section>
	
    
<cfinclude template="includes/inc_footer.cfm">