<cfcomponent output="true" hint="handles all the sms functionality">

	<!--- 
	ClickSendSMS
	from = Recipient Mobile Number that sent the reply message. 
	message = Reply SMS message body. 
	originalmessage = Original SMS message body. 
	originalmessageid = Original SMS message ID. Returned when originally sending the message. 
	originalsenderid = Original mobile number (sender ID) that the SMS was sent from. 
	customstring = A custom string used when sending the original message. 

		<cfset objSecurity = createObject("java", "java.security.Security") />
		<cfset storeProvider = objSecurity.getProvider("JsafeJCE") />
		<cfset objSecurity.removeProvider("JsafeJCE") />
		{post/get msg}
		<cfset objSecurity.insertProviderAt(storeProvider, 1) />
	--->

	<cfscript>

		thisUserName	= "metropool";
		thisKey			= "B3DD2BC3-10EF-EE21-9272-A31D9EE95C51";
		thisTestPhone	= "+61401707147";	

		slackOffChannel		= "slacktest";
		slackBastardChannel	= "slacktest";

		slackURL 		= "https://amaysim.slack.com/services/hooks/slackbot?";
		slackToken 		= "oYXrRVXV9lxLpGMBv3zFa0Lk";
		// slackChannel	= "%23general";
		fullURL			= slackURL & "token=" & slackToken; 

	</cfscript>

	<cffunction name="readSMS" access="remote" output="true" returntype="any">
		<cfargument name="from" 				type="string" 	required="false" 	default="" />
		<cfargument name="message" 				type="string"	required="false" 	default="" />
		<cfargument name="originalmessage" 		type="string"	required="false" 	default="" />
		<cfargument name="originalmessageid" 	type="string"	required="false" 	default="" />
		<cfargument name="originalsenderid" 	type="string"	required="false" 	default="" />
		<cfargument name="customstring" 		type="string"	required="false" 	default="" />

			<cfparam name="from" 				default=""><!--- Recipient Mobile Number that sent the reply message --->
			<cfparam name="message" 			default=""><!--- Reply SMS message body ---> 
			<cfparam name="originalmessage" 	default=""><!--- Original SMS message body --->
			<cfparam name="originalmessageid" 	default=""><!--- Original SMS message ID. Returned when originally sending the message ---> 
			<cfparam name="originalsenderid" 	default=""><!--- Original mobile number (sender ID) that the SMS was sent from ---> 
			<cfparam name="customstring" 		default=""><!--- A custom string used when sending the original message ---> 

			<cftry>
		
				<cfscript>

					// Check if message is slackOff
					slackOffType = isSlackOff(arguments.message); // writeDump(slackOffType);

					if ( len(slackOffType) )
						{
						buildSlackOff(slackMessage=arguments.message, slackPhone=from, slackOffType=slackOffType);
						writeDump("isSlackOff!");
						}
					else{
						if ( isSlackBastard(arguments.message) )
							{
							buildSlackBastard(arguments.from, arguments.message);
							writeDump("isSlackBastard!");
							};
						};

					// Debug
					writeDump("SMS Read!");
				</cfscript>

				<cfcatch type="any">
					<cfdump var="#cfcatch#">
				</cfcatch>
				
			</cftry>

		<cfreturn />
	</cffunction>


	<cffunction name="isSlackOff" access="remote" output="true" returntype="string">
		<cfargument name="slackMessage" type="string"	required="true" />

			<cfscript>

				var result = "";
				var slackBastardList = "late,wfh,sick,hols,left,park";

				for (y=1; y LTE ListLen(slackBastardList); y=y+1) 
					{
					var thisReason = ListGetAt(slackBastardList,y);
					if ( FindNoCase( thisReason, arguments.slackMessage) )
						{
						// Post Slack Message
						result = thisReason;
						};
					};

			</cfscript>

		<cfreturn result />
	</cffunction>

	<cffunction name="isSlackBastard" access="remote" output="true" returntype="any">
		<cfargument name="slackMessage" type="string"	required="true" />

			<cfscript>

				var result = false;
				var slackBastardList = "bastard,fuck,wanker,shit,suck,cunt,grub,goose";

				for (xxx=1; xxx LTE ListLen(slackBastardList); xxx=xxx+1) 
					{
					if ( FindNoCase( ListGetAt(slackBastardList,xxx), arguments.slackMessage) )
						{
						result = true;
						};
					};

			</cfscript>

		<cfreturn result />
	</cffunction>

	<cffunction name="buildSlackBastard" access="remote" output="true" returntype="any">
		<cfargument name="slackPhone" 	type="string"	required="true" />
		<cfargument name="slackMessage" type="string"	required="true" />

			<cfscript>

				if (len(arguments.slackPhone))
					{
					slackMessage = slackMessage & " <https://ecui.amaysim.net/ecgateway/search.cfm?searchtype=quickSearch&searchstring=#arguments.slackPhone#|#arguments.slackPhone#>";
					};

				postSlackHook(slackMessage, "", ":rage:", "slack-b##stard");

			</cfscript>

		<cfreturn />
	</cffunction>

	<cffunction name="buildSlackOff" access="remote" output="true" returntype="string">
		<cfargument name="slackOffType" type="string"	required="true" />
		<cfargument name="slackMessage" type="string"	required="true" />
		<cfargument name="slackPhone" type="string"	required="true" />

			<cfscript>

				// var slackBastardList = "late,home,sick,leave,left";

				switch(trim(lcase(arguments.slackOffType))) 
					{
				    case "late":
				         icon_url 	= "https://slack.com/img/icons/app-57.png";
				         icon_emoji = ":sweat:";
				         slackMessage = "Craig is running a little late (again!) this morning...";
				         break;
				    case "wfh":
				         icon_url 	= "https://slack.com/img/icons/app-57.png";
				         icon_emoji = ":stuck_out_tongue_winking_eye:";
				         slackMessage = "Craig is 'working' from home today, he's available on the usual channels";
				         break;
				    case "sick":
				         icon_url 	= "https://slack.com/img/icons/app-57.png";
				         icon_emoji = ":mask:";
				         slackMessage = "Craig has man flu and almost didn't survive the night, please pray for him";
				         break;
				    case "hols":
				         icon_url 	= "https://slack.com/img/icons/app-57.png";
				         icon_emoji = ":sunglasses:";
				         slackMessage = "Craig is on holiday today, no hating";
				         break;
				    case "left":
				         icon_url 	= "https://slack.com/img/icons/app-57.png";
				         icon_emoji = ":ghost:";
				         slackMessage = "Craig's last day in the office is today (woohoo)!";
				         break;
				    case "park":
				         icon_url 	= "https://slack.com/img/icons/app-57.png";
				         icon_emoji = ":leaves:";
				         slackMessage = "Matt spent the night in the park again and will be in a little late today";
				         break;
				    default: 
				         icon_url 	= "https://slack.com/img/icons/app-57.png";
				         icon_emoji = ":neutral_face:";
				         slackMessage = "Craig is AWOL";
					};

				slackMessage = slackMessage & " <https://tel:+1800229933|#arguments.slackPhone#>";

				postSlackHook(slackMessage, icon_url, icon_emoji, "slack-off");

			</cfscript>

		<cfreturn />
	</cffunction>

	<cffunction name="postSlackHook" access="remote" output="true" returntype="any" hint="A more fancy way of posting to slack">
		<cfargument name="slackMessage" 	type="string"	required="true"  />
		<cfargument name="slackIconURL" 	type="string"	required="true"  />
		<cfargument name="slackIconEmoji" 	type="string"	required="true"  />
		<cfargument name="slackBotName" 	type="string"	required="true"  />

			<!--- Send to SLACK API --->

			<cfhttp
			    method="post"
			    charset="utf-8"
			    url="https://hooks.slack.com/services/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"
			    throwOnError="false"
			    result="slackResponse">
			    <cfhttpparam type="header" 	name="Content-Type" value="application/json" />
			    <cfhttpparam type="body" 	name="fields" 	value='{
			    													"username": "#slackBotName#",
			    													"text": "#slackMessage# \n",
			    													"icon_emoji": "#slackIconEmoji#"
			    													}'>
			    <!--- 
			    "icon_url": "#slackIconURL#",
			    <cfhttpparam type="body" 	value="#serializeJSON(payload)#"> 
				"text": "<https://alert-system.com/alerts/1234|Click here> for details....!"
				--->
			</cfhttp>
			<cfdump var="#slackResponse#">

		<cfreturn />
	</cffunction>

	<cffunction name="postSlack" access="remote" output="true" returntype="any" hint="basic slack post API">
		<cfargument name="slackChannel" type="string"	required="true" 	default="" />
		<cfargument name="slackMessage" type="string"	required="false" 	default="" />

			<cfscript>

				testGiphy		= "</giphy vegas>";
				testEmojo		= ":mega:";
				testURL			= "http://www.metropool.club";
				testMessage		= "test message";

				// beerMessage1	= ":mega: ATTENTION HUMANS - this is your slack-tain speaking! :mega:";
				// beerMessage2	= ":mega: It's almost :beer: o'clock!!! :mega:";
				// https://api.clicksend.com/http/v2/balance.php?username=#thisUserName#&key=#thisKey#

			</cfscript>

			<!--- Send to SLACK API --->
			<cfhttp
			    method="post"
			    charset="utf-8"
			    url="https://amaysim.slack.com/services/hooks/slackbot?token=#slackToken#&channel=#slackChannel#"
			    throwOnError="false"
			    result="slackResponse">
			    <cfhttpparam type="header" name="Content-Type" value="application/json" />
			    <cfhttpparam type="body" value="#slackMessage#">
			</cfhttp>


		<cfreturn />
	</cffunction>

	<cffunction name="sendSMS" access="remote" output="true" returntype="any">
		<cfargument name="sendTo" 	type="string"	required="false" 	default="#thisTestPhone#" />
		<cfargument name="sendMsg" 	type="string"	required="false" 	default="TestMessage!" />
		<cfargument name="senderID" type="string"	required="false" 	default="" />

		<cfscript>

			var sendResult = false;
			var sendURL = "http://api.clicksend.com/http/v2/send.php?method=http&username=#thisUserName#&key=#thisKey#&to=#thisTestPhone#&message=#arguments.sendMsg#";

			// writeDump(sendURL);
		</cfscript>

		<!--- POST --->
		<cfhttp method="POST" url="http://api.clicksend.com/http/v2/send.php" result="postResult">
			<cfhttpparam type="header" 		name="mimetype" 	value="text/javascript" />			
			<cfhttpparam type="Formfield" 	name="method" 		value="http"> 
			<cfhttpparam type="Formfield" 	name="username" 	value="#thisUserName#"> 
			<cfhttpparam type="Formfield" 	name="key" 			value="#thisKey#"> 

			<cfhttpparam type="Formfield" 	name="to" 			value="0411731007"> 
			<cfhttpparam type="Formfield" 	name="message" 		value="#arguments.sendMsg#"> 
			<cfhttpparam type="Formfield" 	name="senderid" 	value="#arguments.senderID#"> 
			<cfhttpparam type="Formfield" 	name="customstring" value="customString(use-db-id)"> 
			<cfhttpparam type="Formfield" 	name="schedule" 	value=""><!--- UNIX Format 1348742950 --->
			<cfhttpparam type="Formfield" 	name="return" 		value=""><!--- Return URL --->
		</cfhttp>
		<cfdump var="#postResult#"><br>
		
		<!--- GET 
		<cfhttp method="GET" url="#sendURL#"  result="getResult">
			<cfhttpparam type="header" name="mimetype" value="application/xml" />
		</cfhttp>
		<cfdump var="#getResult#"><br>
		--->

		<cfreturn />
	</cffunction>
	
</cfcomponent>