<cfparam name="from" 				default="Undefined"><!--- Recipient Mobile Number that sent the reply message --->
<cfparam name="message" 			default="Undefined"><!--- Reply SMS message body ---> 
<cfparam name="originalmessage" 	default="Undefined"><!--- Original SMS message body --->
<cfparam name="originalmessageid" 	default="Undefined"><!--- Original SMS message ID. Returned when originally sending the message ---> 
<cfparam name="originalsenderid" 	default="0"><!--- Original mobile number (sender ID) that the SMS was sent from ---> 
<cfparam name="customstring" 		default="0"><!--- A custom string used when sending the original message ---> 

<cfscript>
	

	objSMS = CreateObject("component","cfc.sms");

	// objSMS.sendSMS();

	testString = "play M1234 please craig mate";
	writeDump(testString);

	cleanString = trim(ReplaceNoCase(testString, "PLAY", ""));
	// writeDump(cleanString);


	mLocation = Find("M", testString);
	// writeDump(mLocation);

	matchid = Left(cleanString, mLocation);

	// writeDump(matchid);


</cfscript>

<br/>
<cfset MatchID = 0>
<cfloop list="#cleanString#" delimiters=" " index="x">
	<cfoutput>#x#</cfoutput><br/>
	<cfset firstChar = Left(x, 1)> 
	<cfoutput>#firstChar#</cfoutput><br/>
	<cfif CompareNoCase(firstChar, "m") EQ 0>
		<cfoutput>MatchID=#x#</cfoutput><br/>
		<cfbreak />
	</cfif>
</cfloop>



<!--- Log All Incoming Messages --->
<cfquery name="getMessageLogs" datasource="metro">
	select * from sms_log
</cfquery>

<cfdump var="#getMessageLogs#">