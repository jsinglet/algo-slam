<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>AlgoSlam - Login</title>
    <meta name="layout" content="main"/>
</head>

<body>

<!-- Example row of columns -->
<div class="row">
    <div class="span12">
        <h1>Admin Login</h1>
        <br>


        <g:if test="${flash?.error}">
            <div class="alert alert-error">
                <strong>Failure!</strong> ${flash.error}
            </div>
        </g:if>


        <g:form action="doLogin" class="well">

            <label>Email</label>
            <input type="text" class="span3" placeholder="someuser@email.com" name="login">
            <label>Password</label>
            <input type="password" name="password" class="span3">  <br>

            <button type="submit" class="btn">Submit</button>

        </g:form>

    </div>

</div>

</body>
</html>