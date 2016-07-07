
<cfset thisPage = "FAQ">
<cfinclude template="includes/inc_header.cfm">

    <section id="title" class="tournament-blue" style="padding: 50px">
        <div class="container">
            <div class="row">
				
                <div class="col-sm-6">
                    <h1><cfoutput>#thisPage#</cfoutput></h1>
                    <p>Please refer to this page if you have any questions as we aim to update it regulary</p>
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
			
			<h2 class="text-danger">Registration</h2>
			
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">Can anybody play in MetroPool.Club?</h3>
				</div>
				<div class="panel-body">
				    Yes, MetroPool.Club is open to all players in Sydney of any grade.
				</div>
			</div>
			<!--- 
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">Where can I sign up to play?</h3>
				</div>
				<div class="panel-body">
				    To sign up for the 8 Ball singles league that starts on June 30th 2014 simply visit the  <a href="register.cfm" class="text-primary">register</a> page.
				</div>
			</div>
			--->
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">How can I pay the registration fee to secure my spot?</h3>
				</div>
				<div class="panel-body">
				    <p>Please use the following bank details for all Metro Pool Club payments:</p>
				    
			    	<br/>
			    	<div class="col-md-4"></div>
			    	<div class="col-md-4">
				    	<div class="panel panel-info">
						 	<div class="panel-heading">
						    	<h3 class="panel-title">Commonwealth Bank</h3>
						  	</div>
						  	<div class="panel-body">
						    	<strong>Name:</strong> Foxtrot Yankee India
						  	</div>
						  	<div class="panel-body">
						    	<strong>BSB:</strong> 062948
						  	</div>
						  	<div class="panel-body">
						    	<strong>ACC:</strong> 1240 2079
						  	</div>
						</div>
					</div>
				
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">Are registration fees refundable?</h3>
				</div>
				<div class="panel-body">
				   No, registration fees are not refundable.
				</div>
			</div>
			
			<br/ ><h2 class="text-danger">League Rules</h2>
			
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">What are the rules?</h3>
				</div>
				<div class="panel-body">
				    The 8 ball singles league will use the BCA 8 ball rules that can be viewed <a href="http://www.playbca.com/portals/0/rules/8ball.pdf" target="_blank" class="text-primary">here</a>.
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">What happens if two players finish on the same points in the league?</h3>
				</div>
				<div class="panel-body">
				    If two players finish on the same points the players will be seperated by: <i>frame difference, frames won, frames lost, break & runs, head to head</i>.
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">What happens if two players finish on the same number of break and runs?</h3>
				</div>
				<div class="panel-body">
				    If two players finish on the total break and runs the players will be seperated by <i>break and run percentage, lags, head to head</i>.
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">Will the singles league be handicapped?</h3>
				</div>
				<div class="panel-body">
				    Yes, the grading system is very simple to understand, a full explanation can be viewed on the <a href="handicaps.cfm" class="text-primary">Grades &amp; Handicaps</a> page.
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">What happens if I can't play one week or I am going on holiday?</h3>
				</div>
				<div class="panel-body">
				    No worries, a singles league is slighty different to teams as there are no reserves of course. Therefore everyone has to be flexible to make it work so players can rearrange 
				    fixtures if they are unable to play. The only caveat being that no player can be <strong>two weeks (4 matches) ahead or behind</strong> the fixture list. 
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">What happens if my opponent doesn't turn up?</h3>
				</div>
				<div class="panel-body">
				    If your opponent doesn't turn up and hasn't rearranged the fixture the match will be <strong>forfeited as a whitewash</strong> (to handicap). 
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">What happens if my opponent is late?</h3>
				</div>
				<div class="panel-body">
				    If your opponent is late you will be awarded one frame forfeit for every 10 minutes ellapsed past the match start time. 
				    We had hoped to avoid penalties but unfortunately not everyone arrived on time and matches were finishing too late. 
				    If you think you might not be able to make the start time for your match you can simply requst a later start time.
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">Can I play my match on another night instead of Monday?</h3>
				</div>
				<div class="panel-body">
				    Yes (with the agreement of your opponent),  however please be aware that the tables <strong>will only be free between 7-11pm on Metro Monday nights</strong>.
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">What is a "break &amp; run"" and why are they important?</h3>
				</div>
				<div class="panel-body">
				    MetroPool.Club only recognises real break and runs and therefore can only be acheived by the breaking player. Each player with the most break and runs in each
				    division at the end of the season will have the chance to play the ghost for a share of the break and run prize during the Grand Finals. 
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">What happens if a player drops out of the league?</h3>
				</div>
				<div class="panel-body">
				    If a player drops out of the league before they have played 5 games all their previous results will be voided and the player will forfeit all registration and league fees paid. If a player drops out after that have played 5 matches or more their results will stand and they will forfeit all future matches to handicap. 
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">Foul shots</h3>
				</div>
				<div class="panel-body">
				    If you think a player is going to attempt a potentially foul shot please ask a third party to watch before the shot is played. 
				    A foul can not be called retrospectivly if nobody has watched the shot and there is a dispute.
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">Weekly payments and scoresheets</h3>
				</div>
				<div class="panel-body">
				    All players must submit $15 per match and a signed score sheet after each match.
				</div>
			</div>
			
			
			<br/ ><h2 class="text-danger">Grand Finals</h2>
			
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">Can anyone play in the grand finals?</h3>
				</div>
				<div class="panel-body">
				    No, only the players that have completed a full season and paid all their entry fees. 
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">Why does every player get to play in the grand finals?</h3>
				</div>
				<div class="panel-body">
				    We wanted to make the league meaningful with cash prizes for topping each division. 
				    Therefore in order to maintain the integrity of the league and to minimise people dropping out we wanted to ensure that every match counts.
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">Does my league position mean anything?</h3>
				</div>
				<div class="panel-body">
				    Yes, it is very important as the grand finals will be seeded based on your overall league finish. Higher finishers may also start deeper in the draw, this will be finalised once final numbers are known.
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">Will the grand finals be handicapped?</h3>
				</div>
				<div class="panel-body">
				    Yes, the grading system is very simple to understand, a full explanation can be viewed on the <a href="handicaps.cfm" class="text-primary">Grades &amp; Handicaps</a> page.
				</div>
			</div>
			
			<br/ ><h2 class="text-danger">Prizes</h2>
			
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">Do you really pay cash prizes?</h3>
				</div>
				<div class="panel-body">
				    Yes, apart from the trophy all prizes will be paid in cash so you can spend it whatever cue or trip to Vegas you like!
				</div>
			</div>
			
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">Will all the entry fees be paid out?</h3>
				</div>
				<div class="panel-body">
				    Yes, all the entry fees will be paid out as cash prizes and trophies. 
				    Some small running costs will be taken from the registration such as bank fees, web hosting etc. but unlike other leagues no admin fee will be taken. 
				</div>
			</div>
			
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">Do you take green fees from the prize money?</h3>
				</div>
				<div class="panel-body">
				    No, MetroPool.Club does not profit from green fees which means more prize money for the players!
				</div>
			</div>
			
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">Can I really play in the BCA Championships in Vegas if I play in MetroPool.Club?</h3>
				</div>
				<div class="panel-body">
				    Yes, all players that play in MetroPool.Club will be eligible to represent Australia in both the singles and scotch doubles events in Las Vegas! 
				</div>
			</div>
			
		</div>
	</div>
	</section>
    
<cfinclude template="includes/inc_footer.cfm">