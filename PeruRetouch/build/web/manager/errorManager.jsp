<%-- 
    Document   : errorManager
    Created on : 20/10/2014, 07:12:39 PM
    Author     : Roy Taza Rojas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Manager</title>
    </head>
    <body>
        <a href="errorArtist.jsp">Error Detectec, Go Home!</a>
        <%
            if (request.getParameter("message") != null) {
                String message = request.getParameter("message");
        %>
        <h2><%=message%></h2>
        <%
            }
        %>
    </body>
</html>