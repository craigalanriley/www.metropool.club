
<cfparam name="ErrorMessage" 	default="">
<cfparam name="SuccessMessage" 	default="">
<cfparam name="FORM.email" 		default="">
<cfparam name="FORM.password" 	default="">
<cfparam name="FORM.playerID" 	default="">

<cfset eventRaceLength = 7> <!--- Get From DB --->

<cfif isDefined("FORM.Action")>

	<cfif NOT CompareNoCase(FORM.email, "info@metropool.club") AND NOT CompareNoCase(FORM.password, "Sydney13!")>
		<cfset Session.PlayerID=0>
		<!--- Check if already registered? 
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
			
			
			
		</cfif></cfmail>--->
		<cfset SuccessMessage = "Thankyou, your registration has been received.">
	<cfelse>
		<cfset ErrorMessage = "Login failed, please try again">
	</cfif>
</cfif>		

<cfif isDefined("URL.Logout")>
	
	<cfscript>
	
		StructClear(Session);
	
	</cfscript>

</cfif> 

<cfset thisPage = "My Metro">
<cfinclude template="includes/inc_header.cfm">

<section id="title" class="tournament-blue">
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <h1><cfoutput>#thisPage#</cfoutput></h1>
                <p>Login to see your personal fixtures and enter your match results</p>
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
	

	
<div id="status">
Result:<br>
</div>
<div id="message">
Logs:<br/>
</div>
	
		<section id="login">
			<div class="container">
				<div class="row">
					<div class="col-md-4 hidden-xs"></div>
					<div class="col-md-4 col-xs-12">
						<cfif len(ErrorMessage)>
				   			<div class="alert alert-danger text-center" style=""><cfoutput>#ErrorMessage#</cfoutput></div>
				   		</cfif>
				   		<cfif len(SuccessMessage)>
				   			<div class="alert alert-success text-center"><cfoutput>#SuccessMessage#</cfoutput></div>
				   		</cfif>
				   		<div class="panel panel-default">
			  				<div class="panel-heading"><strong>My Metro</strong></div>
							<div class="panel-body">
								<form action="?" method="post" class="form-horizontal" role="form" id="regForm">
								    <input type="hidden" name="Action" value="true">
								    
								    <div class="col-lg-1"></div>
							    	<div class="col-lg-10">
							    		<br />
									    <div class="form-group">
								    		<button type="button" class="btn btn-primary btn-lg btn-block" onclick="Login()"> 
											  	<i class="fa fa-facebook fa-lg"></i> &nbsp; Login with Facebook
											</button>
							    		</div>
									    <div class="form-group text-center text-muted">
											OR
										</div>
									    <div class="form-group">
										    <div class="input-group">
											    <span class="input-group-addon">
													<span class="glyphicon glyphicon-user"></span>
												</span>
											  	<input name="email" type="text" class="form-control" id="Email" placeholder="Username" value="<cfoutput>#FORM.email#</cfoutput>">
											</div>
										</div>
									    <div class="form-group">
										    <div class="input-group">
											    <span class="input-group-addon">
													<span class="glyphicon glyphicon-lock"></span>
												</span>
											  	<input name="Password" type="password" class="form-control" id="password" placeholder="Password" value="<cfoutput>#FORM.Password#</cfoutput>">
											</div>
										</div>
									    <div class="form-group">
								      		<button class="btn btn-default btn-block active" id="btnReg"> Login</button>
								      	</div>
									</div>
								</form>
							</div>
						</div>	
						   		
					</div>
				</div>
			</div>
		</section>
		
		
		<script>
			
			// Login()
				// FB.login()
					// getUserInfo()
			
			// FB Login
			window.fbAsyncInit = function() 
			  	{
			    FB.init(
			    	{
			      	appId      : '1482838855321210', // Metro App ID
			      	// channelUrl : 'http://hayageek.com/examples/oauth/facebook/oauth-javascript/channel.html', // Channel File
			      	status     : true, // check login status
			      	cookie     : true, // enable cookies to allow the server to access the session
			      	xfbml      : true  // parse XFBML
			    	});

			    FB.Event.subscribe('auth.authResponseChange', function(response)
			    	{
			     	if (response.status === 'connected')
				    	{
				        // Successful FB login
				        document.getElementById("message").innerHTML += "<br>Connected to Facebook";
				        
				        $("#login").hide();
				        $("#MyMetro").show();
				    	}
				    else if (response.status === 'not_authorized')
				    	{
				        // FAILED
				        document.getElementById("message").innerHTML +=  "<br>Failed to Connect";
				    	} 
				    else
				    	{
				        // UNKNOWN ERROR
				        document.getElementById("message").innerHTML +=  "<br>Logged Out";
				        
				        $("#login").show();
				        $("#MyMetro").hide();
				    	}
				    });
			    };
		 
		 
		  	function Login()
		    	{
		        FB.login(function(response) 
		        	{
		           	if (response.authResponse)
		           		{
		                getUserInfo();
		            	} 
		            else{
		             	console.log('User cancelled login or did not fully authorize.');
		            	}
		         	},
	         	{scope: 'email,public_profile'});
	    		}
	    		
		 
		  	function getUserInfo() 
		  		{
		        FB.api('/me', function(response) 
		        	{
				  	var str="<b>Name</b> : "+response.name+"<br>";
				   		str +="<b>Link: </b>"+response.link+"<br>";
				        str +="<b>Username:</b> "+response.username+"<br>";
				        str +="<b>id: </b>"+response.id+"<br>";
				        str +="<b>Email:</b> "+response.email+"<br>";
				        str +="<input type='button' value='Get Photo' onclick='getPhoto();'/>";
				        str +="<input type='button' value='Logout' onclick='Logout();'/>";
				        // document.getElementById("status").innerHTML=str;

				        // If successful login get player ID & set session
				        /**/
						$.ajax({
							// the location of the CFC to run
							url: "cfc/login.cfc?method=fbLogin"
							// send a GET HTTP operation
							, type: "get"
							// tell jQuery we're getting JSON back
							, dataType: "json"
							// send the data to the CFC
							, data: {
							    	// send the ID entered by the user
							    	fbEmail: response.email,
							    	fbToken: response.id
							  		}
							// this gets the data returned on success
							, success: function (data)
								{
								console.log("Ajax Sucess!");
								// console.log(data);
								}
							// this runs if an error
							, error: function (xhr, textStatus, errorThrown)
								{
								console.log("Ajax Error!");
							    console.log(errorThrown);	
							  	}
							});
						
							
						// Reload Page
						// location.reload();
				        
				        
		    		});
		    	}

		    function getPhoto()
		    	{
		      	FB.api('/me/picture?type=normal', function(response) 
		      		{
		          	var str="<br/><b>Pic</b> : <img src='"+response.data.url+"'/>";
		          	document.getElementById("status").innerHTML+=str; 
		    		});
		    	}

		    function Logout()
		    	{
		        FB.logout(function(){document.location.reload();});
		    	}
		 
		  	// Load the SDK asynchronously
		  	(function(d)
			  	{
			    var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
			    if (d.getElementById(id)) {return;}
			    js = d.createElement('script'); js.id = id; js.async = true;
			    js.src = "//connect.facebook.net/en_US/all.js";
			    ref.parentNode.insertBefore(js, ref);
		   		}
		   	(document));
		 
		</script>
		
		
		<section id="MyMetro" style="display:none">
		
			<input type='button' value='Logout' onclick='Logout();'/>
		
			<cfif isNumeric(FORM.playerID)>
				<cfset FORM.playerID=FORM.playerID>
			<cfelse>
				<cfset FORM.playerID = 0>
			</cfif>
		
		   	<cfscript>
			   	
			   	// writeDump(FORM);
			   	
				objFixtures = CreateObject("component","cfc.fixtures");
				
				if (NOT isDefined("FORM.roundID") )
					{
					whichRound	= objFixtures.getRound(); // writeDump(whichRound);
					FORM.roundID = whichRound.nextRound;
					}
					
				getFixtures = objFixtures.getFixtures(
														playerID	= #FORM.playerID#,
														roundID		= #FORM.roundID#
													 );
						
			</cfscript>
		
			<div class="row">
			 	<div class="col-lg-3"></div>
			 	<div class="col-lg-6 text-left">
			 	
			 	<h2 class="text-danger">My Fixtures</h2>
				
					<div class="panel panel-default">
					
			    		<div class="panel-heading text-left"><cfoutput><strong>LEAGUE FIXTURES</strong></cfoutput></div>
		    			<form action="?" method="post">
			    			 
						    <div class="row hidden-xs" style="margin: 20px 0 20px 0"></div>
						        <div class="col-xs-1 col-sm-1 hidden-xs hidden-sm"></div>
						        <div class="col-xs-12 col-sm-12">
						            <div class="input-group">
										<span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
							    		<select name="roundID" class="form-control">
											<option value="0">Any Week</option>
											<cfloop from="1" to="22" index="w">
												<cfoutput><option value="#w#" <cfif FORM.roundID EQ w>selected</cfif>>Week #w#</option></cfoutput>
											</cfloop>
										</select>
						            </div>
						        </div>
						        <div class="col-xs-12 col-sm-12">
						            <div class="input-group text-left">
										<span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
										<cfscript>
											objPlayers = CreateObject("component","cfc.players");
											allPlayers = objPlayers.getEventPlayers(EventID=1);
										</cfscript>
							    		<select name="playerID" class="form-control">
											<option value="0">Any Player</option>
											<cfoutput query="allPlayers">
												<option value="#player_id#" <cfif FORM.playerID EQ player_id>selected</cfif>>#full_name#</option>
											</cfoutput>
										</select>
						            </div>
						        </div>
						        <div class="col-xs-12 col-sm-12 text-right">
						            <div class="input-group">
										<button type="submit" class="btn btn-primary">Search</button>
						            </div>
						        </div>
						        <div class="col-xs-1 hidden-xs hidden-sm"></div>
						    
						</form>
		
						<table class="table" border="0">
						   	<tbody>
							   	<cfset Match 		= 0>
							   	<cfset prevRound 	= 0>
								   	<cfif getFixtures.RecordCount>
								   	<cfoutput query="getFixtures">
									   	<cfif round GT prevRound AND playerID EQ 0>
											<tr style="background-color: ##fff">
												<th class="hidden-xs hidden-sm">Match</th>
												<th class="hidden-xs hidden-sm">Time</th>
												<th class="text-right">Player 1</th>
												<th class="text-center" width="0">(Race to 9)</th>
												<th class="text-left">Player 2</th>
												<th class="text-center hidden-xs hidden-sm" title="Grade Match">GM</th>
												<th>&nbsp;</th>
											</tr>
											<cfset prevRound = getFixtures.round>
										</cfif>
									   	
									   	<cfset Match = Match + 1>
										<cfswitch expression="#home_handicap_id#">
											<cfcase value="1"><cfset homeGradeClass = "text-danger"></cfcase>
											<cfcase value="2"><cfset homeGradeClass = "text-warning"></cfcase>
											<cfcase value="3"><cfset homeGradeClass = "text-success"></cfcase>
											<cfcase value="4"><cfset homeGradeClass = "text-primary"></cfcase>
										</cfswitch>
										<cfswitch expression="#away_handicap_id#">
											<cfcase value="1"><cfset awayGradeClass = "text-danger"></cfcase>
											<cfcase value="2"><cfset awayGradeClass = "text-warning"></cfcase>
											<cfcase value="3"><cfset awayGradeClass = "text-success"></cfcase>
											<cfcase value="4"><cfset awayGradeClass = "text-primary"></cfcase>
										</cfswitch>
										<!--- 
										1-Master
										--->
										
										<cfif result_id EQ 0>
											<cfset HomeScore = HomeStart>
											<cfset AwayScore = AwayStart>
										</cfif>
										<tr>
											<td class="text-muted text-left hidden-xs hidden-sm">M<cfif fixture_id LT 10>0</cfif>#fixture_id#</td>
											<td class="text-left text-left hidden-xs hidden-sm">#TimeFormat(scheduled_time, "HH:MM")#</td>
											<td class="#homeGradeClass# text-right" <cfif PlayerID EQ home_player_id>style="font-weight: bold"</cfif>>
												<span class="visible-xs visible-sm">#home_player_short#</span>
												<span class="hidden-xs hidden-sm">#home_player#</span>
											</td>
											<td class="text-center" width="0">
												<span class="homeScore#fixture_id#">#ToString(HomeScore)#</span> - <span class="awayScore#fixture_id#">#ToString(AwayScore)#</span>
											</td>
											<td class="#awayGradeClass# text-left"<cfif PlayerID EQ away_player_id>style="font-weight: bold"</cfif>>
												<span class="visible-xs visible-sm">#away_player_short#</span>
												<span class="hidden-xs hidden-sm">#away_player#</span>
											</td>
											<td class="text-center hidden-xs hidden-sm">
											<cfif HomeStart EQ AwayStart>
												<span class="glyphicon glyphicon-star" style="color: gold"></span>
											<cfelse>
												&nbsp;
											</cfif>
											</td>
											<td><span fixtureID="#fixture_id#" class="glyphicon glyphicon-chevron-down btnEditForm" style="cursor: pointer"></span></td>
											<!--- <td class="text-right">
											  	<a href="##fl1" class="featherLink" fixtureID="#fixture_id#" resultID="#result_id#"><span class="glyphicon glyphicon-edit"></span> Edit </a>
											</td> --->
										</tr>
										<tr class="editForm#fixture_id#" style="display:none">
											<td class="text-muted text-left hidden-xs hidden-sm">&nbsp;</td>
											<td>&nbsp;</td>
											<td colspan="3" align="center">
												
												<table cellpadding="2" border="0" style="border: 1px solid ##DDD">
													<tr>
														<td class="text-center"><input type="radio" name="lag#fixture_id#" value="0" <cfif homeLag EQ 1>checked</cfif>></td>
														<td class="text-center">Lag</td>
														<td class="text-center"><input type="radio" name="lag#fixture_id#" value="1" <cfif awayLag EQ 1>checked</cfif>></td>
													</tr>
													<tr>
														<td>
															<select name="homeRunouts#fixture_id#" class="form-control">
																<cfloop from="0" to="#eventRaceLength#" index="hr">
																	<option value="#hr#"<cfif homeRunouts EQ hr>selected</cfif>>#hr#</option>
																</cfloop>
															</select>
														</td>
														<td class="text-center">B&R</td>
														<td>
															<select name="awayRunouts#fixture_id#" class="form-control">
																<cfloop from="0" to="#eventRaceLength#" index="ar">
																	<option value="#ar#"<cfif awayRunouts EQ ar>selected</cfif>>#ar#</option>
																</cfloop>
															</select>
														</td>
													</tr>
													<tr>
														<td>
															<select name="homeScore#fixture_id#" class="form-control">
																<cfloop from="0" to="#eventRaceLength#" index="hs">
																	<option value="#hs#" <cfif homeScore EQ hs>selected</cfif>>#hs#</option>
																</cfloop>
															</select>
														</td>
														<td class="text-center">Score</td>
														<td>
															<select name="awayScore#fixture_id#" class="form-control">
																<cfloop from="0" to="#eventRaceLength#" index="as">
																	<option value="#as#" <cfif awayScore EQ as>selected</cfif>>#as#</option>
																</cfloop>
															</select>
														</td>
													</tr>
													<tr>
														<td colspan="3" class="text-center">
															<cfquery name="getFixtureStatus" datasource="metro">
																select status_id, status
																from fixture_status
															</cfquery>
															<select name="fixtureStatus#fixture_id#" class="form-control">
																<option value="0">Auto Status</option>
																<cfloop query="getFixtureStatus">
																	<option value="#status_id#">#status#[#status_id#]</option>
																</cfloop>
															</select>
														</td>
													</tr>
													<!---  <cfif getFixtureStatus.status_id EQ getFixtures.status_id>selected</cfif> --->
													<tr>
														<td colspan="3" class="text-center">
															<button 
																	resultID="#result_id#" 
																	fixtureID="#fixture_id#" 
																	homePlayerID="#home_player_id#" 
																	awayPlayerID="#away_player_id#" 
																	type="button" 
																	class="btn btn-primary saveResult">
																		
																	<i id="saveIcon#fixture_id#" class="fa fa-refresh"></i> Save
															</button>
														</td>
													</tr>
												</table>
												
											</td>
											<td class="hidden-xs hidden-sm">&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<cfif fixture_id EQ 94>
										</cfif>
									</cfoutput>
								<cfelse>
									<tr>
										<th class="hidden-xs hidden-sm">Match</th>
										<th>Time</th>
										<th class="text-right">Player 1</th>
										<th class="text-center" width="0">(Race to 9)</th>
										<th class="text-left">Player 2</th>
										<th class="text-center hidden-xs" title="Grade Match">GM</th>
										<th></th>
									</tr>	
									<tr>
										<td class="text-danger" colspan="7" style="padding: 50px">Full fixtures will appear here shortly</td>
									</tr>
								</cfif>
							</tbody>
						</table>
					</div>
		
				</div>
			</div>
		
		</section>
	
	
