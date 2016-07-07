
<cfparam name="ErrorMessage" 	default="">
<cfparam name="SuccessMessage" 	default="">
<cfparam name="FORM.email" 		default="">
<cfparam name="FORM.mobile" 	default="">
<cfparam name="FORM.playerID" 	default="">



<cfif isDefined("FORM.Action")>

	<cfif len(FORM.email) AND isNumeric(FORM.mobile)>
	
		<!--- Check if already registered? --->
		<cfquery name="hasRegistered" datasource="metro">
			select *
			from player_event
			where player_id = #FORM.playerID#
		</cfquery>
		<cfif hasRegistered.RecordCount>
			<cfset ErrorMessage = "You have already registered for this event">
		<cfelse>
			<!--- Add to event player table --->
			<cfquery name="registerPlayer" datasource="metro">
				insert into player_event(event_id, player_id, paid)
				values (1, #FORM.playerID#, 0)
			</cfquery><!--- Add to event player table --->
			<cfquery name="updatePlayer" datasource="metro">
				update players 
				set mobile = #FORM.mobile#, 
				    email = '#FORM.email#'
				where player_id = #FORM.playerID#
			</cfquery>
		
			<!--- Email user password --->
			<cfmail from="info@metropool.club" to="#FORM.email#" bcc="craig@thelifeofriley.org" subject="MetroPool.Club 8 Ball Registration" type="html">
			
				<p>Thank you, your registration has been received.</p>
				
				<p></p>
			
			</cfmail>
			<cfset SuccessMessage = "Thankyou, your registration has been received.">
		</cfif>
	<cfelse>
		<cfset ErrorMessage = "You must complete all the fields">
	</cfif>
</cfif>		

<cfset thisPage = "Register">
<cfinclude template="includes/inc_header.cfm">

    <section id="title" class="tournament-blue">
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    <h1><cfoutput>#thisPage#</cfoutput></h1>
                    <p>Please complete the form below to register for MetroPool.Club!</p>
                </div>
                <div class="col-sm-6">
                    <ul class="breadcrumb pull-right hidden-xs">
                        <li><a href="index.cfm">Home</a></li>
                        <li class="active"><cfoutput>#thisPage#</cfoutput></li>
                    </ul>
                </div>
            </div>
        </div>
    </section><!--/#title-->
	
	<section>
		<div class="container">
			<div class="row">
				<div class="col-md-2 hidden-xs"></div>
				<div class="col-md-8 col-xs-12">
					<cfif len(ErrorMessage)>
			   			<div class="alert alert-danger text-center" style=""><cfoutput>#ErrorMessage#</cfoutput></div>
			   		</cfif>
			   		<cfif len(SuccessMessage)>
			   			<div class="alert alert-success text-center"><cfoutput>#SuccessMessage#</cfoutput></div>
			   		</cfif>
			   		<div class="panel panel-default">
		  				<div class="panel-heading"><strong>Registration Form</strong></div>
						<div class="panel-body">
							<form action="?" method="post" class="form-horizontal" role="form" id="regForm">
							    <input type="hidden" name="Action" value="true">
							  	<div class="form-group">
							    	<label for="inputPlayer" class="col-sm-2 col-xs-12 control-label">Event</label>
							    	<div class="col-sm-10">
								    	
								    	<cfquery name="getEvents" datasource="metro">
											select *
											from events
										</cfquery>
								    	<select name="eventID" class="form-control">
									    	<cfoutput query="getEvents">
												<option value="#event_id#">#event# (#DateFormat(start_date, "dd-mmm-yyyy")#)</option>
											</cfoutput>
										</select>
							    	</div>
							  	</div>
							  	<div class="form-group">
							    	<label for="inputPlayer" class="col-sm-2 control-label">Player</label>
							    	<div class="col-sm-10">
								    	
								    	<cfquery name="getPlayers" datasource="metro">
											select p.*, h.grade from players p
											inner join  handicaps h
											ON p.handicap_id = h.handicap_id
											ORDER BY p.first_name, p.last_name
										</cfquery>
								    	<select name="playerID" class="form-control">
									    	<option value="0">Select Name</option>
									    	<cfoutput query="getPlayers">
												<option value="#player_id#" <cfif player_id EQ FORM.playerID>selected</cfif>>#first_name# #last_name#</option>
											</cfoutput>
										</select>
							    	</div>
							  	</div>
							  	<div class="form-group">
							    	<label for="inputMobile" class="col-sm-2 control-label">Mobile</label>
							    	<div class="col-sm-10">
							      		<input value="<cfoutput>#FORM.mobile#</cfoutput>" name="mobile" type="text" class="form-control" id="mobile" placeholder="Mobile">
							    	</div>
							  	</div>
							  	<div class="form-group">
							    	<label for="inputEmail" class="col-sm-2 control-label">Email</label>
							    	<div class="col-sm-10">
							      		<input value="<cfoutput>#FORM.email#</cfoutput>" name="email" type="text" class="form-control" id="Email" placeholder="Email">
							    	</div>
							  	</div>
							  	<div class="form-group">
							    	<div class="col-sm-offset-2 col-sm-10">
							      		<button class="btn btn-primary" id="btnReg">Sign me up!</button>
							    	</div>
							  	</div>
							</form>
						</div>
					</div>	
					   		
				</div>
			</div>
		</div>
	</section>
	
	<!--- 		
	<section id="payment" class="container">
		<div class="container"> 
		
			<div class="row">
		    	<div class="col-md-12">
			    	<br />
			    	<p>In order to secure your spot please transfer the <strong>$30 registration fee</strong> to the following account (or alternatively you can pay it in cash in person):</p>
			    </div>
			</div>	
            <div class="row">
            
		    	<div class="col-md-4"></div>
		    	<div class="col-md-4">
			    	<br/>
			    	<div class="panel panel-default">
					 	<div class="panel-heading">
					    	<h3 class="panel-title">Commonwealth Bank</h3>
					  	</div>
					  	<div class="panel-body">
					    	<strong>BSB:</strong> 062004
					  	</div>
					  	<div class="panel-body">
					    	<strong>ACC:</strong> 1035 0683
					  	</div>
					</div>
				</div>
				
			</div>
		</div>
	</section>--->
	
    
<cfinclude template="includes/inc_footer.cfm">