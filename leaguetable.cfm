
<cfset thisPage = "League Table">
<cfinclude template="includes/inc_header.cfm">

<cfscript> 

	PrizeColor = "FFF";
	thisEventID = 2;
	
	// Create Results Object
	objResults = CreateObject("component","cfc.results"); 
	// Create Fixtures Object
	objFixtures = CreateObject("component","cfc.fixtures");

	
	// Handicapped Table
	allFixtures 		= objFixtures.getGradedFixtures(EventID=#thisEventID#, HandicapID="1,2,3,4"); 
	allNotPlayed		= objFixtures.getGradedNotPlayed(FixtureList=allFixtures);
	allResults 			= objResults.getResults(EventID=#thisEventID#);

	// League A 
	aFixtures 			= objFixtures.getGradedFixtures(EventID=#thisEventID#, HandicapID="1,2"); 
	aNotPlayed			= objFixtures.getGradedNotPlayed(FixtureList=aFixtures, HandicapID="1,2"); // writeDump(aNotPlayed);
	aResults 			= objResults.getResults(EventID=#thisEventID#, FixtureList=aFixtures);

	// League B
	bFixtures 			= objFixtures.getGradedFixtures(EventID=#thisEventID#, HandicapID="3,4"); 
	bNotPlayed			= objFixtures.getGradedNotPlayed(FixtureList=bFixtures, HandicapID="3,4");
	bResults 			= objResults.getResults(EventID=#thisEventID#, FixtureList=bFixtures);
	
	// B&R Table
	bnrResults 			= objResults.getRunouts(EventID=#thisEventID#);


	
	// Advanced Table
	// advFixtures 		= objFixtures.getGradedFixtures(EventID=#thisEventID#, HandicapID=2); 
	// advNotPlayed		= objFixtures.getGradedNotPlayed(HandicapID=2, FixtureList=advFixtures); 
	// advResults 			= objResults.getResults(EventID=#thisEventID#, FixtureList=advFixtures);
	
	// Intermediate Table
	// intFixtures 		= objFixtures.getGradedFixtures(EventID=#thisEventID#, HandicapID=3); 
	// intNotPlayed		= objFixtures.getGradedNotPlayed(HandicapID=3, FixtureList=intFixtures);
	// intResults 			= objResults.getResults(EventID=#thisEventID#, FixtureList=intFixtures);
	
	// Open Table
	// openFixtures 		= objFixtures.getGradedFixtures(EventID=#thisEventID#, HandicapID=4);
	// openNotPlayed		= objFixtures.getGradedNotPlayed(HandicapID=4, FixtureList=openFixtures);
	// openResults 		= objResults.getResults(EventID=#thisEventID#, FixtureList=openFixtures);

	// Debug:
	// writeDump(openFixtures);
	// writeDump(openNotPlayed);
	// writeDump(openResults);

</cfscript>

<section id="title" class="tournament-blue">
	<div class="container">
	    <div class="row">
	        <div class="col-sm-6">
	            <h1><cfoutput>#thisPage#</cfoutput></h1>
	            <p>The league tables will be updated in real time when results are submitted!</p>
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

<section class="container">

	<div class="col-md-2 hidden-xs"></div>
   	<div class="col-md-8 col-xs-12">

		<br />
 		<h2 class="text-danger">Overall League Table</h2>
 		<div class="panel panel-default table-responsive">
		  	<!-- Table -->
		  	<table class="table table-hover">
			<thead>
				<tr class="active">
					<th title="Place / Seed">#</th>
					<th>Player (Grade)</th>
					<th class="text-center" title="Matches Played">
						<span class="visible-xs visible-sm">Pld</span>
						<span class="hidden-xs hidden-sm">Played</span>
					</th>
					<th class="hidden-xs hidden-sm text-center" title="Matches Won">Won</th>
					<th class="hidden-xs hidden-sm text-center" title="Matches Lost">Lost</th>
					<th class="hidden-xs hidden-sm text-center" title="Lags Won">Lag</th>
					<th class="hidden-xs hidden-sm text-center" title="Games For">GF</th>
					<th class="hidden-xs hidden-sm text-center" title="Games Against">GA</th>
					<th class="text-center" title="Games Difference">GD</th>
					<th class="text-center" title="Break &amp; Runs">B&amp;R</th>
					<th class="text-center">
						<span class="visible-xs visible-sm">Pts</span>
						<span class="hidden-xs hidden-sm">Points</span>
					</th>
					<th>&nbsp;</th>
				</tr>
			</thead>	
			<tbody>
				<cfset pos = 1>
				<cfoutput query="allResults">
					<cfif pos EQ 9>
						<cfset lineClass = "ByeLine">
					<cfelse>
						<cfset lineClass = "">
					</cfif>
					<cfswitch expression="#handicap_id#">
						<cfcase value="1"><cfset gradeClass = "text-danger"></cfcase>
						<cfcase value="2"><cfset gradeClass = "text-warning"></cfcase>
						<cfcase value="3"><cfset gradeClass = "text-success"></cfcase>
						<cfcase value="4"><cfset gradeClass = "text-primary"></cfcase>
					</cfswitch>
					<tr>
						<td class="#lineClass#"><cfif pos LT 10>0</cfif>#pos#.</td>
						<td class="#gradeClass# #lineClass#">
							<span class="visible-xs visible-sm">#player_short#</span>
							<span class="hidden-xs hidden-sm">#first_name# #last_name#</span>
						</td>
						<td class="text-center #lineClass#">#gamesPlayed#</td>
						<td class="#lineClass# hidden-xs hidden-sm text-center">#matchesWon#</td>
						<td class="#lineClass# hidden-xs hidden-sm text-center">#matchesLost#</td>
						<td class="#lineClass# hidden-xs hidden-sm text-center"><abbr title="#lagPercent#">#lagsWon#</abbr></td>
						<td class="#lineClass# hidden-xs hidden-sm text-center">#gamesWon#</td>
						<td class="#lineClass# hidden-xs hidden-sm text-center">#gamesLost#</td>
						<td class="#lineClass# text-center"><cfif gamesDiff GT 0>+</cfif>#gamesDiff#</td>
						<td class="#lineClass# text-center">#runouts#</td>
						<td class="#lineClass# text-center text-danger">#totalPoints#</td>
						<td class="#lineClass#"><cfif pos LT 4><a href="prizes.cfm" style="color: gold">$</a></cfif></td>
					</tr>
					<cfset pos = pos + 1>
				</cfoutput>
				<cfoutput query="allNotPlayed">
					<cfswitch expression="#handicap_id#">
						<cfcase value="1"><cfset gradeClass = "text-danger"></cfcase>
						<cfcase value="2"><cfset gradeClass = "text-warning"></cfcase>
						<cfcase value="3"><cfset gradeClass = "text-success"></cfcase>
						<cfcase value="4"><cfset gradeClass = "text-primary"></cfcase>
					</cfswitch>
					<tr <cfif pos EQ 1>style="font-weight: bold"</cfif>>
						<td><cfif pos LT 10>0</cfif>#pos#.</td>
						<td class="#gradeClass#">
							<span class="visible-xs visible-sm">#player_short#</span>
							<span class="hidden-xs hidden-sm">#first_name# #last_name#</span>
						</td>
						<td class="text-center">0</td>
						<td class="hidden-xs hidden-sm text-center">0</td>
						<td class="hidden-xs hidden-sm text-center">0</td>
						<td class="hidden-xs hidden-sm text-center">0</td>
						<td class="hidden-xs hidden-sm text-center">0</td>
						<td class="hidden-xs hidden-sm text-center">0</td>
						<td class="text-center">0</td>
						<td class="text-center">0</td>
						<td class="text-center text-danger">0</td>
						<td>&nbsp;</td>
					</tr>
					<cfset pos = pos + 1>
				</cfoutput>
			</tbody>
			</table>
		</div>
		<br />


		
		<br />
 		<h2 class="text-danger">Division 1 League Table</h2>
 		<div class="panel panel-default table-responsive">
		  	<!-- Table -->
		  	<table class="table table-hover">
			<thead>
				<tr class="active">
					<th title="Place / Seed">#</th>
					<th>Player (Grade)</th>
					<th class="text-center" title="Matches Played">
						<span class="visible-xs visible-sm">Pld</span>
						<span class="hidden-xs hidden-sm">Played</span>
					</th>
					<th class="hidden-xs hidden-sm text-center" title="Matches Won">Won</th>
					<th class="hidden-xs hidden-sm text-center" title="Matches Lost">Lost</th>
					<th class="hidden-xs hidden-sm text-center" title="Lags Won">Lag</th>
					<th class="hidden-xs hidden-sm text-center" title="Games For">GF</th>
					<th class="hidden-xs hidden-sm text-center" title="Games Against">GA</th>
					<th class="text-center" title="Games Difference">GD</th>
					<th class="text-center" title="Break &amp; Runs">B&amp;R</th>
					<th class="text-center">
						<span class="visible-xs visible-sm">Pts</span>
						<span class="hidden-xs hidden-sm">Points</span>
					</th>
					<th>&nbsp;</th>
				</tr>
			</thead>	
			<tbody>
				<cfset pos = 1>
				<cfoutput query="aResults">
					<cfswitch expression="#handicap_id#">
						<cfcase value="1"><cfset gradeClass = "text-danger"></cfcase>
						<cfcase value="2"><cfset gradeClass = "text-warning"></cfcase>
						<cfcase value="3"><cfset gradeClass = "text-success"></cfcase>
						<cfcase value="4"><cfset gradeClass = "text-primary"></cfcase>
					</cfswitch>
					<tr>
						<td><cfif pos LT 10>0</cfif>#pos#.</td>
						<td class="#gradeClass#">
							<span class="visible-xs visible-sm">#player_short#</span>
							<span class="hidden-xs hidden-sm">#first_name# #last_name#</span>
						</td>
						<td class="text-center">#gamesPlayed#</td>
						<td class="hidden-xs hidden-sm text-center">#matchesWon#</td>
						<td class="hidden-xs hidden-sm text-center">#matchesLost#</td>
						<td class="hidden-xs hidden-sm text-center"><abbr title="#lagPercent#">#lagsWon#</abbr></td>
						<td class="hidden-xs hidden-sm text-center">#gamesWon#</td>
						<td class="hidden-xs hidden-sm text-center">#gamesLost#</td>
						<td class="text-center"><cfif gamesDiff GT 0>+</cfif>#gamesDiff#</td>
						<td class="text-center">#runouts#</td>
						<td class="text-center text-danger">#totalPoints#</td>
						<td><cfif pos LT 3><a href="prizes.cfm" style="color: gold">$</a></cfif></td>
					</tr>
					<cfset pos = pos + 1>
				</cfoutput>
				<!--- Players in division that haven't played a match yet --->
				<cfoutput query="aNotPlayed">
					<cfswitch expression="#handicap_id#">
						<cfcase value="1"><cfset gradeClass = "text-danger"></cfcase>
						<cfcase value="2"><cfset gradeClass = "text-warning"></cfcase>
						<cfcase value="3"><cfset gradeClass = "text-success"></cfcase>
						<cfcase value="4"><cfset gradeClass = "text-primary"></cfcase>
					</cfswitch>
					<tr <cfif pos EQ 1>style="font-weight: bold"</cfif>>
						<td><cfif pos LT 10>0</cfif>#pos#.</td>
						<td class="#gradeClass#">
							<span class="visible-xs visible-sm">#player_short#</span>
							<span class="hidden-xs hidden-sm">#first_name# #last_name#</span>
						</td>
						<td class="text-center">0</td>
						<td class="hidden-xs hidden-sm text-center">0</td>
						<td class="hidden-xs hidden-sm text-center">0</td>
						<td class="hidden-xs hidden-sm text-center">0</td>
						<td class="hidden-xs hidden-sm text-center">0</td>
						<td class="hidden-xs hidden-sm text-center">0</td>
						<td class="text-center">0</td>
						<td class="text-center">0</td>
						<td class="text-center text-danger">0</td>
						<td>&nbsp;</td>
					</tr>
					<cfset pos = pos + 1>
				</cfoutput>
			</tbody>
			</table>
		</div>
		<br />
		
		<br />
 		<h2 class="text-danger">Division 2 League Table</h2>
 		<div class="panel panel-default table-responsive">
		  	<!-- Table -->
		  	<table class="table table-hover">
			<thead>
				<tr class="active">
					<th title="Place / Seed">#</th>
					<th>Player (Grade)</th>
					<th class="text-center" title="Matches Played">
						<span class="visible-xs visible-sm">Pld</span>
						<span class="hidden-xs hidden-sm">Played</span>
					</th>
					<th class="hidden-xs hidden-sm text-center" title="Matches Won">Won</th>
					<th class="hidden-xs hidden-sm text-center" title="Matches Lost">Lost</th>
					<th class="hidden-xs hidden-sm text-center" title="Lags Won">Lag</th>
					<th class="hidden-xs hidden-sm text-center" title="Games For">GF</th>
					<th class="hidden-xs hidden-sm text-center" title="Games Against">GA</th>
					<th class="text-center" title="Games Difference">GD</th>
					<th class="text-center" title="Break &amp; Runs">B&amp;R</th>
					<th class="text-center">
						<span class="visible-xs visible-sm">Pts</span>
						<span class="hidden-xs hidden-sm">Points</span>
					</th>
					<th>&nbsp;</th>
				</tr>
			</thead>	
			<tbody>
				<cfset pos = 1>
				<cfoutput query="bResults">
					<cfswitch expression="#handicap_id#">
						<cfcase value="1"><cfset gradeClass = "text-danger"></cfcase>
						<cfcase value="2"><cfset gradeClass = "text-warning"></cfcase>
						<cfcase value="3"><cfset gradeClass = "text-success"></cfcase>
						<cfcase value="4"><cfset gradeClass = "text-primary"></cfcase>
					</cfswitch>
					<tr>
					<!--- <tr <cfif pos EQ 1>style="font-weight: bold"</cfif>> --->
						<td><cfif pos LT 10>0</cfif>#pos#.</td>
						<td class="#gradeClass#">
							<span class="visible-xs visible-sm">#player_short#</span>
							<span class="hidden-xs hidden-sm">#first_name# #last_name#</span>
						</td>
						<td class="text-center">#gamesPlayed#</td>
						<td class="hidden-xs hidden-sm text-center">#matchesWon#</td>
						<td class="hidden-xs hidden-sm text-center">#matchesLost#</td>
						<td class="hidden-xs hidden-sm text-center"><abbr title="#lagPercent#">#lagsWon#</abbr></td>
						<td class="hidden-xs hidden-sm text-center">#gamesWon#</td>
						<td class="hidden-xs hidden-sm text-center">#gamesLost#</td>
						<td class="text-center"><cfif gamesDiff GT 0>+</cfif>#gamesDiff#</td>
						<td class="text-center">#runouts#</td>
						<td class="text-center text-danger">#totalPoints#</td>
						<td><cfif pos LT 3><a href="prizes.cfm" style="color: gold">$</a></cfif></td>
					</tr>
					<cfset pos = pos + 1>
				</cfoutput>
				<!--- Players in division that haven't played a match yet --->
				<cfoutput query="bNotPlayed">
					<cfswitch expression="#handicap_id#">
						<cfcase value="1"><cfset gradeClass = "text-danger"></cfcase>
						<cfcase value="2"><cfset gradeClass = "text-warning"></cfcase>
						<cfcase value="3"><cfset gradeClass = "text-success"></cfcase>
						<cfcase value="4"><cfset gradeClass = "text-primary"></cfcase>
					</cfswitch>
					<tr <cfif pos EQ 1>style="font-weight: bold"</cfif>>
						<td><cfif pos LT 10>0</cfif>#pos#.</td>
						<td class="#gradeClass#">
							<span class="visible-xs visible-sm">#player_short#</span>
							<span class="hidden-xs hidden-sm">#first_name# #last_name#</span>
						</td>
						<td class="text-center">0</td>
						<td class="hidden-xs hidden-sm text-center">0</td>
						<td class="hidden-xs hidden-sm text-center">0</td>
						<td class="hidden-xs hidden-sm text-center">0</td>
						<td class="hidden-xs hidden-sm text-center">0</td>
						<td class="hidden-xs hidden-sm text-center">0</td>
						<td class="text-center">0</td>
						<td class="text-center">0</td>
						<td class="text-center text-danger">0</td>
						<td>&nbsp;</td>
					</tr>
					<cfset pos = pos + 1>
				</cfoutput>
			</tbody>
			</table>
		</div>
		<br />
		<h2 class="text-danger">Break &amp; Run Qualifiers</h2>
	 	<div class="panel panel-default table-responsive">
	 		<!-- Table -->
		  	<table class="table table-hover">
			<thead>
				<tr class="active">
					<th title="Place / Seed">#</th>
					<th>Player</th>
					<th class="text-center" title="Matches Played">
						<span class="visible-xs visible-sm">Pld</span>
						<span class="hidden-xs hidden-sm">Played</span>
					</th>
					<th class="hidden-xs hidden-sm text-center" title="Lags Won">Lags</th>
					<th class="hidden-xs hidden-sm text-center" title="Frames Played">Frames</th>
					<th class="hidden-xs hidden-sm text-center" title="Total Breaks">Breaks</th>
					<th class="text-center" title="Break &amp; Run Percentage">B&amp;R %</th>
					<th class="text-center" title="Total Break &amp; Runs">B&Rs</th>
					<th class="text-right">&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				<cfset pos = 1>
				<cfoutput query="bnrResults">
					<cfswitch expression="#grade#">
						<cfcase value="1"><cfset gradeClass = "text-danger"></cfcase>
						<cfcase value="2"><cfset gradeClass = "text-warning"></cfcase>
						<cfcase value="3"><cfset gradeClass = "text-success"></cfcase>
						<cfcase value="4"><cfset gradeClass = "text-primary"></cfcase>
					</cfswitch>
					<cfif pos EQ 1 OR grade GT prevGrade>
						<cfset pos = 1>
					</cfif>
					<tr  <cfif NOT ListFind("1,16,24",pos)>class="grade#grade#" style="display:none"<cfelse>style="font-weight: bold"</cfif>>
						<td class="#gradeClass#"><cfif pos LT 10>0</cfif>#pos#.</td>
						<td style="width: 150px" class="#gradeClass#">
							<span class="visible-xs visible-sm">#player_short#</span>
							<span class="hidden-xs hidden-sm">#player#</span>
						</td>
						<td class="text-center">#gamesPlayed#</td>
						<td class="hidden-xs hidden-sm text-center">#lagsWon#</td>
						<td class="hidden-xs hidden-sm text-center">#totalGames#</td>
						<td class="hidden-xs hidden-sm text-center">#totalBreaks#</td>
						<td class="text-center">#NumberFormat(totalPercent,"__.__")#%</td>
						<td class="text-center text-danger">#totalRunouts#</td>
						<td>
						<cfif pos EQ 1 OR grade GT prevGrade>
							<span grade="#grade#" class="glyphicon glyphicon-chevron-down btnBnR" style="cursor: pointer"></span>
						</cfif>
						</td>
					</tr>
					<cfset pos = pos + 1>
					<cfset prevGrade = grade>
				</cfoutput>
				<tr>
					<td colspan="9" class="hidden-xs hidden-sm text-muted">
						<strong><span class="fa fa-warning text-danger"></span></strong> 
						Forfeits do not count towards break and run stats, only matches that were played.
					</td>
				</tr>
			</tbody>
			</table>
		</div>

		<!--- 
		<br />
		<h2 class="text-danger">Advanced League Table</h2>
	  	<div class="panel panel-danger table-responsive">
		  	<!-- Table -->
		  	<table class="table table-hover">
			<thead>
				<tr class="warning">
					<th title="Place / Seed">#</th>
					<th>Player (Grade)</th>
					<th class="text-center" title="Matches Played">
						<span class="visible-xs visible-sm">Pld</span>
						<span class="hidden-xs hidden-sm">Played</span>
					</th>
					<th class="hidden-xs hidden-sm text-center" title="Matches Won">Won</th>
					<th class="hidden-xs hidden-sm text-center" title="Matches Lost">Lost</th>
					<th class="hidden-xs hidden-sm text-center" title="Matches Lost">Lags</th>
					<th class="hidden-xs hidden-sm text-center" title="Games For">GF</th>
					<th class="hidden-xs hidden-sm text-center" title="Games Against">GA</th>
					<th class="text-center" title="Games Difference">GD</th>
					<th class="text-center" title="Break &amp; Runs">B&amp;R</th>
					<th class="text-center">
						<span class="visible-xs visible-sm">Pts</span>
						<span class="hidden-xs hidden-sm">Points</span>
					</th>
				</tr>
			</thead>
			<tbody>
				<cfset pos = 1>
				<cfoutput query="advResults">
					<tr <cfif pos EQ 1>style="font-weight: bold"</cfif>>
						<td class="text-warning"><cfif pos LT 10>0</cfif>#pos#.</td>
						<td class="text-warning">
							<span class="visible-xs visible-sm">#player_short#</span>
							<span class="hidden-xs hidden-sm">#first_name# #last_name#</span>
						</td>
						<td class="text-center">#gamesPlayed#</td>
						<td class="hidden-xs hidden-sm text-center">#matchesWon#</td>
						<td class="hidden-xs hidden-sm text-center">#matchesLost#</td>
						<td class="hidden-xs hidden-sm text-center">#lagsWon#</td>
						<td class="hidden-xs hidden-sm text-center">#gamesWon#</td>
						<td class="hidden-xs hidden-sm text-center">#gamesLost#</td>
						<td class="text-center"><cfif gamesDiff GT 0>+</cfif>#gamesDiff#</td>
						<td class="text-center">#runouts#</td>
						<td class="text-center text-danger">#totalPoints#</td>
					</tr>
					<cfset pos = pos + 1>
				</cfoutput>
			</tbody>
			</table>
		</div>
		<br />
		<h2 class="text-danger">Intermediate League Table</h2>
	 	<div class="panel panel-danger table-responsive">
		  	<!-- Table -->
		  	<table class="table table-hover">
			<thead>
				<tr class="success">
					<th title="Place / Seed">#</th>
					<th>Player (Grade)</th>
					<th class="text-center" title="Matches Played">
						<span class="visible-xs visible-sm">Pld</span>
						<span class="hidden-xs hidden-sm">Played</span>
					</th>
					<th class="hidden-xs hidden-sm text-center" title="Matches Won">Won</th>
					<th class="hidden-xs hidden-sm text-center" title="Matches Lost">Lost</th>
					<th class="hidden-xs hidden-sm text-center" title="Matches Lost">Lags</th>
					<th class="hidden-xs hidden-sm text-center" title="Games For">GF</th>
					<th class="hidden-xs hidden-sm text-center" title="Games Against">GA</th>
					<th class="text-center" title="Games Difference">GD</th>
					<th class="text-center" title="Break &amp; Runs">B&amp;R</th>
					<th class="text-center">
						<span class="visible-xs visible-sm">Pts</span>
						<span class="hidden-xs hidden-sm">Points</span>
					</th>
				</tr>
			</thead>
			<tbody>
				<cfset pos = 1>
				<cfoutput query="intResults">
					<tr <cfif pos EQ 1>style="font-weight: bold"</cfif>>
						<td class="text-success"><cfif pos LT 10>0</cfif>#pos#.</td>
						<td class="text-success">
							<span class="visible-xs visible-sm">#player_short#</span>
							<span class="hidden-xs hidden-sm">#first_name# #last_name#</span>
						</td>
						<td class="text-center">#gamesPlayed#</td>
						<td class="hidden-xs hidden-sm text-center">#matchesWon#</td>
						<td class="hidden-xs hidden-sm text-center">#matchesLost#</td>
						<td class="hidden-xs hidden-sm text-center">#lagsWon#</td>
						<td class="hidden-xs hidden-sm text-center">#gamesWon#</td>
						<td class="hidden-xs hidden-sm text-center">#gamesLost#</td>
						<td class="text-center"><cfif gamesDiff GT 0>+</cfif>#gamesDiff#</td>
						<td class="text-center">#runouts#</td>
						<td class="text-center text-danger">#totalPoints#</td>
					</tr>
					<cfset pos = pos + 1>
				</cfoutput>
				<cfoutput query="intNotPlayed">
					<tr>
						<td><cfif pos LT 10>0</cfif>#pos#.</td>
						<td class="text-success">#first_name# #last_name#</td>
						<td class="text-center">0</td>
						<td class="text-center">0</td>
						<td class="text-center">0</td>
						<td class="text-center">0</td>
						<td class="text-center">0</td>
						<td class="text-center">0</td>
						<td class="text-center">0</td>
						<td class="text-center">0</td>
						<td class="text-center text-danger">0</td>
					</tr>
					<cfset pos = pos + 1>
				</cfoutput>
			</tbody>
			</table>
		</div>
		<br />
		<h2 class="text-danger">Open League Table</h2>
	 	<div class="panel panel-danger table-responsive">
		  	<!-- Table -->
		  	<table class="table table-hover">
			<thead>
				<tr class="info" style="background-color: #BCE8F1">
					<th title="Place / Seed">#</th>
					<th>Player (Grade)</th>
					<th class="text-center" title="Matches Played">
						<span class="visible-xs visible-sm">Pld</span>
						<span class="hidden-xs hidden-sm">Played</span>
					</th>
					<th class="hidden-xs hidden-sm text-center" title="Matches Won">Won</th>
					<th class="hidden-xs hidden-sm text-center" title="Matches Lost">Lost</th>
					<th class="hidden-xs hidden-sm text-center" title="Matches Lost">Lags</th>
					<th class="hidden-xs hidden-sm text-center" title="Games For">GF</th>
					<th class="hidden-xs hidden-sm text-center" title="Games Against">GA</th>
					<th class="text-center" title="Games Difference">GD</th>
					<th class="text-center" title="Break &amp; Runs">B&amp;R</th>
					<th class="text-center">
						<span class="visible-xs visible-sm">Pts</span>
						<span class="hidden-xs hidden-sm">Points</span>
					</th>
				</tr>
			</thead>
			<tbody>
				<cfset pos = 1>
				<cfoutput query="openResults">
					<tr <cfif pos EQ 1>style="font-weight: bold"</cfif>>
						<td class="text-primary"><cfif pos LT 10>0</cfif>#pos#.</td>
						<td class="text-primary">
							<span class="visible-xs visible-sm">#player_short#</span>
							<span class="hidden-xs hidden-sm">#first_name# #last_name#</span>
						</td>
						<td class="text-center">#gamesPlayed#</td>
						<td class="hidden-xs hidden-sm text-center">#matchesWon#</td>
						<td class="hidden-xs hidden-sm text-center">#matchesLost#</td>
						<td class="hidden-xs hidden-sm text-center">#lagsWon#</td>
						<td class="hidden-xs hidden-sm text-center">#gamesWon#</td>
						<td class="hidden-xs hidden-sm text-center">#gamesLost#</td>
						<td class="text-center"><cfif gamesDiff GT 0>+</cfif>#gamesDiff#</td>
						<td class="text-center">#runouts#</td>
						<td class="text-center text-danger">#totalPoints#</td>
					</tr>
					<cfset pos = pos + 1>
				</cfoutput>
			</tbody>
			</table>
		</div>
		--->
	</div>
</section>
    
<cfinclude template="includes/inc_footer.cfm">