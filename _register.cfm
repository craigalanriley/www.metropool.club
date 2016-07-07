
<cfparam name="ErrorMessage" default="">
<cfparam name="SuccessMessage" default="">


<cfset thisPage = "Register">
<cfinclude template="includes/inc_header.cfm">

    <section id="title" class="tournament-blue" style="padding: 50px">
        <div class="container">
            <div class="row">
				
                <div class="col-sm-6">
                    <h1><cfoutput>#thisPage#</cfoutput></h1>
                    <p>Simply sign up below and pay your $30 registration fee to secure your spot!</p>
                </div>
                <div class="col-sm-6">
                    <ul class="breadcrumb pull-right">
                        <li><a href="index.html">Home</a></li>
                        <li class="active"><cfoutput>#thisPage#</cfoutput></li>
                    </ul>
                </div>
            </div>
        </div>
    </section><!--/#title-->
	
	
	<section id="about-us" class="container">
		<div class="container">
	    	<div class="col-md-12">
	    	
	    	
		    	<cfif isDefined("FORM.Action")>
	
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
						
						</cfmail>
						<cfset SuccessMessage = "Thankyou, your registration has been received.">
					
					</cfif>
				</cfif>
	    	
	    	
	    		<cfif len(ErrorMessage)>
	    			<div class="alert alert-danger"><cfoutput>#ErrorMessage#</cfoutput></div>
	    		</cfif>
	    		<cfif len(SuccessMessage)>
	    			<div class="alert alert-success"><cfoutput>#SuccessMessage#</cfoutput></div>
	    		</cfif>
				<!--- 
			    <h2><span class="label label-default">STEP 1</span> Check Availabilty</h2>
				<section id="about-us" class="container">
					<div class="container">
						<div class-"row">
					    	<div class="col-md-12">
						    <br />
							<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante.
							</p>
							</div>
						</div>					
			            <div class="row">
					    	<div class="col-md-12">
								<div class="progress">
								  	<div class="progress-bar progress-bar-success" style="width: 35%">
								    	<span class="sr-only">35% Complete (success)</span>
								  	</div>
								  	<div class="progress-bar progress-bar-warning" style="width: 20%">
								    	<span class="sr-only">20% Complete (warning)</span>
								  	</div>
								  	<div class="progress-bar progress-bar-danger" style="width: 10%">
								    	<span class="sr-only">10% Complete (danger)</span>
								  	</div>
								</div>
							</div>
						</div>
					</div>
				</section>
				--->
			    <p><h2><span class="label label-default">STEP 1</span> Registration Form</h2></p>
				<section id="about-us" class="container">
					<div class="container">
			            <div class="row">
			            	<div class="col-md-3"></div>
					    	<div class="col-md-6">
				    			<br />
				    			<br />
						    	<form action="?" method="post" class="form-horizontal" role="form">
							    <input type="hidden" name="Action" value="true">
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
												<option value="#player_id#">#first_name# #last_name#</option>
											</cfoutput>
										</select>
							    	</div>
							  	</div>
							  	<!--- 
							  	<div class="form-group">
							    	<label for="inputEmail3" class="col-sm-2 control-label">Name</label>
							    	<div class="col-sm-10">
							      		<input type="email" class="form-control" id="inputEmail3" placeholder="Email">
							    	</div>
							  	</div>
							  	<div class="form-group">
							    	<label for="inputPassword3" class="col-sm-2 control-label">Surname</label>
							    	<div class="col-sm-10">
							      		<input type="password" class="form-control" id="inputPassword3" placeholder="Password">
							    	</div>
							  	</div>
							  	<div class="form-group">
							    	<div class="col-sm-offset-2 col-sm-10">
							      		<div class="checkbox">
							        		<label>
							          			<input type="checkbox"> Remember me
							        		</label>
							      		</div>
							    	</div>
							  	</div>
							  	--->
							  	<div class="form-group">
							    	<label for="inputMobile" class="col-sm-2 control-label">Mobile</label>
							    	<div class="col-sm-10">
							      		<input name="mobile" type="text" class="form-control" id="mobile" placeholder="Mobile">
							    	</div>
							  	</div>
							  	<div class="form-group">
							    	<label for="inputEmail" class="col-sm-2 control-label">Email</label>
							    	<div class="col-sm-10">
							      		<input name="email" type="text" class="form-control" id="Email" placeholder="Email">
							    	</div>
							  	</div>
							  	<div class="form-group">
							    	<div class="col-sm-offset-2 col-sm-10">
							      		<button type="submit" class="btn btn-primary" id="btnReg">Sign me up!</button>
							    	</div>
							  	</div>
								</form>
							</div>
						</div>
					</div>
				</section>
				
			    <h2><span class="label label-default">STEP 2</span> Pay Registration</h2>
				<section id="about-us" class="container">
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
				</section>
			
			</div>
		</div>
	</section>
    
<cfinclude template="includes/inc_footer.cfm">