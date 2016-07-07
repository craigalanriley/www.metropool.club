
<cfset thisPage = "Grand Finals">
<cfinclude template="includes/inc_header.cfm">

    <section id="title" class="tournament-blue" style="padding: 50px">
        <div class="container">
            <div class="row">
				
                <div class="col-sm-6">
                    <h1><cfoutput>#thisPage#</cfoutput></h1>
                    <p>The largest individual pool payouts in Sydney!</p>
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
	<section class="container">
			
				<div class="row">
				 	<div class="col-lg-2"></div>
				 	<div class="col-lg-8 col-xs-12 text-center">
			    	
						<div class="panel panel-danger">
							<!-- Default panel contents -->
							<div class="panel-heading text-left"><strong>GRAND FINALS</strong> - 22-23 November 2014</div>
							<table class="table" border="0">
							   	<tbody>
									<tr>
										<td class="text-left" colspan="4" style="padding: 20px">
											<p>
												The Grand Finals weekend schedule below contains times for the Final League Fixtures, Break &amp; Run Challenge, Presentation, 
												and the Grand Finals Handicapped Main Event. This event will be single elimination and seeded based on each players final position
												in the Handicapped League Table. There will be at least <strong class="text-danger">9 byes</strong> in the first round of 32 which will go to the 
												<strong class="text-danger">highest placed seeds</strong>. 
												All players that make it through to Sunday's quarter finals will be guaranteed prize money.
											</p>
											<p>
												Although they will not be changed during the league season, <strong class="text-danger">handicaps will be reviewed</strong> for the Grand Finals 
												Single Elimination and some players may move up or down a division based on their final stats. 
											</p>
										  	<p>
											  	Prizes are dependant on remaining players completing a full season but instead of keeping prizes 
											  	a suprise until the end of the season we have published the proposed prizes below.
											</p>
											<p>
												In order to be eligible for any prize each player must have completed the full season and not owe any fees.
											</p>
										
										</td>
									</tr>
								</tbody>
							</table>
							
						  	<!-- Table -->
						  	<table class="table">
							<thead>
								<tr style="background-color: #eee">
									<th colspan="2" class="text-center">Saturday 22nd November 2014</th>
								</tr>
							</thead>
							<tbody>
								<!--- 
								<tr>
									<td class="text-danger text-left">Master League Winner</td>
									<td class="text-left">$1,000</td>
								</tr> 
								--->
								<tr>
									<th width="10%">Time</th>
									<th width="90%">Event Description</th>
								</tr>
								<tr>
									<td class="text-default text-left">10:00 </td>
									<td class="text-left"><a href="fixtures.cfm?round=22" target="_blank" class="text-primary">Week 22</a> - Final round of league matches</td>
								</tr>
								<tr>
									<td class="text-default text-left">12:30</td>
									<td class="text-left"><a href="#bnrPoster" class="featherLink text-primary">Break and Run Challenge</a></td>
								</tr>
								<tr>
									<td class="text-default text-left">14:00</td>
									<td class="text-left"><a href="#gfChart" class="featherLink text-primary">Grand Finals</a> - Round 1 (Last 32)</td>
								</tr>
								<tr>
									<td class="text-default text-left">16:00</td>
									<td class="text-left"><a href="#gfChart" class="featherLink text-primary">Grand Finals</a> - Round 2 (Last 16)</td>
								</tr>
								<tr>
									<td class="text-default text-left">19:00</td>
									<td class="text-left text-danger">Metro Presentation Evening</td>
								</tr>
							</tbody>
							</table>
							
						  	<!-- Table -->
						  	<table class="table">
							<thead>
								<tr style="background-color: #eee">
									<th colspan="2" class="text-center">Sunday 23rd November 2014</th>
								</tr>
							</thead>
							<tbody>
								<!--- 
								<tr>
									<td class="text-danger text-left">Master League Winner</td>
									<td class="text-left">$1,000</td>
								</tr> 
								--->
								<tr>
									<th width="10%">Time</th>
									<th width="90%">Event Description</th>
								</tr>
								<tr>
									<td class="text-default text-left">12:00</td>
									<td class="text-left"><a href="#gfChart" class="featherLink text-primary">Grand Finals</a> - Quarter Finals</td>
								</tr>
								<tr>
									<td class="text-default text-left">14:00</td>
									<td class="text-left"><a href="#gfChart" class="featherLink text-primary">Grand Finals</a> - Semi Finals</td>
								</tr>
								<tr>
									<td class="text-default text-left">16:00</td>
									<td class="text-left"><a href="#gfChart" class="featherLink text-primary">Grand Finals</a> - FINAL</td>
								</tr>
								<!--- <tr>
									<td class="text-default text-left">18:00</td>
									<td class="text-left text-danger">Grand Finals Presentations</td>
								</tr> --->
							</tbody>
							</table>
							<!--- 
							<a href="#gfChart" class="featherLink">
								<img src="assets/posters/grandfinalschart.jpg" title="Grand Finals" alt="Grand Finals" width="100%" />
							</a> --->
						</div><!--- End Panel --->
							
					</div><!--- End Col --->
				</div><!--- End Row --->	
	</section>
		
<div class="lightbox" id="gfChart">
	<img src="images/fliers/grandfinalschart.jpg" title="Grand Finals" alt="Grand Finals" width="100%" />
</div>

<div class="lightbox" id="bnrPoster">
	<img src="images/fliers/2014-poster-ghost-large.jpg" title="Break &amp; Run Challenge" alt="Break &amp; Run Challenge" width="100%" />
</div>
	
	
    
<cfinclude template="includes/inc_footer.cfm">