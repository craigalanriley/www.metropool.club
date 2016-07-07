


<cfscript>

	EventID = 2;

	objPlayers = CreateObject("component","cfc.players"); 

	allPlayers = objPlayers.getEventPlayers(EventID=EventID); // writeDump(allPlayers);
	
	objSMS = CreateObject("component","cfc.sms"); 


	test = objSMS.getStatsMessage(playerID=0, playerName="System");


</cfscript>

<cfset thisPage = "Player Promotions">
<cfinclude template="includes/inc_header.cfm">

<section id="title" class="tournament-blue">
	<div class="container">
	    <div class="row">
	        <div class="col-sm-6">
	            <h1><cfoutput>#thisPage#</cfoutput></h1>
	            <p></p>
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

		<cfset i = 1>
		<table cellspacing="2" cellpadding="10">
		<tr>
			<th>&nbsp;</th>
			<th>Player</th>
			<th>Open</th>
			<th>Intermediate</th>
			<th>Advanced</th>
			<th>Master</th>
		</tr>
		<cfoutput query="allPlayers"> 

			<cfscript>

				mastGrade 	= 1;
				advGrade 	= 2;
				intGrade 	= 3;
				openGrade 	= 4;

				mastStats 	= objStats.getStats(PlayerID=player_id, EventID=EventID, GradeID=mastGrade);
				advStats 	= objStats.getStats(PlayerID=player_id, EventID=EventID, GradeID=advGrade);
				intStats 	= objStats.getStats(PlayerID=player_id, EventID=EventID, GradeID=intGrade);
				openStats 	= objStats.getStats(PlayerID=player_id, EventID=EventID, GradeID=openGrade);

			</cfscript>

			<cfswitch expression="#handicap_id#">
				<cfcase value="1"><cfset gradeClass = "text-danger"></cfcase>
				<cfcase value="2"><cfset gradeClass = "text-warning"></cfcase>
				<cfcase value="3"><cfset gradeClass = "text-success"></cfcase>
				<cfcase value="4"><cfset gradeClass = "text-primary"></cfcase>
			</cfswitch>
			<cfset promoClass = "Gold">
			<cfset demoClass = "Silver">

			<tr>
				<td>#i#.</td>
				<td><span class="#gradeClass#">#full_name#</span></td>
				<td align="right" <cfif openStats GTE 2>style="color: #promoClass#"<cfelseif openStats LTE -2>style="color: #demoClass#"</cfif>>#openStats#</td>
				<td align="right" <cfif intStats GTE 2>style="color: #promoClass#"<cfelseif intStats LTE -2>style="color: #demoClass#"</cfif>>#intStats#</td>
				<td align="right" <cfif advStats GTE 2>style="color: #promoClass#"<cfelseif advStats LTE -2>style="color: #demoClass#"</cfif>>#advStats#</td>
				<td align="right" <cfif mastStats GTE 2>style="color: #promoClass#"<cfelseif mastStats LTE -2>style="color: #demoClass#"</cfif>>#mastStats#</td>
			</tr>

			 
			<cfset i = i + 1>

		</cfoutput>
		</table>


	</div>
</section>


<cfinclude template="includes/inc_footer.cfm">