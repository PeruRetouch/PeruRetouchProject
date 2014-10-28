<%-- 
    Document   : error
    Created on : 01/10/2014, 09:46:31 AM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String message = "";
    if (request.getParameter(ConstantesWeb.MESSAGE) != null) {
        message = request.getParameter(ConstantesWeb.MESSAGE).toString();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="icon" type="image/png" href="images/iconoPR.jpg" />
    </head>
    <body>
        <h1>Error page</h1>
        <p><%= message %></p>
    </body>
</html>
