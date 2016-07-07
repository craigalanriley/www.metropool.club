
<!--- Holding Page 
<cfif NOT isDefined("URL.peekaboo") AND NOT isDefined("session.peekaboo")>
	<cflocation url="poster.cfm" addtoken="no">
</cfif>--->

<cfparam name="thisPage" default="Home">

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>MetroPool.Club | <cfoutput>#thisPage#</cfoutput></title>
    <link href="<cfoutput>#Application.Home#</cfoutput>/css/bootstrap.min.css" rel="stylesheet">
    <link href="<cfoutput>#Application.Home#</cfoutput>/css/font-awesome.min.css" rel="stylesheet">
    <link href="<cfoutput>#Application.Home#</cfoutput>/css/prettyPhoto.css" rel="stylesheet">
    <link href="<cfoutput>#Application.Home#</cfoutput>/css/animate.css" rel="stylesheet">
    <link href="<cfoutput>#Application.Home#</cfoutput>/css/featherlight.min.css" rel="stylesheet">
    <link href="<cfoutput>#Application.Home#</cfoutput>/css/main.css" rel="stylesheet">
	<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">

    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->

    <link rel="shortcut icon" href="<cfoutput>#Application.Home#</cfoutput>/icons/favicon4.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="<cfoutput>#Application.Home#</cfoutput>/images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<cfoutput>#Application.Home#</cfoutput>/images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="<cfoutput>#Application.Home#</cfoutput>/images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="<cfoutput>#Application.Home#</cfoutput>/images/ico/apple-touch-icon-57-precomposed.png">
	
	<!--- Toggle Switch --->
	<link href="http://gitcdn.github.io/bootstrap-toggle/2.2.0/css/bootstrap2-toggle.min.css" rel="stylesheet">
	
    <script src="<cfoutput>#Application.Home#</cfoutput>/js/jquery.js"></script>
	
	<style type="text/css">
			@media all {
				.lightbox { display: none; }
				.fl-page h1,
				.fl-page h3,
				.fl-page h4 {
					font-family: 'HelveticaNeue-UltraLight', 'Helvetica Neue UltraLight', 'Helvetica Neue', Arial, Helvetica, sans-serif;
					font-weight: 100;
					letter-spacing: 1px;
				}
				.fl-page h1 { font-size: 110px; margin-bottom: 0.5em; }
				.fl-page h1 i { font-style: normal; color: #ddd; }
				.fl-page h1 span { font-size: 30px; color: #333;}
				.fl-page h3 { text-align: right; }
				.fl-page h3 { font-size: 15px; }
				.fl-page h4 { font-size: 2em; }
				.fl-page .jumbotron { margin-top: 2em; }
				.fl-page .doc { margin: 2em 0;}
				.fl-page .btn-download { float: right; }
				.fl-page .btn-default { vertical-align: bottom; }

				.fl-page .btn-lg span { font-size: 0.7em; }
				.fl-page .footer { margin-top: 3em; color: #aaa; font-size: 0.9em;}
				.fl-page .footer a { color: #999; text-decoration: none; margin-right: 0.75em;}
				.fl-page .github { margin: 2em 0; }
				.fl-page .github a { vertical-align: top; }
				.fl-page .marketing a { color: #999; }

				/* override default feather style... */
				.fixwidth {
					background: rgba(256,256,256, 0.8);
				}
				.fixwidth .featherlight-content {
					width: 500px;
					padding: 25px;
					color: #fff;
					background: #111;
				}
				.fixwidth .featherlight-close {
					color: #fff;
					background: #333;
				}

			}
			@media(max-width: 768px){
				.fl-page h1 span { display: block; }
				.fl-page .btn-download { float: none; margin-bottom: 1em; }
				}
		
			.featherlight {
				z-index: 1000000 !important;
				}
			
		</style>
	
</head><!--/head-->

<body>
    <header class="navbar navbar-inverse navbar-fixed-top" role="banner" style="background-color: black !important; min-height: 80px">
        <div class="container">
            <div class="navbar-header" style="margin: 15px -10px 0 0 !important">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <div class="collapse navbar-collapse" style="margin-bottom: 30px">
                <ul class="nav navbar-nav navbar-right" style="margin-top: 30px !important">
                    <li <cfif thisPage EQ "Home">class="active"</cfif>><a href="<cfoutput>#Application.Home#</cfoutput>">Home</a></li>
                    <!---  --->
                    <li <cfif thisPage EQ "My Metro">class="active"</cfif>><a href="<cfoutput>#Application.Home#</cfoutput>/mymetro/index.cfm">My Metro</a></li>
                    <li <cfif thisPage EQ "Grades &amp; Handicaps">class="active"</cfif>><a href="<cfoutput>#Application.Home#</cfoutput>/handicaps.cfm">Grades &amp; Handicaps</a></li>
                    <li <cfif thisPage EQ "Fixtures &amp; Results">class="active"</cfif>><a href="<cfoutput>#Application.Home#</cfoutput>/fixtures.cfm">Fixtures &amp; Results</a></li>
                    <li <cfif thisPage EQ "League Table">class="active"</cfif>><a href="<cfoutput>#Application.Home#</cfoutput>/leaguetable.cfm">League Tables</a></li>
                    <!---
                    <li <cfif thisPage EQ "Grand Finals">class="active"</cfif>><a href="<cfoutput>#Application.Home#</cfoutput>/grandfinals.cfm">Grand Finals</a></li>  ---> 
                    <!---  --->
                    <li <cfif thisPage EQ "Prizes">class="active"</cfif>><a href="<cfoutput>#Application.Home#</cfoutput>/prizes.cfm">Prizes</a></li>
                    <li <cfif thisPage EQ "FAQ">class="active"</cfif>><a href="<cfoutput>#Application.Home#</cfoutput>/faq.cfm">FAQ</a></li> 
                    <!---  
                    <li <cfif thisPage EQ "Contact Us">class="active"</cfif>><a href="contact.cfm">Contact Us</a></li>
					<li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Fixtures <i class="icon-angle-down"></i></a>
                        <ul class="dropdown-menu">
                            <li><a href="pricing.html">Format</a></li>
                            <li><a href="career.html">Fixtures</a></li>
                            <li><a href="blog-item.html">League Table</a></li>
                            <li><a href="pricing.html">Prizes</a></li>
                        </ul>
                    </li>
					--->
                </ul>
            </div>
        </div>
    </header><!--/header-->