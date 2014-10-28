<%-- 
    Document   : errorClient
    Created on : 17/09/2014, 10:29:04 AM
    Author     : Roy Taza Rojas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Client</title>
        <link rel="icon" type="image/png" href="images/iconoPR.jpg" />
    </head>
    <body>
        <a href="homeClient.jsp">Error Detectec, Go Home!</a>
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
