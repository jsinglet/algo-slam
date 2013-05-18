<g:if test="${didRun.size()==0}">
                <div class="alert alert-info" align="center" style="margin: 20px 20px 20px 20px">
                    No history available. You might be the first person to visit this site.
                </div>
            </g:if>

            <g:else>

                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Hacker</th>
                        <th></th>
                        <th>Challenge</th>
                        <th style="vertical-align: middle; text-align: center">Compile?</th>
                        <th style="vertical-align: middle; text-align: center">Run?</th>
                        <th style="vertical-align: middle; text-align: center">Passed Tests?</th>
                        <th style="vertical-align: middle; text-align: center">Avg Runtime (ms)</th>
                        <th style="vertical-align: middle; text-align: center">Avg Memory (kb)</th>

                        <th>Submitted</th>
                    </tr>
                    </thead>

                    <tbody>

                    <!-- table for this challenge -->
                    <g:each in="${didRun}">

                        <tr>
                            <td width="40" valign="middle" style="vertical-align: middle;">

                                <img src="${gravitar(email: it.email, size: 40)}" border="0">
                            </td>
                            <td valign="middle" style="vertical-align: middle;">${it.name}</td>
                            <td style="vertical-align: middle;">${it.challenge.name}</td>


                            <g:if test="${it.compiled}">
                                <td style="vertical-align: middle; text-align: center" align="center"><span class="label label-success">Yes</span></td>

                            </g:if>
                            <g:else>
                                <td style="vertical-align: middle; text-align: center"  align="center"><span class="label label-important">Failed</span>
                                </td>

                            </g:else>

                            <g:if test="${it.ranCorrectly}">
                                <td style="vertical-align: middle; text-align: center"  align="center"><span class="label label-success">Yes</span></td>

                            </g:if>
                            <g:else>
                                <td style="vertical-align: middle; text-align: center"  align="center"><span class="label label-important">Failed</span>
                                </td>

                            </g:else>



                            <g:if test="${it.passedCases}">
                                <td style="vertical-align: middle; text-align: center"  align="center"><span class="label label-success">Yes</span></td>

                            </g:if>
                            <g:else>
                                <td style="vertical-align: middle; text-align: center"  align="center"><span class="label label-important">Failed</span>
                                </td>

                            </g:else>


                            <g:if test="${it.passedCases}">
                                <td style="vertical-align: middle; text-align: center"  align="center"><strong><g:formatNumber number="${it.avgRuntime}" format="###,##0" /> ms</strong></td>

                            </g:if>
                            <g:else>
                                <td style="vertical-align: middle; text-align: center"  align="center"><span class="icon-remove">&nbsp;</span></td>

                            </g:else>


                            <g:if test="${it.passedCases}">
                                <td style="vertical-align: middle; text-align: center"  align="center"><strong><g:formatNumber number="${it.avgMemoryUsed}" format="###,##0" /> kb</strong></td>

                            </g:if>
                            <g:else>
                                <td style="vertical-align: middle; text-align: center"  align="center"><span class="icon-remove">&nbsp;</span></td>

                            </g:else>





                            <td style="vertical-align: middle;"><g:secondsAgo date="${it.created}"/></td>

                        </tr>

                    </g:each>

                    </tbody>

                </table>
            </g:else>