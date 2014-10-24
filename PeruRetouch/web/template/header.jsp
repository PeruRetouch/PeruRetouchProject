<%-- 
    Document   : header
    Created on : 17/09/2014, 08:41:05 AM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.web.bean.UserBean"%>
<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    UserBean userInfo = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
    if (userInfo != null) {
%>
<link href="../css/styles.css" rel="stylesheet" type="text/css" media="screen" />
<div id="header" style="height: auto">
    <img id="logoPeruRetouch" src="../images/logoPeruRetouch.jpg" alt="logoPeruRetouch" >
    <br><br><br>
    <%@include file="../template/header.jsp" %> 
</div>
<br>
<div class="contenedorLogout" style="float: right;">
    Bienvenido <%= userInfo.getName()%> <%= userInfo.getLastName()%> <a href="../Controller?action=<%= ConstantesWeb.LOGOUT%>"><img id="btnLogoutx" src="../images/logoutHover.png" alt="Logout" /></a>
</div>
<%
}
%>
