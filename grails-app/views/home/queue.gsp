<h1 style="margin-top:10px">Queue <small>Tired of waiting for your program to run? Check it out here.</small></h1>

<p>As per the rules of AlgoSlam, each program gets to run alone. Tired of waiting for your program to run? Check here to find out when yours runs! Note that only the most recent 50 runs are displayed in the history.</p>


<div class="tabbable">

    <ul class="nav nav-tabs" style="margin-bottom: 5px;">
        <li class="active">
            <a data-toggle="tab" href="#upcomming">Upcomming</a>
        </li>
        <li><a data-toggle="tab" href="#pastRuns">Past Runs</a></li>

    </ul>


    <div class="tab-content">

        <div id="upcomming" class="tab-pane active">

            <g:render template="queueTabUpcomming"/>

        </div>


        <div id="pastRuns" class="tab-pane">

            <g:render template="queueTabHistory"/>

        </div>

    </div>

</div>

<script type="text/javascript">


    (function upcommingWorker() {
        jQuery.ajax({
            url: '${createLink(action:'queue', params:['ajaxIn':'queueTabUpcomming'])}',
            success: function(data) {
                jQuery('#upcomming').html(data);
            },
            complete: function() {
                setTimeout(upcommingWorker, 10000);
            }
        })
    })();


    (function historyWorker() {
        jQuery.ajax({
            url: '${createLink(action:'queue', params:['ajaxIn':'queueTabHistory'])}',
            success: function(data) {
                jQuery('#pastRuns').html(data);
            },
            complete: function() {
                setTimeout(historyWorker, 10000);
            }
        })
    })();
</script>