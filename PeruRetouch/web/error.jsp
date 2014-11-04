<%-- 
    Document   : error
    Created on : 01/10/2014, 09:46:31 AM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    boolean showPage = false;
    if (session.getAttribute(ConstantesWeb.USER_HOME) != null) {
        UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
        if (userBean.getPrivilege().equalsIgnoreCase("artist")) {
            response.sendRedirect("artist/homeArtist.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("supervisor")) {
            response.sendRedirect("supervisor/homeSupervisor.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("manager")) {
            response.sendRedirect("manager/homeManager.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("sa")) {
            response.sendRedirect("sa/homeSa.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("client")) {
            response.sendRedirect("client/homeClient.jsp");
        } else {
            showPage = true;
        }
    } else {
        showPage = true;
    }
    if (showPage) {
        String message = "";
        if (request.getParameter(ConstantesWeb.MESSAGE) != null) {
            message = request.getParameter(ConstantesWeb.MESSAGE).toString();
        }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch</title>
        <link rel="icon" type="image/png" href="images/iconoPR.jpg" />
        <meta name="description" content="Peru Retouch gives you a post-photography service">
        <meta name="keywords" content="retouch,peru,photo,photographer,retouch photo">
        <meta name="author" content="Roy Taza Rojas">
        <link href="css/styles.css" rel="stylesheet" type="text/css" media="screen" />
    </head>
    <body>
        <div id="bg1">
            <div id="content">
                <!-- header -->
                <div id="header" style="height: auto">
                    <!--img id="logoPeruRetouch" src="images/logoPeruRetouch.jpg" alt="logoPeruRetouch"-->
                    <script language="javascript">AC_FL_RunContent = 0;</script>
                    <script src="js/AC_RunActiveContent.js"></script>
                    <%@include file="template/logo.jsp" %>
                    <br><br><br>
                    <div id="menu">
                        <ul>
                            <li id="button1"><a href="index.jsp" title="">Home</a></li>
                            <li id="button2"><a href="pricesGalllery.jsp" title="">Prices & Gallery</a></li>
                            <li id="button4"><a href="about.jsp" title="">About</a></li>
                            <li id="button5"><a href="contact.jsp" title="">Contact</a></li>
                        </ul>
                    </div>
                </div>
                <!-- / header -->
                <!-- content -->
                <br><br><br><br><br><br>
                <div id="main1">
                    <div id="left1">
                        <h5>Error <img src="images/error.png" alt="X"></h5>
                        <br>
                        <div style="font-size: 15px;font-family: Arial, Helvetica, sans-serif;margin-left: 15px;margin-right: 15px;text-align: justify">
                            <p>
                                Copy the message and enter<a href="contact.jsp" target="_blank"> HERE </a>, put the subject <b>Error</b> and send us the message.
                            </p>
                            <p>
                                <b>Message: </b><br><%= message%>
                            </p>
                            <br><br>
                            <p style="text-align: center">
                                <a href="index.jsp">Home</a>
                            </p>
                        </div>
                    </div>     
                    <!-- / content -->
                    <!-- footer -->
                </div>
                <%@include file="template/footer.jsp" %>
            </div>
        </div>
    </body>
</html>
<%
    }
%>