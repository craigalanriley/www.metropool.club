
<cfparam name="ErrorMessage" 	default="">
<cfparam name="SuccessMessage" 	default="">
<cfparam name="FORM.email" 		default="">
<cfparam name="FORM.password" 	default="">
<cfparam name="FORM.playerID" 	default="">


<cfif isDefined("URL.Logout")>
	<cfscript>
		StructClear(Session);
	</cfscript>
</cfif> 


<cfif isDefined("FORM.Action")>

	<cfif NOT CompareNoCase(FORM.email, "info@metropool.club") AND NOT CompareNoCase(FORM.password, "Sydney13!")>
		<cfset Session.PlayerID=0>
		<cflocation url="index.cfm" addtoken="no">
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
			
			
			
		</cfif></cfmail>
		<cfset SuccessMessage = "Thankyou, your registration has been received.">
		--->
	<cfelse>
		<cfset ErrorMessage = "Login failed, please try again">
	</cfif>
</cfif>		

<cfset thisPage = "My Metro">
<cfinclude template="../includes/inc_header.cfm">

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
								<form action="?" method="post" class="form-horizontal" role="form" id="regForm">
								    <input type="hidden" name="Action" value="true">
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
								</form>
							</div>
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
	      	appId      : '<cfoutput>#Application.MetroAppID#</cfoutput>', // Metro App ID
	      	// channelUrl : 'http://hayageek.com/examples/oauth/facebook/oauth-javascript/channel.html', // Channel File
	      	status     : true, // check login status
	      	cookie     : true, // enable cookies to allow the server to access the session
	      	xfbml      : true  // parse XFBML
	    	});
		
	    // *** here is my code ***
	    if (typeof facebookInit == 'function') 
	    	{
	        facebookInit();
	    	}
	    };
	    
	
	function facebookInit()
  		{
		// do what you would like here

	    FB.Event.subscribe('auth.authResponseChange', function(response)
	    	{
	     	if (response.status === 'connected')
		    	{
		        console.log("connected!");
		        
		        // Successful FB login
		        // document.getElementById("message").innerHTML += "<br>Connected to Facebook";
          		
          		getUserInfo();
		        
		    	}
		    else if (response.status === 'not_authorized')
		    	{
		        // FAILED
		        document.getElementById("message").innerHTML +=  "<br>Failed to Connect";
		        
		        console.log("Not authorized!");
		    	} 
		    else
		    	{
		        // UNKNOWN ERROR
		        document.getElementById("message").innerHTML +=  "<br>Logged Out";
		        
		        $("#login").show();
		        $("#MyMetro").hide();
		        
		        console.log("Unknown Error!");
		    	}
		    });
		};
		
	function getUserInfo() 
	  		{
	        FB.api('/me', function(response) 
	        	{
	        	// getPhoto();
	        	
	        	console.log("getUserInfo!");
	        	console.log("Name: " + response.name);
	        	console.log("Link: " + response.link);
	        	console.log("Username: " + response.username);
	        	console.log("ID: " + response.id);
	        	console.log("email: " + response.email);
	        	// console.log("token: " + response.authResponse.accessToken);
	        	
	        	
	        	
	        	/* */ 
	          	$.ajax({
					url: "../cfc/login.cfc?method=fbLogin"
					, type: "get"
					, data: {
					    	// send the ID entered by the user
					    	fbUserID: 	response.id,
					    	fbToken: 	response.username,
					    	fbName: 	response.name,
					    	fbEmail: 	response.email,
					    	fbURL: 		response.link
					  		}
					// this gets the data returned on success
					, success: function (result)
						{
						console.log("Sucess!");
						
						console.log("result" + result);
						// Pass player id to redirect func
						dashboardRedirect(result);
						}
					// this runs if an error
					, error: function (xhr, textStatus, errorThrown)
						{
					    // show error
					    console.log(errorThrown);
					    // Redirect without playerID
					    dashboardRedirect(0);	
					  	}
					});
          		
          		// If connected we need to get user id
          		// 
	    		});
	    	}
		
	function dashboardRedirect(PID)
    	{
    		
			console.log("PID" + PID);
    		
    		window.location.href="index.cfm?roundID=0&playerID="+PID;
   		}
   		
 
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
    
<cfinclude template="../includes/inc_footer.cfm">