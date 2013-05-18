<h1 id="rankingArea">Rankings <small>Find out where you stand</small></h1>

<p>Below you can find the ongoing rankings. Note that each week a program is turned in the rankings are locked. Feel free to submit a program up until the deadline!</p>

<div class="tabbable">

    <ul class="nav nav-tabs">

<!--        <li class="active">
            <a href="#">Overall Rankings</a>
        </li>-->

<g:each in="${challenges}" var="it" status="idx">
    <g:if test="${idx==0}">
        <li class="active"><a data-toggle="tab" href="#challenge_${it.id}">${it.name}</a> </li>

    </g:if>
    <g:else>
        <li><a data-toggle="tab" href="#challenge_${it.id}">${it.name}</a></li>

    </g:else>
</g:each>

</ul>




<div class="tab-content">
    <g:each in="${challenges}" var="challenge" status="idx">

        <g:if test="${idx==0}">
            <div id="challenge_${challenge.id}" class="tab-pane active">
        </g:if>

        <g:else>
            <div id="challenge_${challenge.id}" class="tab-pane">

        </g:else>

        <g:include action="challengeTab" params="['ajaxIn': challenge.id]"/>
        </div>

        <script type="text/javascript">

            (function rankingWorker${challenge.id}() {
                jQuery.ajax({
                    url: '${createLink(action:'challengeTab', params:['ajaxIn':challenge.id])}',
                    success: function(data) {
                        jQuery('#challenge_${challenge.id}').html(data);
                    },
                    complete: function() {
                        setTimeout(rankingWorker${challenge.id}, 20000);
                    }
                })
            })();

        </script>

    </g:each>

</div>

</div>


<script type="text/javascript">

    var loadSource = function(id) {
        //show indicator

        jQuery.ajax({
            url: '${createLink(action:'viewSource')}?s=' + id,
            success: function(data) {
                jQuery('#ajaxSourceForm').html(data);
            },
            complete: function() {
            }
        })


    }


</script>

<g:render template="sourceCode"/>