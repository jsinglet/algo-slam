




<g:if test="${submissions?.size()==0}">
    <div class="alert alert-info" align="center" style="margin: 20px 20px 20px 20px">
        No submissions yet! Why don't you be the first?
    </div>
</g:if>

<g:else>
<table class="table table-striped">
    <thead>
    <tr>
        <th>Place</th>

        <th>Hacker</th>
        <th></th>
        <th style="vertical-align: middle; text-align: center">Compile?</th>
        <th style="vertical-align: middle; text-align: center">Run?</th>
        <th style="vertical-align: middle; text-align: center">Passed Tests?</th>
        <th style="vertical-align: middle; text-align: center">Avg Runtime (ms)</th>
        <th style="vertical-align: middle; text-align: center">Avg Memory (kb)</th>
        <th style="vertical-align: middle; text-align: center">Source</th>


        <th>Submitted</th>
    </tr>
    </thead>

    <tbody>

    <!-- table for this challenge -->
    <g:each in="${submissions}" var="s" status="idx">

        <g:if test="${s.graded}">

            <tr>

                <td style="vertical-align: middle; text-align: center" align="center">
                    ${idx + 1}</td>



                <td width="40" valign="middle" style="vertical-align: middle;">

                    <img src="${gravitar(email: s.email, size: 40)}" border="0">
                </td>
                <td valign="middle" style="vertical-align: middle;">${s.name}</td>


                <g:if test="${s.compiled}">
                    <td style="vertical-align: middle; text-align: center" align="center"><span
                            class="label label-success">Yes</span></td>

                </g:if>
                <g:else>
                    <td style="vertical-align: middle; text-align: center" align="center"><span
                            class="label label-important">Failed</span>
                    </td>

                </g:else>

                <g:if test="${s.ranCorrectly}">
                    <td style="vertical-align: middle; text-align: center" align="center"><span
                            class="label label-success">Yes</span></td>

                </g:if>
                <g:else>
                    <td style="vertical-align: middle; text-align: center" align="center"><span
                            class="label label-important">Failed</span>
                    </td>

                </g:else>



                <g:if test="${s.passedCases}">
                    <td style="vertical-align: middle; text-align: center" align="center"><span
                            class="label label-success">Yes</span></td>

                </g:if>
                <g:else>
                    <td style="vertical-align: middle; text-align: center" align="center"><span
                            class="label label-important">Failed</span>
                    </td>

                </g:else>


                <g:if test="${s.passedCases}">
                    <td style="vertical-align: middle; text-align: center"
                        align="center"><strong><g:formatNumber number="${s.avgRuntime}"
                                                               format="###,##0"/> ms</strong></td>

                </g:if>
                <g:else>
                    <td style="vertical-align: middle; text-align: center" align="center"><span
                            class="icon-remove">&nbsp;</span></td>

                </g:else>


                <g:if test="${s.passedCases}">
                    <td style="vertical-align: middle; text-align: center"
                        align="center"><strong><g:formatNumber number="${s.avgMemoryUsed}"
                                                               format="###,##0"/> kb</strong></td>

                </g:if>
                <g:else>
                    <td style="vertical-align: middle; text-align: center" align="center"><span
                            class="icon-remove">&nbsp;</span></td>

                </g:else>



                <td style="vertical-align: middle; text-align:center">

                    <g:if test="${challengeClose.getTime() < new Date().getTime()}">
                        <a data-toggle="modal" href="#viewSource"
                                                                             class="btn"
                                                                             onclick="loadSource(${s.id})">
                        View Source
                    </a>

                    </g:if>

                    <g:else>


                        <a data-toggle="modal" href="#" onclick="return false;" class="btn disabled">
                        View Source
                    </a>


                    </g:else>

                </td>
                <td style="vertical-align: middle;"><g:secondsAgo date="${s.created}"/></td>

            </tr>
        </g:if>

    </g:each>

    </tbody>

</table>





</g:else>


<div align="right" style="margin-bottom: 10px;">

   <i class="icon-time"></i> Challenge Closes: <g:formatDate format="MM/dd/yyyy @ HH:mm:ss" date="${challengeClose}"/>

</div>