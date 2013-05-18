<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>AlgoSlam - Because You Can</title>
    <meta name="layout" content="main"/>
</head>

<body>

<!-- Main hero unit for a primary marketing message or call to action -->
<div class="hero-unit">
    <h1>${taunt}</h1>

    <p>Think you've got the fastest code in the west? AlgoSlam can help you prove it.</p>

    <p><a class="btn btn-success btn-large" data-toggle="modal" href="#uploadForm"><i
            class="icon-circle-arrow-up icon-white"></i> Upload Your Program
    </a> or <a href="${createLink(controller: "home", action: "rules")}">Learn More &raquo;</a>
    </p>
</div>

<!-- Example row of columns -->
<div class="row">
    <div class="span12">
        <g:include action="rankings"/>
    </div>

    <div class="span12" id="queueContainer">
        <g:include action="queue"/>
    </div>

</div>







<script type="text/javascript">
    //update the queue every 2 seconds
  /*  (function worker() {
        jQuery.ajax({
            url: '${createLink(action:'queue')}',
            success: function(data) {
                jQuery('#queueContainer').html(data);
            },
            complete: function() {
                setTimeout(worker, 2000);
            }
        })})();*/
</script>

</body>
</html>