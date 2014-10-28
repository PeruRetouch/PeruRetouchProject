<%-- 
    Document   : errorArtist
    Created on : 26/09/2014, 11:12:54 AM
    Author     : Roy Taza Rojas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Artist</title>
        <link rel="icon" type="image/png" href="images/iconoPR.jpg" />
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