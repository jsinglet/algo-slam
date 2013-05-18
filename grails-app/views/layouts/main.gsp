<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title><g:layoutTitle default="AlgoSlam - Because You Can"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
    body {
        padding-top: 60px;
        padding-bottom: 40px;
    }
    </style>
    <link href="/css/bootstrap-responsive.css" rel="stylesheet">

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="/ico/benchmark.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="/ico/apple-touch-icon-57-precomposed.png">


    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/js/jquery.js"></script>
    <script src="/js/jquery.form.js"></script>

    <script src="/js/bootstrap-transition.js"></script>
    <script src="/js/bootstrap-alert.js"></script>
    <script src="/js/bootstrap-modal.js"></script>
    <script src="/js/bootstrap-dropdown.js"></script>
    <script src="/js/bootstrap-scrollspy.js"></script>
    <script src="/js/bootstrap-tab.js"></script>
    <script src="/js/bootstrap-tooltip.js"></script>
    <script src="/js/bootstrap-popover.js"></script>
    <script src="/js/bootstrap-button.js"></script>
    <script src="/js/bootstrap-collapse.js"></script>
    <script src="/js/bootstrap-carousel.js"></script>
    <script src="/js/bootstrap-typeahead.js"></script>

    <link href="/js/google-code-prettify/prettify.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="/js/prettify.js"></script>

</head>

<body>

<div class="navbar navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container">
            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
            <a class="brand" href="${createLink(controller: "home", action: "index")}">AlgoSlam</a>

            <div class="nav-collapse">
                <ul class="nav">
                    <li class="${(controllerName == "home" && actionName == "index") ? "active" : ""}"><a
                            href="${createLink(controller: "home", action: "index")}">Home</a></li>
                    <li><a href="${createLink(controller: "home", action: "index")}#rankingArea">Rankings</a></li>
                    <li class="${(controllerName == "home" && actionName == "rules") ? "active" : ""}"><a href="${createLink(controller: "home", action: "rules")}">How it Works</a></li>

                </ul>
                <ul class="nav pull-right">
                    <li class="${(controllerName == "home" && actionName == "about") ? "active" : ""}"><a
                            href="${createLink(controller: "home", action: "about")}">About</a></li>
                    <li><a data-toggle="modal" href="#uploadForm">Upload</a></li>

                </ul>

            </div><!--/.nav-collapse -->
        </div>
    </div>
</div>

<div class="container">

    <g:layoutBody/>

    <hr>

    <footer>
        <p>Another John Singleton Joint. &copy 2012 &middot;  <a href="http://www.the-singleton.com"
                                                                 target="_blank">All About Me</a></p>
    </footer>

</div> <!-- /container -->



<g:include action="upload"/>

</body>
</html>
