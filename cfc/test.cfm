<cfparam name="from" 				default="Undefined"><!--- Recipient Mobile Number that sent the reply message --->
<cfparam name="message" 			default="Undefined"><!--- Reply SMS message body ---> 
<cfparam name="originalmessage" 	default="Undefined"><!--- Original SMS message body --->
<cfparam name="originalmessageid" 	default="Undefined"><!--- Original SMS message ID. Returned when originally sending the message ---> 
<cfparam name="originalsenderid" 	default="0"><!--- Original mobile number (sender ID) that the SMS was sent from ---> 
<cfparam name="customstring" 		default="0"><!--- A custom string used when sending the original message ---> 

<cfscript>
	

	objSMS = CreateObject("component","cfc.sms");

	objSMS.sendSMS();


</cfscript>






<!--- Log All Incoming Messages --->
<cfquery name="getMessageLogs" datasource="metro">
	select * from sms_log
</cfquery>

<cfdump var="#getMessageLogs#">