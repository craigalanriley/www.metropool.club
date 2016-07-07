	<section id="bottom" class="wet-asphalt">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-sm-6">
                    <h4>About Us</h4>
					
                    <p>MetroPool.Club was created to provide on online platform that can be used to manage various pool competitions. The main aim is to simplify the admin process and reduce the cost of managing events and thereby increasing the amount of prize money that can be passed on to the players.</p>
					
					<p>By automating as much of the process as possible via mobile and web friendly user interfaces, social media, PayPal, and an SMS Gateway the players will also benefit from real time results and stats, no more waiting for manual reports!</p>

					<p>It is hoped that this platform will also lead to more exposure for the game which will result in greater participation, sponsorship and even greater prizes. With the players support and a bit of luck we can create a league that will satisfy both the social and the advanced players.</p>
					<br />
                </div><!--/.col-md-3-->

                <div class="col-md-4 col-sm-6">
					<img src="<cfoutput>#Application.Home#</cfoutput>/images/logo/logo-cityheroes.png" alt="" width="300" height="199" />
                </div> <!--/.col-md-3-->
            </div>
        </div>
    </section><!--/#bottom-->

    <footer id="footer" class="midnight-blue">
        <div class="container">
            <div class="row">
                <div class="col-xs-8">
                    &copy; <cfoutput>#Year(now())#</cfoutput> <a target="_blank" href="http://www.FoxtrotYankeeIndia.com">Foxtrot Yankee India</a> | ABN: 12 651 923816 | All rights reserved.
                </div>
                <div class="col-xs-4 text-right">
                    <ul>
                        <li><a id="gototop" class="gototop" href="#">Top <i class="icon-chevron-up"></i></a></li><!--#gototop-->
                    </ul>
                </div>
            </div>
        </div>
    </footer><!--/#footer-->
	
	<!---  LOGO - LARGE 
	<cfif thisPage EQ "Home">
		<div style="position:absolute; top:100px; left:5px; z-index: 10000" id="logoBig" class="hidden-xs hidden-sm">
			<a href="<cfoutput>#Application.Home#</cfoutput>"><img src="<cfoutput>#Application.Home#</cfoutput>/images/logo-final/full-logo-black-back.png" width="200"></a>
		</div>
	</cfif>--->
	<!--  LOGO - SMALL -->
	<div style="position:fixed; top:5px; left:130px; z-index: 5000" id="logoSmall" class="hidden-xs">
		<a href="<cfoutput>#Application.Home#</cfoutput>"><img src="<cfoutput>#Application.Home#</cfoutput>/images/logo-final/text-black-back.png" width="300" height=""></a>
	</div>	
	<!--  LOGO - X-SMALL -->
	<div style="position:fixed; top:15px; left:20px; z-index: 5000" id="logoXSmall" class="visible-xs">
		<a href="<cfoutput>#Application.Home#</cfoutput>"><img src="<cfoutput>#Application.Home#</cfoutput>/images/logo-final/text-black-back.png" width="200"></a>
	</div>

    <script src="<cfoutput>#Application.Home#</cfoutput>/js/bootstrap.min.js"></script>
    <script src="<cfoutput>#Application.Home#</cfoutput>/js/jquery.prettyPhoto.js"></script>
   <script src="<cfoutput>#Application.Home#</cfoutput>/js/main.js"></script><!---   --->
    <script src="<cfoutput>#Application.Home#</cfoutput>/js/featherlight.min.js"></script>
	
	<script>
		jQuery(function($) 
			{
	
			// Bind edit links to lightbox
			$('a.featherLink').featherlight(
				{
				    targetAttr: 'href'
				});
	
			$( ".featherLink" ).click(function() 
				{
				
				fixtureID = $(this).attr('fixtureID');
				resultID = $(this).attr('resultID');
				
				console.log(fixtureID);
				console.log(resultID);
								
				});
				
			$(".btnBnR").click(function() 
				{
				// Get which grade was clicked
			    thisGrade = $(this).attr('grade');
			    
			    $(this).toggleClass("glyphicon-chevron-up");
				$(this).toggleClass("glyphicon-chevron-down");
							    
			    console.log(thisGrade);
			    
			    $(".grade" + thisGrade).toggle();
			    
				});
			
			
			});
	
	</script>
	

<script>
	// Google Analytics
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	
	ga('create', 'UA-52536233-1', 'auto');
	ga('send', 'pageview');

</script>

	
		<!--- 
		<script>
			jQuery(function($) 
				{
				// Special Logo Fade For Home Page Only
				<cfif thisPage EQ "Home">
					$(window).scroll(function()
						{
				  		if ($(this).scrollTop() > 140 )
							{
				    		// Hide big and show small
							$('#logoBig').fadeOut(500);
							$('#logoSmall').show();
				  			}
				
				  		if ($(this).scrollTop() == 0)
							{
				    		// $('#logoSmall').fadeOut(500);
							$('#logoBig').fadeIn(500);
				  			}
						});
				<cfelse>
					$('#logoBig').hide();
				</cfif>
				});
		</script> --->	
	
</body>
</html>