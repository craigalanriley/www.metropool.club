
<!--- Scheduled Tasks --->

<cfdump var="#URL#">

<cfif structKeyExists(URL, "action")>

	

	<cfscript>

		// encryptKey = Encrypt("doit", Application.metroKey); // 
		// writeDump(encryptKey);

		hiddenKey = Decrypt(URL.action, Application.metroKey); // Debug: 
		writeDump(hiddenKey);

		switch(hiddenKey) 
			{ 
		    case "phatbot":
		    	// Do scheduled task stuff (eg fixtures / not paid)

		    	writeDump("Send!");
		        break; 
		    default: 
		        // If key is missing or incorrect then alert sys admin	

		        writeDump("Error!");
			} ;

	</cfscript>
<cfelse>

	action not defined
	
</cfif>


