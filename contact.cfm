
<cfset thisPage = "Contact Us">
<cfinclude template="includes/inc_header.cfm">

    <section id="title" class="tournament-blue" style="padding: 50px">
        <div class="container">
            <div class="row">
				
                <div class="col-sm-6">
                    <h1><cfoutput>#thisPage#</cfoutput></h1>
                    <p>If you wish to contact us please use the form below</p>
                </div>
                <div class="col-sm-6">
                    <ul class="breadcrumb pull-right">
                        <li><a href="index.cfm">Home</a></li>
                        <li class="active"><cfoutput>#thisPage#</cfoutput></li>
                    </ul>
                </div>
            </div>
        </div>
    </section><!--/#title-->
	
	<section id="about-us" class="container">
	<div class="container">
    	<div class="col-md-2"></div>
    	<div class="col-md-8">
			
			
			<div class="panel panel-default">
				<div class="panel-heading">
				    <h3 class="panel-title">Contact Us</h3>
				</div>
				<div class="panel-body">
				    <p>If you wish to contact us please do so through our facebook group which can be found <a href="https://www.facebook.com/MetroPool.Club" class="text-primary" target="_blank">here</a>.</p>
				</div>
			</div>
			
			
		</div>
	</div>
	</section>
    
<cfinclude template="includes/inc_footer.cfm">