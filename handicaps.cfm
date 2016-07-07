
<cfset thisPage = "Grades &amp; Handicaps">
<cfinclude template="includes/inc_header.cfm">

    <section id="title" class="tournament-blue" style="padding: 50px">
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    <h1><cfoutput>#thisPage#</cfoutput></h1>
                    <p>&nbsp;A new easy to understand 4 grade handicap system!</p>
                </div>
                <div class="col-sm-6 hidden-xs">
                    <ul class="breadcrumb pull-right">
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
		      	<div class="col-lg-2 hidden-xs"></div>
		      	<div class="col-lg-8 col-xs-12">
		      		<h2 class="text-danger">Handicap System</h2>
					<div class="panel panel-default">
					  	<!-- Default panel contents -->
					  	<div class="panel-heading">How does the handicap system work?</div>
					  	<div class="panel-body">
						  	<p>MetroPool.Club uses a very simple 4 grade handicap system that is loosely based on the VNEA and BCA ranking systems.</p>
					    	<p>The table below is intended to be used as a guide for players to estimate what grade they will be playing in. 
							However because some players may be under handicapped in other leagues a final decision of what grade a player is will
							be made by MetroPool.Club before play starts.</p>
							<p>All matches in the MetroPool.Club singles league are <strong>race to 7</strong> with each player receiving 
			        		<strong>+2</strong> frame start for a sinlge grade difference, <strong>+1</strong> additional frame start for any subsequent grade differences. If both players have the same grade they will both start off scratch.</p>
				  		</div>
						
					  	<!-- Table -->
					  	<table class="table">
						<thead>
							<tr>
								<th>MetroPool.Club</th>
								<th>Diamond</th>
								<th>Pub Pool</th>
							</tr>
						</thead>
						<tbody>
							<tr class="danger">
								<td>Master</td>
								<td>12+</td>
								<td>26+</td>
							</tr>
							<tr class="warning">
								<td>Advanced</td>
								<td>8 - 11</td>
								<td>20 - 25</td>
							</tr>
							<tr class="success">
								<td>Intermediate</td>
								<td>4 - 7</td>
								<td>10 - 19</td>
							</tr>
							<tr class="info" style="background-color: #BCE8F1">
								<td>Open</td>
								<td>1-3</td>
								<td>< 9</td>
							</tr>
						</tbody>
						</table>
						
					</div><!-- End Panel -->
					
					<a id="players"></a>
				
				</div><!-- End Col -->
			</div><!-- End Row -->
				        <!--- 
				        <div class="row">
				        	<div class="col-sm-2"></div>
				            <div class="col-sm-8">			        
					        
				            </div>
				            <!--/.col-sm-6-->
				            <div class="col-sm-4">
								<div style="margin-bottom: 11px">
				                	<select name="grade1" class="form-control" >
										<option value="1" class="text-warning">Master</option>
										<option value="2">Advanced</option>
										<option value="3">Intermediate</option>
										<option value="4">Open</option>
									</select>
								</div>
								<div>
				                	<select name="grade1" class="form-control" >
										<option value="1">Master</option>
										<option value="2">Advanced</option>
										<option value="3">Intermediate</option>
										<option value="4">Open</option>
									</select>
								</div>
							</div> 
				            <div class="col-sm-8">
				                <div>
				                    <div class="progress">
				                        <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="90" style="width: 40%;">
				                            <span>4 Frame Start</span>
				                        </div>
				                    </div>
				                    <div class="progress">
				                        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="0" style="width: 0%;">
				                            <span></span>
				                        </div>
				                    </div>
				                </div>
				            </div><!--/.col-sm-6-->
							
				        </div><!--/.row-->    
				        --->    
				
		    
			<div class="row">
		      	<div class="col-lg-2 hidden-xs"></div>
		      	<div class="col-lg-8 col-xs-12">
					<h2 class="text-danger">Player Grades</h2>
					<div class="panel panel-default">
					  	<!-- Default panel contents -->
					  	<div class="panel-heading">What grade am I?</div>
					  	<div class="panel-body">
							<p>The comprehenssive list below should contain all the active players in the Sydney Metropolitan region, if you name does 
							not appear on this list you can add it during <a href="register.cfm" class="text-primary">registration</a> or contact 
							me via <a href="https://www.facebook.com/MetroPool.Club" target="_blank" class="text-primary">facebook</a> and I will add 
							you to the list.</p>
							
							<br/>
			                <div class="widget search">
			                	<cfparam name="FORM.freeText" default="">
			                    <form action="handicaps.cfm?#players" method="post">
			                        <div class="input-group">
			                            <input type="text" name="freeText" value="<cfoutput>#FORM.freeText#</cfoutput>" class="form-control" autocomplete="off" placeholder="Player Search">
			                            <span class="input-group-btn">
			                                <button class="btn btn-danger" type="button" onclick="submit()"><i class="icon-search"></i></button>
			                            </span>
			                        </div>
			                    </form>
			                </div>
							
						</div>
						<br />
						<cfquery name="getHandicaps" datasource="metro">
							select p.*, h.grade from players p
							inner join  handicaps h
							ON p.handicap_id = h.handicap_id
							<cfif len(FORM.freeText)>
								where (p.last_name LIKE '%#FORM.freeText#%' OR p.first_name LIKE '%#FORM.freeText#%')
							</cfif>
							ORDER BY p.first_name, p.last_name
						</cfquery>
						<table class="table">
						<thead>
							<tr style="background-color: #F5F5F5">
								<!--- <th>##</th> --->
								<th>Name</th>
								<th>Surname</th>
								<th>Grade</th>
								<!--- <th class="text-center hidden-xs">Division</th> --->
							</tr>
						</thead>
						<tbody>
						<cfoutput query="getHandicaps"> 
							<cfswitch expression="#handicap_id#">
								<cfcase value="1"><cfset gradeClass="text-danger"></cfcase>
								<cfcase value="2"><cfset gradeClass="text-warning"></cfcase>
								<cfcase value="3"><cfset gradeClass="text-success"></cfcase>
								<cfcase value="4"><cfset gradeClass="text-info"></cfcase>
							</cfswitch>
							<tr>
								<!--- <td>#player_id#</td> --->
								<td>#first_name#</td>
								<td>#last_name#</td>
								<td class="#gradeClass#">#grade#</td>
								<!--- <td class="text-center hidden-xs"><cfif handicap_id LT 3>A<cfelse>B</cfif></td> --->
							</tr>
						</cfoutput>
						</tbody>
						</table>
					</div>
				</div>
			</div>
			
			
		</div>
	</section>
    
<cfinclude template="includes/inc_footer.cfm">