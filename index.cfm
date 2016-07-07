
<cfinclude template="includes/inc_header.cfm">

    <section id="main-slider" class="no-margin">
        <div class="carousel slide wet-asphalt">
            <ol class="carousel-indicators">
                <li data-target="#main-slider" data-slide-to="0" class="active"></li>
                <li data-target="#main-slider" data-slide-to="1"></li>
                <li data-target="#main-slider" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="item active" style="background-image: url(images/slider/bg4.jpg)">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="carousel-content centered">
                                    <h2 class="boxed animation animated-item-1">Welcome to MetroPool.Club</h2>
                                   	<p class="animation animated-item-2"><i class="icon-dollar icon-xs"></i><i class="icon-dollar icon-xs"></i> The largest cash prizes in Australian pool</p>
                                   	<p class="animation animated-item-2"><i class="icon-trophy icon-xs"></i> Premium trophies</p>
                                   	<p class="animation animated-item-3"><i class="icon-gears icon-xs"></i> Intuitive grades &amp; handicaps</p>
                                   	<p class="animation animated-item-3"><i class="icon-bar-chart icon-xs"></i> Professional website & stats</p>
                                   	<p class="animation animated-item-4"><i class="icon-heart icon-xs"></i> No admin or green fees!</p>
                                   	<!--- <a class="btn btn-md animation animated-item-5" href="register.cfm">Register</a> --->
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!--/.item-->
                <div class="item" style="background-image: url(images/slider/bg6.jpg)">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="carousel-content center centered">
                                    <h2 class="boxed animation animated-item-1">The best pool hall in metropolitan Sydney</h2>
									<br>
                                    <h3 class="boxed animation animated-item-2">Professional 9ft American pool tables</h3>
                                    <br>
									<!--- <a class="btn btn-md animation animated-item-3" href="#">Learn More</a> --->
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!--/.item-->
                <div class="item" style="background-image: url(images/slider/bg5.jpg)">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-3"></div>
                            <div class="col-sm-6">
                                <div class="carousel-content center centered">
                                    <h1 class="boxed animation animated-item-1">VIVA LAS VEGAS! - 22 July 2015 </h1>
									<br />
                                    <p class="boxed animation animated-item-2">All players will be eligible to play in both the BCA singles and scotch doubles events.</p>
                                    <br>
                                    <!--- <a class="btn btn-md animation animated-item-3" href="#">Learn More</a> --->
                                </div>
                            </div>
                            <div class="col-sm-3"></div>
							<!--- 
                            <div class="col-sm-6 hidden-xs animation animated-item-6">
                                <div class="centered">
                                    <div class="embed-container">
                                        <iframe src="//player.vimeo.com/video/69421653?title=0&amp;byline=0&amp;portrait=0&amp;color=a22c2f" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
                                    </div>
                                </div>
                            </div>
							--->
                        </div>
                    </div>
                </div><!--/.item-->
            </div><!--/.carousel-inner-->
        </div><!--/.carousel-->
        <a class="prev hidden-xs" href="#main-slider" data-slide="prev">
            <i class="icon-angle-left"></i>
        </a>
        <a class="next hidden-xs" href="#main-slider" data-slide="next">
            <i class="icon-angle-right"></i>
        </a>
    </section><!--/#main-slider-->

    <section id="services" class="tournament-blue">
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-sm-6">
                    <div class="media">
                        <div class="pull-left">
                            <i class="icon-trophy icon-md"></i>
                        </div>
                        <div class="media-body" onclick="location.href='register.cfm'" onmouseover="this.style.cursor='pointer'">
                            <h3 class="media-heading">I want to play!</h3>
                            <p>If you wish to play in Sydney's first ever 8 ball singles league and play for the largest prizes in Australia <a href="register.cfm" class="text-primary">click here</a> to register and find out more!</p>
                        </div>
                    </div>
                </div><!--/.col-md-4-->
                <div class="col-md-4 col-sm-6">
                    <div class="media">
                        <div class="pull-left">
                            <i class="icon-gears icon-md"></i>
                        </div>
                        <div class="media-body" onclick="location.href='handicaps.cfm'" onmouseover="this.style.cursor='pointer'">
                            <h3 class="media-heading">What grade am I?</h3>
                            <p>Want to play but not sure how it works or what grade you will be? Then simply <a href="handicaps.cfm" class="text-primary">click here</a> to see how simple MetroPool.Club is compared to other systems.</p>
                        </div>
                    </div>
                </div><!--/.col-md-4-->
                <div class="col-md-4 col-sm-6">
                    <div class="media">
                        <div class="pull-left">
                            <i class="icon-facebook icon-md"></i>
                        </div>
                        <div class="media-body" onclick="location.href='https://www.facebook.com/MetroPool.Club'" onmouseover="this.style.cursor='pointer'">
                            <h3 class="media-heading">Facebook #updates</h3>
                            <p>Please <a href="https://www.facebook.com/MetroPool.Club" class="text-primary">click here</a> to view our MetroPool.Club Facebook page, don't forget to like it to get all the latest news and event updates. Shares are particulary welcome!</p>
                        </div>
                    </div>
                </div><!--/.col-md-4-->
				<!--- 
                <div class="col-md-4 col-sm-6">
                    <div class="media">
                        <div class="pull-left">
                            <i class="icon-youtube icon-md"></i>
                        </div>
                        <div class="media-body" onclick="location.href='https://www.youtube.com/user/MetroPoolClub'" onmouseover="this.style.cursor='pointer'">
                            <h3 class="media-heading">You Tube</h3>
                            <p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae.</p>
                        </div>
                    </div>
                </div><!--/.col-md-4-->
                <div class="col-md-4 col-sm-6">
                    <div class="media">
                        <div class="pull-left">
                            <i class="icon-twitter icon-md"></i>
                        </div>
                        <div class="media-body" onclick="location.href='https://twitter.com/MetroPoolClub'" onmouseover="this.style.cursor='pointer'">
                            <h3 class="media-heading">Twitter</h3>
                            <p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae.</p>
                        </div>
                    </div>
                </div><!--/.col-md-4-->
				 --->
            </div>
        </div>
    </section><!--/#services-->
    <section>
        <div class="container">
		
			<h3>Welcome to MetroPool.Club</h3>
            <div class="row">
				<div class="col-md-12">
					
					<p>
					<br />
					Sydney's first 8 ball singles league has arrived, designed to test your skills againsts other players in your <a href="handicaps.cfm" class="text-primary">grade</a> and the best in town!<br />
					<br />
					Every Metro Monday each player will play one or two matches using BCA 8 ball rules. Unlike league play, these longer races will better enable every player to improve their skills and hopefully advance to the next level.<br />
					<br />
					But don't worry, if you can't make every monday or if you have a planned vacation you will be able to reschedule your match and play it at a mutually agreeable new date with your opponent. As long as you don't fall too far behind are availble to play the final round you won't miss a thing or be penalised.<br />
					<br />
					In addition to improving your game, you will also have the chance at winning a share of amazing cash prizes that are up for grabs, with approximately half the prize fund allocated to divisional prizes so every grade of player gets the chance to win. The other half of the prize fund will be paid out at the end of season grand finals, a handicapped event that will be open to every player 
					that has played the full season. Your final league position will play a big part in the grand finals though so as to ensure every league match counts. <!--- Please see the  <a href="poster.cfm" class="text-primary">event poster</a> for more details.<br /> --->
					<br />
					I can also confirm that players can wear their own shirts, no admin fees will be taken, and green fees will be free during Metro Mondays.<br />
					<br />
					Now let's find out who has the game...<br />
					<br />
					Good Luck!
					</p>
				
				</div>
			
				<!--- <div class="col-md-4"><a href="poster.cfm"><img src="images/fliers/2014-poster-singles-small.jpg" style="width: 100% " /></a></div> --->
			
				<!--- 
                <div class="col-md-3">
                    <h3>Upcoming Events</h3>
                    <p>More details of the Grand Finals, a Calcutta and other exciting announcements are coming soon!</p>
                    <div class="btn-group">
                        <a class="btn btn-danger" href="#scroller" data-slide="prev"><i class="icon-angle-left"></i></a>
                        <a class="btn btn-danger" href="#scroller" data-slide="next"><i class="icon-angle-right"></i></a>
                    </div>
                    <p class="gap"></p>
                </div>
                <div class="col-md-9">
                    <div id="scroller" class="carousel slide">
                        <div class="carousel-inner"><!--- 
                            <div class="item active">
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="portfolio-item">
                                            <div class="item-inner">
                                                <img class="img-responsive" src="images/portfolio/recent/item1.png" alt="">
                                                <h5>
                                                    Nova - Corporate site template
                                                </h5>
                                                <div class="overlay">
                                                    <a class="preview btn btn-danger" title="Malesuada fames ac turpis egestas" href="images/portfolio/full/item1.jpg" rel="prettyPhoto"><i class="icon-eye-open"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>                            
                                    <div class="col-xs-4">
                                        <div class="portfolio-item">
                                            <div class="item-inner">
                                                <img class="img-responsive" src="images/portfolio/recent/item3.png" alt="">
                                                <h5>
                                                    Fornax - Apps site template
                                                </h5>
                                                <div class="overlay">
                                                    <a class="preview btn btn-danger" title="Malesuada fames ac turpis egestas" href="images/portfolio/full/item1.jpg" rel="prettyPhoto"><i class="icon-eye-open"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>                            
                                    <div class="col-xs-4">
                                        <div class="portfolio-item">
                                            <div class="item-inner">
                                                <img class="img-responsive" src="images/portfolio/recent/item2.png" alt="">
                                                <h5>
                                                    Flat Theme - Business Theme
                                                </h5>
                                                <div class="overlay">
                                                    <a class="preview btn btn-danger" title="Malesuada fames ac turpis egestas" href="images/portfolio/full/item1.jpg" rel="prettyPhoto"><i class="icon-eye-open"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div><!--/.row-->
                            </div><!--/.item--> --->
                            <div class="item active">
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="portfolio-item">
                                            <div class="item-inner">
                                                <img class="img-responsive" src="images/fliers/2014_poster_singles.jpg" alt="">
                                                <h5>30th June 2014 - 8 Ball Singles</h5>
                                                <div class="overlay">
                                                    <a class="preview btn btn-danger" title="30th June 2014 - 8 Ball Singles" href="images/fliers/2014_poster_singles.jpg" rel="prettyPhoto"><i class="icon-eye-open"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--- 
									<div class="col-xs-4">
                                        <div class="portfolio-item">
                                            <div class="item-inner">
                                                <img class="img-responsive" src="images/portfolio/recent/item1.png" alt="">
                                                <h5>
                                                    Nova - Corporate site template
                                                </h5>
                                                <div class="overlay">
                                                    <a class="preview btn btn-danger" title="Malesuada fames ac turpis egestas" href="images/portfolio/full/item1.jpg" rel="prettyPhoto"><i class="icon-eye-open"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>                            
                                    <div class="col-xs-4">
                                        <div class="portfolio-item">
                                            <div class="item-inner">
                                                <img class="img-responsive" src="images/portfolio/recent/item3.png" alt="">
                                                <h5>
                                                    Fornax - Apps site template
                                                </h5>
                                                <div class="overlay">
                                                    <a class="preview btn btn-danger" title="Malesuada fames ac turpis egestas" href="images/portfolio/full/item1.jpg" rel="prettyPhoto"><i class="icon-eye-open"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div> 
									--->
                                </div>
                            </div><!--/.item-->
                        </div>
                    </div>
                </div>
				
    	<div class="col-md-12">--->
				
				
            </div><!--/.row-->
        </div>
    </section><!--/#recent-works-->
	
	<cfinclude template="includes/inc_footer.cfm">
	
	<!--- 
    <section id="testimonial" class="alizarin">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="center">
                        <h2>What our clients say</h2>
                        <p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p>
                    </div>
                    <div class="gap"></div>
                    <div class="row">
                        <div class="col-md-6">
                            <blockquote>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.</p>
                                <small>Someone famous in <cite title="Source Title">Source Title</cite></small>
                            </blockquote>
                            <blockquote>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.</p>
                                <small>Someone famous in <cite title="Source Title">Source Title</cite></small>
                            </blockquote>
                        </div>
                        <div class="col-md-6">
                            <blockquote>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.</p>
                                <small>Someone famous in <cite title="Source Title">Source Title</cite></small>
                            </blockquote>
                            <blockquote>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.</p>
                                <small>Someone famous in <cite title="Source Title">Source Title</cite></small>
                            </blockquote>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section><!--/#testimonial--> 
	--->

    