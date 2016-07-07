<cfcomponent output="true" hint="handles all the sms functionality">

	<!--- 
	ClickSendSMS

	New Incoming Number: 0481 071 247

	--->

	<cfscript>

		thisUserName	= "metropool";
		thisKey			= "B3DD2BC3-10EF-EE21-9272-A31D9EE95C51";

		myPhone			= "0401707147"; // my mobile number
		metroPhone		= "0481071247"; // Private metro sms number
		clickSendPhone	= "0427741418"; // Shared sms number
		metroName		= "MetroPool";  // No reply sms sender name

	</cfscript>

	<cffunction name="readSMS" access="remote" output="true" returntype="any" hint="reads sms http post from click send">
		<cfargument name="from" 				type="string" 	required="false" 	default="Undefined" hint="Recipient Mobile Number that sent the reply message" />
		<cfargument name="message" 				type="string"	required="false" 	default="Undefined" hint="Reply SMS message body" />
		<cfargument name="originalmessage" 		type="string"	required="false" 	default="Undefined" hint="Original SMS message body" />
		<cfargument name="originalmessageid" 	type="string"	required="false" 	default="Undefined" hint="Original SMS message ID. Returned when originally sending the message" />
		<cfargument name="originalsenderid" 	type="string"	required="false" 	default="0" hint="Original mobile number (sender ID) that the SMS was sent from" />
		<cfargument name="customstring" 		type="string"	required="false" 	default="0" hint="A custom string used when sending the original message" />

			<cfparam name="from" 				default="Undefined">
			<cfparam name="message" 			default="Undefined">
			<cfparam name="originalmessage" 	default="Undefined">
			<cfparam name="originalmessageid" 	default="Undefined">
			<cfparam name="originalsenderid" 	default="0">
			<cfparam name="customstring" 		default="">

			<cftry>
				
				<cfscript>

					var msg = "";
					var insertDateTime = CreateODBCDateTime(now());

				</cfscript>

				<!--- Log All Incoming Messages --->
				<cfquery name="logMessage" datasource="#Application.DSN#">
					INSERT INTO sms_log
							(
							`date_inserted`, 
							`original_mobile`, 
							`from_mobile`, 
							`message`, 
							`original_message`, 
							`original_message_id`
							<cfif isNumeric(customstring)>
								,`custom_string`
							</cfif>
							)
					VALUES (
							<cfqueryparam cfsqltype="cf_sql_timestamp" value="#insertDateTime#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#originalsenderid#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#from#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#message#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#originalmessage#">,
							<cfqueryparam cfsqltype="cf_sql_bigint" value="#originalsenderid#">
							<cfif isNumeric(customstring)>
								,<cfqueryparam cfsqltype="cf_sql_int" value="#customstring#">
							</cfif>
							);
				</cfquery>

		
				<cfscript>

					// Get player details from mobile number
					var playerDetails = getPlayer(from);

					if (playerDetails.RecordCount EQ 1)
						{
						// Get message action 
						var msg = getAction(smsMessage=message, playerName=playerDetails.first_name, playerID=playerDetails.player_id);
						// Send received confirmation
						sendSMS(sendTo="#from#", sendMsg="#msg#");
						}
					else{
						// If from mobile not found send error notification
						msg = "Sorry but this mobile (#from#) isn't registered with MetroPool.Club, please inform your league operator";
						sendSMS(sendTo="#from#", sendMsg="#msg#");
						};


					// Send copy of reply to my mobile
					if (from NEQ myPhone)
						{
						sendSMS(sendTo="#myPhone#", sendMsg="#msg#");
						};

				</cfscript>

				<cfcatch type="any">
					<cfscript>
						// Send error messgae to sms
						msg = "Error! | [#cfcatch.message# | #cfcatch.type# | #cfcatch.detail# ]";
						sendSMS(sendTo="#from#", sendMsg="#msg#");
					</cfscript>
				</cfcatch>
				
			</cftry>

		<cfreturn />
	</cffunction>


	<cffunction name="sendSMS" access="public" output="true" returntype="any">
		<cfargument name="sendTo" 	type="string"	required="false"  default="0401707147" />
		<cfargument name="sendMsg" 	type="string"	required="false" default="test default msg" />
		<cfargument name="senderID" type="string"	required="false" default="0481071247" />


		<cfscript>

			var sendResult = false;
			var sendURL = "http://api.clicksend.com/http/v2/send.php?method=http&username=#thisUserName#&key=#thisKey#&to=#arguments.sendTo#&message=#arguments.sendMsg#";

			// writeDump(sendURL);
		</cfscript>

		<!--- POST --->
		<cfhttp method="POST" url="http://api.clicksend.com/http/v2/send.php" result="postResult">
			<cfhttpparam type="header" 		name="mimetype" 	value="text/javascript" />			
			<cfhttpparam type="Formfield" 	name="method" 		value="http"> 
			<cfhttpparam type="Formfield" 	name="username" 	value="#thisUserName#"> 
			<cfhttpparam type="Formfield" 	name="key" 			value="#thisKey#"> 

			<cfhttpparam type="Formfield" 	name="to" 			value="#arguments.sendTo#"> 
			<cfhttpparam type="Formfield" 	name="message" 		value="#arguments.sendMsg#"> 
			<cfhttpparam type="Formfield" 	name="senderid" 	value="#metroPhone#"><!--- 11 Char String, Number, or Blank ---> 
			<cfhttpparam type="Formfield" 	name="customstring" value=""><!--- DB MessageID? --->
			<cfhttpparam type="Formfield" 	name="schedule" 	value=""><!--- UNIX Format 1348742950 --->
			<cfhttpparam type="Formfield" 	name="return" 		value=""><!--- Return URL --->
		</cfhttp>
		
		<!--- GET 
		<cfhttp method="GET" url="#sendURL#"  result="getResult">
			<cfhttpparam type="header" name="mimetype" value="application/xml" />
		</cfhttp>
		<cfdump var="#getResult#"><br>
		--->

		<cfreturn />
	</cffunction>


	<cffunction name="getPlayer" access="private" output="false" returntype="query" hint="Get player details from senders mobile number">
		<cfargument name="fromNumber"  	type="string"	required="true" />

			<cfscript>
				var getPlayer = "";
				var ausNumber = ReplaceNoCase(arguments.fromNumber, "+61", "0");
			</cfscript>

			<cfquery name="getPlayer" datasource="#Application.DSN#">
				select player_id, first_name 
				from players 
				where mobile LIKE '%#ausNumber#%'
			</cfquery>

		<cfreturn getPlayer />
	</cffunction>	


	<cffunction name="getAction" access="public" output="false" returntype="string" hint="Attempt to decipher sms message action and then build message if found">
		<cfargument name="smsMessage" 	type="string"	required="true" />
		<cfargument name="playerName" 	type="string"	required="false" default="" />
		<cfargument name="playerID" 	type="numeric"	required="false" default="0" />

			<cfscript>

				var replyMessage = "Sorry #arguments.playerName#, the message received could not be understood - please text HELP for more info.";

				if (FindNoCase("HELP", arguments.smsMessage))
					{
					replyMessage = "Hi #arguments.playerName#, the following keywords are available:" & insertlineBreak() & insertlineBreak() & "POSTPONE PLAY MYMETRO STATS" & insertlineBreak() & insertlineBreak() & "For more information about each keyword Text HELP {keyword}";
					}
				if (FindNoCase("HELP PLAY", arguments.smsMessage))
					{
					replyMessage = "Hi #arguments.playerName#, to add a rescheduled match to next weeks waitlist simply text PLAY {MATCHID}";
					}
				if (FindNoCase("HELP POSTPONE", arguments.smsMessage))
					{
					replyMessage = "Hi #arguments.playerName#, to postpone a match simply text POSTPONE {MATCHID}";
					}
				if (FindNoCase("HELP MYMETRO", arguments.smsMessage))
					{
					replyMessage = "Hi #arguments.playerName#, to retrieve your my metro login details simply text MYMETRO";
					}
				else if(FindNoCase("STATS", arguments.smsMessage))
					{
					replyMessage = getStatsMessage(playerID=arguments.playerID, playerName=arguments.playerName);
					}
				else if(FindNoCase("POSTPONE", arguments.smsMessage))
					{
					replyMessage = getPostponeMessage(arguments.smsMessage, arguments.playerName, arguments.playerID);
					}
				else if(FindNoCase("PLAY", arguments.smsMessage))
					{
					replyMessage = getPlayMessage(arguments.smsMessage, arguments.playerName, arguments.playerID);
					}
				else if(FindNoCase("MYMETRO", arguments.smsMessage))
					{
					replyMessage = getMyMetroMessage(arguments.playerName, arguments.playerID);
					}
				else if(FindNoCase("MATCHES", arguments.smsMessage))
					{
					replyMessage = getPlayersMatches(playerName=arguments.playerName, playerID=arguments.playerID);
					};

			</cfscript>

		<cfreturn replyMessage />
	</cffunction>

	<cffunction name="getPostponeMessage" access="remote" output="true" returntype="any">
		<cfargument name="smsMessage" 	type="string"	required="true" />
		<cfargument name="playerName" 	type="string"	required="true" />
		<cfargument name="playerID" 	type="numeric"	required="true" />

		<cfscript>
			var cleanString = trim(ReplaceNoCase(arguments.smsMessage, "POSTPONE", ""));

			var postponeMessage = "Hi #arguments.playerName#, to postpone a match you must include the match id (e.g. MXXX) that can be found on the fixtures page next to the fixture you wish to postpone";

			// Extract fixture id from message
			var FixtureID = getFixtureID(cleanString);

			// Update fixture to postponed
			if (FixtureID GT 0)
				{
				postponeMessage = postponeFixture(FixtureID=FixtureID, playerName=arguments.playerName, playerID=arguments.playerID);
				};
			
		</cfscript>

		<cfreturn postponeMessage />
	</cffunction>



	<cffunction name="postponeFixture" access="public" output="true" returntype="string" hint="handles the postpone sms keyword">
		<cfargument name="FixtureID" 	type="numeric"	required="true" />
		<cfargument name="playerName" 	type="string"	required="true" />
		<cfargument name="playerID" 	type="numeric"	required="true" />

			<cfscript>
				var postponeMessage = "";
				var opponentsName 	= "";

				var isOwnFixture = validateFixture(FixtureID=arguments.FixtureID, playerID=arguments.playerID);
			</cfscript>

			<cfif isOwnFixture.RecordCount NEQ 1>
				<!--- Fixture doesn't contain texting player --->
				<cfset postponeMessage = "A valid fixture could not be found, you can only postpone your own fixtures">
			<cfelse>

				<cfif isOwnFixture.round EQ finalRoundID()>
					<cfset postponeMessage ="Hi #playerName#, final round matches must be played at the same time so can not be postponed.">
				<cfelse>

					<cfset matchTime = DateFormat(isOwnFixture.scheduled_time, "dd mmm yyyy")>
					<cfif isOwnFixture.HomeName EQ arguments.PlayerName>
						<cfset opponentsName = isOwnFixture.AwayName>
					<cfelse>
						<cfset opponentsName = isOwnFixture.HomeName>
					</cfif>

					<cfswitch expression="#isOwnFixture.status_id#">
						<cfcase value="1">
							<cfset postponeMessage ="Hi #playerName#, you can't postpone this fixture because it has already been played.">
						</cfcase>
						<cfcase value="2">
							<cfset postponeMessage ="Hi #playerName#, you can't postpone this fixture because it has already been forfeited.">
						</cfcase>
						<cfcase value="3">
							<cfset postponeMessage ="Hi #playerName#, you can't postpone this fixture because it is in progress.">
						</cfcase>
						<!--- Pending --->
						<cfcase value="4">

							<cfif isInTime(isOwnFixture.scheduled_time)>
								
								<cfset postponeMessage = setPostponeFixture(
																			FixtureID=arguments.FixtureID, 
																			playerID=arguments.playerID, 
																			playerName=arguments.playerName, 
																			opponentsName=opponentsName, 
																			matchTime=matchTime
																			)>
							<cfelse>
								<cfset postponeMessage = "Hi #playerName#, this fixture can not be postponed because it is within 3 hours of the scheduled start time. If it is not played i'm afraid it will be forfeited.">
							</cfif> 
							
						</cfcase>
						<!--- Postponed --->
						<cfcase value="6">

							<cfset postponeMessage = setPostponeWaitlist(
																		FixtureID=arguments.FixtureID, 
																		playerID=arguments.playerID, 
																		playerName=arguments.playerName, 
																		opponentsName=opponentsName, 
																		matchTime=matchTime
																		)>
							
						</cfcase> 
						<cfdefaultcase>
							<cfset postponeMessage ="Hi #playerName#, we were unable to postpone this fixture, please contact your league operator">
						</cfdefaultcase>
					</cfswitch>

				</cfif>

			</cfif>

		<cfreturn postponeMessage />
	</cffunction>

	<cffunction name="isInTime" access="public" output="true" returntype="boolean" hint="Checks to see if postpone request is within allowed notice time period">
		<cfargument name="matchTime" type="date" required="true" />

			<cfscript>
				var result = true;

				var currentDateTime 	= now();
				var scheduledDateTime 	= arguments.matchTime;
				var scheduledTime 		= TimeFormat(scheduledDateTime, "HH:mm:ss");
				var tbcTime 			= "00:00:00";

				// Ignore TBC times
				if (scheduledTime NEQ tbcTime) 
					{

					var hoursDiff = DateDiff("h", currentDateTime, scheduledDateTime); // writeDump(hoursDiff);

					if (hoursDiff LT 3)
						{
						result = false;
						};

					};

			</cfscript>

		<cfreturn result />
	</cffunction>


	<cffunction name="setPostponeFixture" access="public" output="true" returntype="string" hint="set the fixture status to postponed">
		<cfargument name="FixtureID" 		type="numeric"	required="true" />
		<cfargument name="playerID" 		type="numeric"	required="true" />
		<cfargument name="playerName" 		type="string"	required="true" />
		<cfargument name="opponentsName" 	type="string"	required="true" />
		<cfargument name="matchTime" 		type="string"	required="true" />

		<cfscript>
			var msg = "Hi #arguments.playerName#, your match(M#arguments.FixtureID#) against #arguments.opponentsName# on #arguments.matchTime# has been postponed" & getProgressMessage(arguments.playerID);
		</cfscript>

			<cfquery name="postponeStatus" datasource="#Application.DSN#">
				update fixtures
				set status_id = 6
				where fixture_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.FixtureID#">
				limit 1
			</cfquery>

		<cfreturn msg />
	</cffunction>



	<cffunction name="setPostponeWaitlist" access="public" output="true" returntype="string" hint="Remove fixture from waitlist">
		<cfargument name="FixtureID" 		type="numeric"	required="true" />
		<cfargument name="playerID" 		type="numeric"	required="true" />
		<cfargument name="playerName" 		type="string"	required="true" />
		<cfargument name="opponentsName" 	type="string"	required="true" />
		<cfargument name="matchTime" 		type="string"	required="true" />

		<cfscript>
			var msg = "Hi #arguments.playerName#, your match(M#arguments.FixtureID#) against #arguments.opponentsName# has been removed from the waitlist" & getProgressMessage(arguments.playerID);
		</cfscript>

			<cfquery name="postponeWaitlist" datasource="#Application.DSN#">
				update 	fixtures 
				set 	round_rescheduled = 0,
						date_rescheduled = NULL
				where fixture_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.FixtureID#">
				limit 1
			</cfquery>

		<cfreturn msg />
	</cffunction>



	<cffunction name="getMyMetroMessage" access="private" output="true" returntype="string">
		<cfargument name="playerName" 	type="string"	required="true" />
		<cfargument name="playerID" 	type="numeric"	required="true" />

			<cfscript>
				var myMetroMessage = "Hi #arguments.playerName#, your login details could not be found." & getProgressMessage(arguments.playerID);
			</cfscript>


			<cfquery name="getMyMetroLogin" datasource="#Application.DSN#">
				select email, password
				from players p
				where p.player_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.playerID#">
			</cfquery>
			<cfif getMyMetroLogin.RecordCount EQ 1>

				<cfset myMetroMessage = "Hi #arguments.playerName#, your login details are:" & insertlineBreak() & insertlineBreak() & "EMAIL: #getMyMetroLogin.email#" & insertlineBreak() & "PASSWORD: #getMyMetroLogin.password#" & getProgressMessage(arguments.playerID)>
				
			</cfif>

		<cfreturn myMetroMessage />
	</cffunction>



	<cffunction name="insertlineBreak" access="private" output="true" returntype="string">
		<cfscript>
			var br = "#chr(13)##chr(10)#";
		</cfscript>
		<cfreturn br />
	</cffunction>



	<cffunction name="getProgressMessage" access="private" output="true" returntype="string">
		<cfargument name="playerID" 	type="numeric"	required="true" />

			<cfscript>
				var postponedCount 	= 0;
				var progressMessage = "";
			</cfscript>

			<!--- Make sure players can only update thier own pending fixtures --->
			<cfquery name="getPostponedCount" datasource="#Application.DSN#">
				select count(fixture_id) AS postponedCount
				from fixtures f
				where f.event_id = 2
				and f.status_id = <cfqueryparam cfsqltype="cf_sql_integer" value="6">
				and (
					f.home_player_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.playerID#"> 
					OR 
					f.away_player_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.playerID#"> 
					)
			</cfquery>
			<cfset progressMessage = insertlineBreak() & insertlineBreak() & "NOTE: You have #getPostponedCount.postponedCount# postponed matches that must be played before the final round or they will be forfeited.">

		<cfreturn progressMessage />
	</cffunction>



	<cffunction name="getPlayMessage" access="public" output="true" returntype="any">
		<cfargument name="smsMessage" 	type="string"	required="true" />
		<cfargument name="playerName" 	type="string"	required="false" default="" />
		<cfargument name="playerID" 	type="numeric"	required="true" />

		<cfscript>
			var cleanString = trim(ReplaceNoCase(arguments.smsMessage, "PLAY", ""));
			var playMessage = "Hi #arguments.playerName#, to play a match you must include the match id (e.g. MXXX) that can be found on the fixtures page next to the fixture you wish to play";
			var FixtureID 	= getFixtureID(cleanString); // Extract fixture id from message
			var playRound   = playRound(arguments.smsMessage);

			if (FixtureID GT 0)
				{
				var isOwnFixture = validateFixture(FixtureID=FixtureID, playerID=arguments.playerID);

				if (isOwnFixture.RecordCount NEQ 1)
					{
					playMessage = "Hi #playerName#, A valid fixture could not be found, you can only play your own fixtures";
					}
				else{
					if (isOwnFixture.round EQ finalRoundID())
						{
						playMessage = "Hi #playerName#, final round matches must be played at the same time so they can not be changed.";
						}
					else{
						if (isOwnFixture.round EQ playRound)
							{
							// If round to play is same as the original fixture round just update status (don't add to waitlist)
							playMessage = playPostponedFixture(FixtureID=FixtureID, playerName=arguments.playerName, playerID=arguments.playerID);
							}
						else{
							// Else add fixture to waitlist
							playMessage = waitListFixture(FixtureID=FixtureID, playerName=arguments.playerName, playerID=arguments.playerID, RoundID=playRound);
							};

						};
					};
				};
		</cfscript>

		<cfreturn playMessage />
	</cffunction>

	<cffunction name="playPostponedFixture" access="public" output="true" returntype="string" hint="used by PLAY to undo a postponed fixture and remove from waitlist">
		<cfargument name="FixtureID" 	type="numeric"	required="true" />
		<cfargument name="playerName" 	type="string"	required="true" />
		<cfargument name="playerID" 	type="numeric"	required="true" />

			<cfquery name="setFixtureStatusToPending" datasource="#Application.DSN#">
				update fixtures
				set status_id = 4,
					round_rescheduled = 0,
					date_rescheduled = NULL
				where fixture_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.FixtureID#">
				limit 1
			</cfquery>

			<cfscript>
				var playMessage = "Hi #playerName#, your previously postponed match has been added to the play list." & getProgressMessage(arguments.playerID);
			</cfscript>

		<cfreturn playMessage />
	</cffunction>


	<cffunction name="waitListFixture" access="public" output="true" returntype="string">
		<cfargument name="FixtureID" 	type="numeric"	required="true" />
		<cfargument name="playerName" 	type="string"	required="true" />
		<cfargument name="playerID" 	type="numeric"	required="true" />
		<cfargument name="RoundID" 		type="numeric"	required="true" />

			<cfscript>
				var playMessage = "Hi #playerName#, your match has been added to the week #RoundID# waitlist." & getProgressMessage(arguments.playerID);
			</cfscript>

			<cfquery name="addFixtureToWaitList" datasource="#Application.DSN#">
				update fixtures
				set round_rescheduled = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.RoundID#">,
					date_rescheduled = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">
				where fixture_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.FixtureID#">
				limit 1
			</cfquery>

		<cfreturn playMessage />
	</cffunction>

	<cffunction name="getFixtureID" access="public" output="true" returntype="numeric">
		<cfargument name="smsMessage" 	type="string"	required="true" />

			<cfscript>
				var FixtureID = 0;
			</cfscript>
			<!--- Split message into words using spaces and look for match id --->
			<cfloop list="#smsMessage#" delimiters=" " index="x">
				<cfset firstChar = Left(x, 1)> 
				<cfif CompareNoCase(firstChar, "m") EQ 0>
					<cfset FixtureID = ReplaceNoCase(x, "M", "")>
					<cfbreak />
				</cfif>
			</cfloop>
			<cfdump var="[getFixtureID=#FixtureID#]">

		<cfreturn FixtureID />
	</cffunction>

	<cffunction name="playRound" access="public" output="true" returntype="numeric" hint="Checks to see if PLAY message contains a specific round/week">
		<cfargument name="smsMessage" 	type="string"	required="true" />
			<cfscript>
				var playRound  = 0;
				var msgArgLen  = listLen(arguments.smsMessage, " ");

				// Check to see if PLAY message contains a 3rd value and
				if (msgArgLen GTE 3)
					{
					var tempRound = ListGetAt(arguments.smsMessage, 3, " ");

					if (isNumeric(tempRound))
						{
						playRound = tempRound;
						};
					}
				else{
					playRound = nextRoundID();
					};

			</cfscript>
			<cfdump var="[playRound=#playRound#]">

		<cfreturn playRound />
	</cffunction>

	<cffunction name="nextRoundID" access="public" output="true" returntype="numeric" hint="Gets the upcoming round id">
		<cfscript>
			var RoundID = 0;
		</cfscript>

			<cfquery name="getNextRoundID" datasource="#Application.DSN#">
				select round_name AS NextRound
				from rounds 
				where event_id = 2 
				and round_date > now()
				order by round_date 
				asc limit 1
			</cfquery>
			<cfif getNextRoundID.RecordCount>
				<cfset RoundID = getNextRoundID.NextRound>
			</cfif>
			<cfdump var="[nextRoundID=#RoundID#]">

		<cfreturn RoundID />
	</cffunction>

	<cffunction name="finalRoundID" access="public" output="true" returntype="numeric" hint="Gets the final round id">
		<cfscript>
			var RoundID = 0;
		</cfscript>

			<cfquery name="getFinalRoundID" datasource="#Application.DSN#">
				select round_name AS FinalRound
				from rounds 
				where event_id = 2 
				order by round_date 
				desc limit 1
			</cfquery>
			<cfif getFinalRoundID.RecordCount>
				<cfset RoundID = getFinalRoundID.FinalRound>
			</cfif>
			<cfdump var="[finalRoundID=#RoundID#]">

		<cfreturn RoundID />
	</cffunction>


	<cffunction name="validateFixture" access="public" output="true" returntype="query" hint="Make sure players can only update thier own pending fixtures">
		<cfargument name="FixtureID" 	type="numeric"	required="true" />
		<cfargument name="playerID" 	type="numeric"	required="true" />

			<cfquery name="checkOwnFixture" datasource="#Application.DSN#">
				select home_player_id, away_player_id, p1.first_name AS HomeName, p2.first_name AS AwayName, scheduled_time, status_id, round
				from fixtures f
					inner join  players p1 ON f.home_player_id = p1.player_id
					inner join  players p2 ON f.away_player_id = p2.player_id
				where fixture_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.FixtureID#">
				and (
					home_player_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.playerID#"> 
					OR 
					away_player_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.playerID#"> 
					)
			</cfquery>
			<cfdump var="[validateFixture=#checkOwnFixture.RecordCount#]">

		<cfreturn checkOwnFixture />
	</cffunction>



	<cffunction name="getStatsMessage" access="public" output="true" returntype="string" hint="Returns players metro season stats">
		<cfargument name="playerID" 	type="numeric"	required="true" />
		<cfargument name="playerName" 	type="string"	required="true" />

		<cfscript>

			var objStats 	= CreateObject("component","cfc.stats");
			var EventID 	= 2;

			var mastGrade 	= 1;
			var advGrade 	= 2;
			var intGrade 	= 3;
			var openGrade 	= 4;

			try{
				// throw("oops");
				mastStats 	= objStats.getStats(PlayerID=arguments.playerID, EventID=EventID, GradeID=mastGrade);
				advStats 	= objStats.getStats(PlayerID=arguments.playerID, EventID=EventID, GradeID=advGrade);
				intStats 	= objStats.getStats(PlayerID=arguments.playerID, EventID=EventID, GradeID=intGrade);
				openStats 	= objStats.getStats(PlayerID=arguments.playerID, EventID=EventID, GradeID=openGrade);


				allStats 	= objStats.getStats(PlayerID=arguments.playerID, EventID=EventID);

				var statsMessage = "Hi #arguments.playerName#, have a statastic day!";

				statsMessage = statsMessage & insertLineBreak() & insertLineBreak();

				statsMessage = statsMessage & "AVERAGE WIN/LOSS MARGIN:" & insertLineBreak() & insertLineBreak();

				statsMessage = statsMessage & "Master: " & mastStats & insertLineBreak();

				statsMessage = statsMessage & "Advanced: " & advStats & insertLineBreak();

				statsMessage = statsMessage & "Intermediate: " & intStats & insertLineBreak();

				statsMessage = statsMessage & "Open: " & openStats & insertLineBreak();

				statsMessage = statsMessage & "------------------------" & insertLineBreak();

				statsMessage = statsMessage & "Overall: " & allStats & insertLineBreak();
				}
			catch(any e)
				{
				statsMessage = e.message;
				};

		</cfscript>

		<cfreturn statsMessage />
	</cffunction>

	<cffunction name="formatStats" access="private" output="true" returntype="string" hint="format stats string and polarity and N/A if no data">
		<cfargument name="stat" type="numeric"	required="true" />
			<cfscript>
				var result = arguments.stat;

				if (result GT 0)
					{
					result = "+" & result;
					};

			</cfscript>
		<cfreturn result />
	</cffunction>


	<cffunction name="getPlayersMatches" access="public" output="true" returntype="string" hint="Returns all the matches the player has in the upcoming metro">
		<cfargument name="playerID" 	type="numeric"	required="true" />
		<cfargument name="playerName" 	type="string"	required="true" />

			<cfscript>

				var matchMessage	= "METRO " & nextRoundID() & " - FIXTURES" & insertLineBreak() & insertLineBreak();
				var EventID 		= 2;

				try{
					// throw("oops");

					objFixtures = CreateObject("component","cfc.fixtures");
					
					getFixtures 	= objFixtures.getFixtures(eventID=EventID, statusID='1,2,3,4,6', roundID=nextRoundID(), playerID=arguments.PlayerID, statusID=4 ); // Get Fixtures
					getRescheduled 	= objFixtures.getFixtures(eventID=EventID, statusID='1,2,3,4,6', roundID=nextRoundID(), playerID=arguments.PlayerID, Rescheduled = true); 

					writeDump(getFixtures);
					writeDump(getRescheduled);
					}
				catch(any e)
					{
					msg = "e.message";
					};

			</cfscript>

			<cfif getFixtures.RecordCount>
				<cfset matchMessage = matchMessage & "Scheduled matches:" & insertLineBreak()>
				<cfoutput query="getFixtures">
					<cfset matchMessage = matchMessage & formatMatch(scheduled_time, away_player_short, awaystart7, home_player_short, homestart7)>
				</cfoutput>
			<cfelse>
				<cfset matchMessage = matchMessage & insertLineBreak() & "You have 0 scheduled matches">
			</cfif>
			<cfset matchMessage = matchMessage & insertLineBreak()>

			<cfif getRescheduled.RecordCount>
				<cfset matchMessage = matchMessage & insertLineBreak()& "Waitlist matches:" & insertLineBreak() >
				<cfoutput query="getRescheduled">
					<cfset matchMessage = matchMessage & formatMatch(scheduled_time, away_player_short, awaystart7, home_player_short, homestart7)>
				</cfoutput>
			<cfelse>
				<cfset matchMessage = matchMessage & insertLineBreak() & "You have 0 waitlist matches">
			</cfif>
			<cfset matchMessage = matchMessage & insertLineBreak()>

			<cfset matchMessage = matchMessage & getProgressMessage(arguments.playerID)>

		<cfreturn matchMessage />
	</cffunction>



	<cffunction name="formatMatch" access="private" output="true" returntype="string" hint="format match string for sms">
		<cfargument name="scheduled_time" 		type="date"		required="true" />
		<cfargument name="away_player_short" 	type="string"	required="true" />
		<cfargument name="awaystart7" 			type="string"	required="true" />
		<cfargument name="home_player_short" 	type="string"	required="true" />
		<cfargument name="homestart7" 			type="string"	required="true" />

			<cfscript>
				var matchString = "";
				var startTime 	= TimeFormat(arguments.scheduled_time, "HH:mm");

				if (startTime EQ "00:00")
					{
					startTime = "TBC";
					};

				matchString =  insertLineBreak() & startTime & "  " & arguments.away_player_short & " " & arguments.awaystart7 & " - " & arguments.homestart7 & " " & arguments.home_player_short;

			</cfscript>
		<cfreturn matchString />
	</cffunction>

	
</cfcomponent>