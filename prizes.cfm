
<cfset thisPage = "Prizes">
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
		<div class="container">
	    	<div class="col-md-12">
			
				<div class="row">
				 	<div class="col-lg-2 hidden-xs"></div>
				 	<div class="col-lg-8 col-xs-12 text-center">	
				    	
						<div class="panel panel-primary">
							<!-- Default panel contents -->
							<div class="panel-heading text-left"><strong>League Season</strong> (Final Round 14th December 2015)</div>
							
						  	<!-- Table -->
						  	<table class="table">
							<thead>
								<tr style="background-color: #eee">
									<th>Overall League</th>
									<th width="100">Prize</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="text-primary text-left">1st Place</td>
									<td class="text-left" style="color: #ffd700">$1,000 + <span class="icon-trophy icon-xs"></span></td>
								</tr>
								<tr>
									<td class="text-primary text-left">2nd Place</td>
									<td class="text-left" style="color: #ffd700">$500</span></td>
								</tr>
								<tr>
									<td class="text-primary text-left">3rd Place</td>
									<td class="text-left" style="color: #ffd700">$250</span></td>
								</tr>
							</tbody>
							<thead>
								<tr style="background-color: #eee">
									<th>Division 1 League</th>
									<th width="100">Prize</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="text-primary text-left">1st Place</td>
									<td class="text-left" style="color: #ffd700">$750 + <span class="icon-trophy icon-xs"></span></td>
								</tr>
								<tr>
									<td class="text-primary text-left">2nd Place</td>
									<td class="text-left" style="color: #ffd700">$250</span></td>
								</tr>
							</tbody>
							<thead>
								<tr style="background-color: #eee">
									<th>Division 2 League</th>
									<th width="100">Prize</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="text-primary text-left">1st Place</td>
									<td class="text-left" style="color: #ffd700">$750 + <span class="icon-trophy icon-xs"></span></td>
								</tr>
								<tr>
									<td class="text-primary text-left">2nd Place</td>
									<td class="text-left" style="color: #ffd700">$250</span></td>
								</tr>
							</tbody>
							<thead>
								<tr class="danger">
									<th>LEAGUE TOTAL PRIZE FUND</th>
									<th width="100">$3,750</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td colspan="2" class="text-default text-left">
									  	<p>
									  		<strong><span class="fa fa-warning text-danger"></span></strong> 
									  		In order to be eligible for any prize each player must have completed the full season and not owe any fees.
										</p>
									</td>
								</tr>
							</tbody>
							</table>
						</div><!--- End Panel --->



						<div class="panel panel-primary">
							<!-- Default panel contents -->
							<div class="panel-heading text-left"><strong>Grand Finals</strong> (16-17th January 2016)</div>
							
						  	<!-- Table -->
						  	<table class="table">
							<thead>
								<tr style="background-color: #eee">
									<th>Seeded Double Elimination</th>
									<th width="100">Prize</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="text-primary text-left">1st Place</td>
									<td class="text-left" style="color: #ffd700">$1,500 + <span class="icon-trophy icon-xs"></span></td>
								</tr>
								<tr>
									<td class="text-primary text-left">2nd Place</td>
									<td class="text-left" style="color: #ffd700">$750</span></td>
								</tr>
								<tr>
									<td class="text-primary text-left">3rd Place</td>
									<td class="text-left" style="color: #ffd700">$500</span></td>
								</tr>
								<tr>
									<td class="text-primary text-left">4th Place</td>
									<td class="text-left" style="color: #ffd700">$250</span></td>
								</tr>
								<tr>
									<td class="text-primary text-left">5-6th Place</td>
									<td class="text-left" style="color: #ffd700">$125 x 2</span></td>
								</tr>
							</tbody>
							<thead>
								<tr style="background-color: #eee">
									<th>Break & Run Ghost Challenge</th>
									<th width="100">Prize</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="text-primary text-left">1st Place</td>
									<td class="text-left" style="color: #ffd700">$1000</span></td>
								</tr>
							</tbody>
							<thead>
								<tr class="danger">
									<th>GRAND FINALS TOTAL PRIZE FUND</th>
									<th width="100">$4,250</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td colspan="2" class="text-default text-left">
									  	<p>
									  		<strong><span class="fa fa-warning text-danger"></span></strong> 
									  		The Grand Finals prizes may decrease slightly slightly if all the players don't
									  		complete the season.
										</p>
										<p>
											All players that have completed the full season and do not owe any fees will qualify for the grand finals.
										</p>
										<p>
										  	The grand finals draw will be seeded and based on the final overall standings, with the top 8 players receiving a bye in the first round. 
										</p>
										<p>
											The player with the most break and runs in each grade will play the ghost on Grand Finals weekend for a chance to win the $1,000 prize.
										</p>
										<p>
											Players grade will be reviewed at the end of the league season and possibly changed before the grand finals.
										</p>
									</td>
								</tr>
							</tbody>
							</table>
						</div><!--- End Panel --->
							
					</div><!--- End Col --->
				</div><!--- End Row --->	
			
			
			</div>
		</div>
	</section>
    
<cfinclude template="includes/inc_footer.cfm">