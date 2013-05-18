
<%@ page import="algoslam.Challenge" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'challenge.label', default: 'Challenge')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${challengeInstance}">
            <div class="errors">
                <g:renderErrors bean="${challengeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${challengeInstance?.id}" />
                <g:hiddenField name="version" value="${challengeInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="challenge.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challengeInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${challengeInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="challenge.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challengeInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${challengeInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="open"><g:message code="challenge.open.label" default="Open" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challengeInstance, field: 'open', 'errors')}">
                                    <g:datePicker name="open" precision="day" value="${challengeInstance?.open}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="close"><g:message code="challenge.close.label" default="Close" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challengeInstance, field: 'close', 'errors')}">
                                    <g:datePicker name="close" precision="day" value="${challengeInstance?.close}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="testCaseFileName"><g:message code="challenge.testCaseFileName.label" default="Test Case File Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challengeInstance, field: 'testCaseFileName', 'errors')}">
                                    <g:textField name="testCaseFileName" value="${challengeInstance?.testCaseFileName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="submissions"><g:message code="challenge.submissions.label" default="Submissions" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challengeInstance, field: 'submissions', 'errors')}">
                                    
<ul>
<g:each in="${challengeInstance?.submissions?}" var="s">
    <li><g:link controller="submission" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="submission" action="create" params="['challenge.id': challengeInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'submission.label', default: 'Submission')])}</g:link>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="testCase"><g:message code="challenge.testCase.label" default="Test Case" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: challengeInstance, field: 'testCase', 'errors')}">
                                    <g:textField name="testCase" value="${challengeInstance?.testCase}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
