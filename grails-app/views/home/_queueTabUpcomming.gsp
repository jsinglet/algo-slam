<g:if test="${toRun.size()==0}">
    <div class="alert alert-info" align="center" style="margin: 20px 20px 20px 20px">
        Nothing is pending in the queue. Why not submit something?
    </div>
</g:if>

<g:else>

    <table class="table table-striped" border="0">
        <thead>
        <tr>
            <th>Hacker</th>
            <th></th>

            <th>Challenge</th>
            <th>Submitted</th>
        </tr>
        </thead>

        <tbody>

        <!-- table for this challenge -->
        <g:each in="${toRun}">

            <tr>
                <td width="40" valign="middle" style="vertical-align: middle;">

                    <img src="${gravitar(email: it.email, size: 40)}" border="0">
                </td>
                <td valign="middle" style="vertical-align: middle;">${it.name}</td>
                <td style="vertical-align: middle;">${it.challenge.name}</td>
                <td style="vertical-align: middle;"><g:secondsAgo date="${it.created}"/></td>

            </tr>

        </g:each>

        </tbody>

    </table>

</g:else>