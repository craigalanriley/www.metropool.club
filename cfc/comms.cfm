
<cfparam name="FORM.playerList" default="">
<cfparam name="FORM.smsMessage" default="">



<cfset thisPage = "Metro SMS Gateway">

<cfinclude template="../includes/inc_header.cfm">

<section id="title" class="tournament-blue">
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <h1><cfoutput>#thisPage#</cfoutput></h1>
                <p>Player Communications</p>
            </div>
            <div class="col-sm-6">
                <ul class="breadcrumb pull-right hidden-xs">
                    <li><a href="index.cfm?Logout=true">LOGOUT</a></li>
                </ul>
            </div>
        </div>
    </div>
</section>


<section id="login">
	<div class="container">
		<div class="row">
			<div class="col-md-4 hidden-xs"></div>
			<div class="col-md-4 col-xs-12">

		   		<div class="panel panel-default">
	  				<div class="panel-heading"><strong>SMS Message</strong></div>
					<div class="panel-body">
						    
					    <div class="col-lg-1"></div>
				    	<div class="col-lg-10" class="text-center">

							<cfif Len(FORM.playerList) AND len(trim(FORM.smsMessage))>
								<cfset objSMS = CreateObject("component","sms")>
								<cfloop list="#FORM.playerList#" index="p">
									<cfscript>
										objSMS.sendSMS(sendTo=#p#, sendMsg=#FORM.smsMessage#);
									</cfscript>
								</cfloop>
								<span class="text-success">Sent</span>
							</cfif>

				    		<form action="comms.cfm" method="post">
					    		<div class="form-group">
					    			<cfset EventID = 2>
									<cfquery name="getPlayers" datasource="#Application.DSN#">
										select p.player_id, p.first_name, p.last_name, p.mobile
										from players p
										INNER JOIN player_event pe ON p.player_id = pe.player_id
										where event_id = 2
										order by p.first_name
									</cfquery>

						      		<select name="playerList" multiple="true" size="24" style="width: 200px">
						      			<cfoutput query="getPlayers">
						      				<option value="#mobile#" <cfif ListFind(FORM.playerList, mobile)>selected</cfif>>#first_name# #last_name#</option>
						      			</cfoutput>
						      		</select>
						      	</div>

							    <div class="form-group">
						      		<textarea name="smsMessage" cols="20" rows="5"><cfoutput>#FORM.smsMessage#</cfoutput></textarea>
						      	</div>

							    <div class="form-group">
						      		<button class="btn btn-primary btn-block active" id="btnReg"> Send</button>
						      	</div>
				    		</form>

						</div>

					</div>
				</div>	
				   		
			</div>
		</div>
	</div>
</section>




<cfinclude template="../includes/inc_footer.cfm">