<div class="lightbox" id="fl1">
	
	<table width="100%">
		<tr>
			<td style="background-color: black"><img src="images/logo/logo-metro-xsmall.png" width="300px"/></td>
			<td width="100%"> 
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				DATE:  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				START TIME: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
	</table>
	<br />
	<br />
	<table width="100%" cellpadding="5">
		<tr>
			<th>Players</th>
			<th class="text-center">Lag</th>
			<th class="text-center">1</th>
			<th class="text-center">2</th>
			<th class="text-center">3</th>
			<th class="text-center">4</th>
			<th class="text-center">5</th>
			<th class="text-center">6</th>
			<th class="text-center">7</th>
			<th class="text-center">8</th>
			<th class="text-center">9</th>
			<th>Total Score</th>
			<th>Total B&R</th>
		</tr>
		<form method="post" action="?">
		<tr>
			<td>Firstname Surname</td>
			<td class="text-center"><input type="radio" value="1" name="lag" class="form-control"></td>
			<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
			<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
			<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
			<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
			<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
			<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
			<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
			<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
			<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
			<td><input type="text" size="4" class="form-control"></td>
			<td>
			<select name="runouts" class="form-control">
				<cfloop from="1" to="9" index="r">
					<cfoutput><option value="#r#">#r#</option></cfoutput>
				</cfloop>
				<option value="0">0</option>
				<option value="1">1</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Firstname Surname</td>
			<td class="text-center"><input type="radio" value="1" name="lag" class="form-control"></td>
			<td class="text-center"><input type="checkbox" value="0" class="form-control" checked DISABLED></td>
			<td class="text-center"><input type="checkbox" value="0" class="form-control" checked DISABLED></td>
			<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
			<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
			<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
			<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
			<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
			<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
			<td class="text-center"><input type="checkbox" value="0" class="form-control"></td>
			<td><input type="text" size="4" class="form-control"></td>
			<td>
			<select name="runouts" class="form-control">
				<cfloop from="1" to="9" index="r">
					<cfoutput><option value="#r#">#r#</option></cfoutput>
				</cfloop>
				<option value="0">0</option>
				<option value="1">1</option>
			</select>
			</td>
		</tr>
		</form>
	</table>
	<div class="text-center"><button class="btn btn-primary" id="btnReg">Save</button></div>
	
</div>
	
	
    
<cfinclude template="includes/inc_footer.cfm">