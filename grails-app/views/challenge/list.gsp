
<%@ page import="algoslam.Challenge" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'challenge.label', default: 'Challenge')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'challenge.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'challenge.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'challenge.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="open" title="${message(code: 'challenge.open.label', default: 'Open')}" />
                        
                            <g:sortableColumn property="close" title="${message(code: 'challenge.close.label', default: 'Close')}" />
                        
                            <g:sortableColumn property="testCaseFileName" title="${message(code: 'challenge.testCaseFileName.label', default: 'Test Case File Name')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${challengeInstanceList}" status="i" var="challengeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${challengeInstance.id}">${fieldValue(bean: challengeInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: challengeInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: challengeInstance, field: "description")}</td>
                        
                            <td><g:formatDate date="${challengeInstance.open}" /></td>
                        
                            <td><g:formatDate date="${challengeInstance.close}" /></td>
                        
                            <td>${fieldValue(bean: challengeInstance, field: "testCaseFileName")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${challengeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
