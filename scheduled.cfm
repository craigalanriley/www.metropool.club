
<!--- Scheduled Tasks --->

<cfscript>

	objSMS = CreateObject("component","cfc.sms");


	// encryptKey = Encrypt("doit", Application.metroKey); // 
	// writeDump(encryptKey);

	hiddenKey = Decrypt(URL.action, Application.metroKey); // Debug: 
	writeDump(hiddenKey);

	switch(hiddenKey) 
		{ 
	    case "phatbot":

	    	writeDump("Send!");
	    	// Do scheduled task stuff (eg fixtures / not paid)

			testMatches = objSMS.getPlayersMatches(playerName="Craig", playerID=157); // replace with all players loop

			// objSMS.sendSMS(sendMsg=testMatches);

	    	writeDump(testMatches);
	        break; 
	    default: 
	        // If key is missing or incorrect then alert sys admin	

	        writeDump("Error!");

	        objSMS.sendSMS(sendMsg="Hey, I'm a scheduled task (no phatbot key)!");
		} ;

</cfscript>



<cfif structKeyExists(URL, "action")>

<cfelse>

	action not defined
	
</cfif>


