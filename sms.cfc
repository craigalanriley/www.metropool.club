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

	61481071247

	--->

	<cfscript>

		thisUserName	= "metropool";
		thisKey			= "B3DD2BC3-10EF-EE21-9272-A31D9EE95C51";

		myPhone			= "+61401707147";
		metroPhone		= "+61481071247";

	</cfscript>

	<cffunction name="readSMS" access="remote" output="true" returntype="any" hint="" >
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

				<!--- Log All Incoming Messages --->
				<cfquery name="logMessage" datasource="metro">
					INSERT INTO sms_log(`date_inserted`, `original_mobile`, `from_mobile`, `message`, `original_message`, `original_message_id`, `custom_string`)
					VALUES (now(),'#originalsenderid#','#originalsenderid#','#message#','#originalmessage#',#originalsenderid#,#customstring#);
				</cfquery>

				<cfcatch type="any">

					<!--- Email Message --->
					<cfmail from="readSend" to="craig@thelifeofriley.org" subject="SMS Received">
						<cfdump var="#arguments#">
						<cfdump var="#URL#">
						<cfdump var="#FORM#">
						<cfdump var="#CGI#">
					</cfmail>

				</cfcatch>
				
			</cftry>
		
			<cfscript>

				// Send received confirmation
				sendSMS(sendMsg="Received! [#from# | #message# | #originalmessage# | #originalmessageid# | #originalsenderid# | #customstring# ]");

				// Log all incoming

				// Key word case statement (inc help)

				// Call Function for each key word to build messgae

				// Then call sendSMS (monitor for abuse to keep costs down)

				// Log all sent messages

				// If balance is low send sms to me to topup
			</cfscript>
			

		<cfreturn />
	</cffunction>

	<cffunction name="sendSMS" access="remote" output="true" returntype="any">
		<cfargument name="sendTo" 	type="string"	required="false" 	default="#myPhone#" />
		<cfargument name="sendMsg" 	type="string"	required="false" 	default="TestMessage!" />
		<cfargument name="senderID" type="string"	required="false" 	default="" />


		<cfscript>

			var sendResult = false;
			var sendURL = "http://api.clicksend.com/http/v2/send.php?method=http&username=#thisUserName#&key=#thisKey#&to=#myPhone#&message=#arguments.sendMsg#";

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
			<cfhttpparam type="Formfield" 	name="senderid" 	value="#arguments.senderID#"><!--- 11 Char String, Number, or Blank ---> 
			<cfhttpparam type="Formfield" 	name="customstring" value=""><!--- DB MessageID? --->
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


	<cffunction name="smsReceive" access="remote" output="true" returntype="any">

		<cfscript>

			// https://api.clicksend.com/http/v2/balance.php?username=#thisUserName#&key=#thisKey#

		</cfscript>

		<cfreturn />
	</cffunction>
	
</cfcomponent>