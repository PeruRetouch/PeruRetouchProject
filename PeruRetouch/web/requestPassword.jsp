<%-- 
    Document   : requestPassword
    Created on : 11/10/2014, 11:04:59 AM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    
    boolean showPage = false;
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
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - Request Password</title>
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
                <%@include file="template/header.jsp" %>
                <!-- / header -->
                <!-- content -->
                <br><br><br><br><br><br>
                <div id="main1">
                    <p style="font-family:Arial, Helvetica, sans-serif;text-align: center;margin-left: 20px;margin-right: 20px;font-size:16px;color: #008ae8">
                        <b>PERU RETOUCH</b>
                    </p><br>
                    <p style="font-family:Arial, Helvetica, sans-serif;text-align: center;margin-left: 20px;margin-right: 20px;font-size:16px">
                        <%
                            if (request.getParameter("type") != null) {
                                if (request.getParameter("message") != null) {
                                    String mensaje = request.getParameter("message");
                                    String type = request.getParameter("type");
                                    if (type.equalsIgnoreCase("1")) {
                        %>
                        <label for="text1" style="color: green"><%= mensaje%></label><br /><br />
                        <%
                        } else if (type.equalsIgnoreCase("2")) {
                        %>
                        <label for="text1" style="color: red"><%= mensaje%></label><br />
                        <%
                                    }
                                }
                            }
                        %>
                    </p>
                    <br>
                    <div style="margin-left: 335px">
                        <div id="main">
                            <div id="main_bot">
                                <div id="left">
                                    <div id="log">
                                        <h3>Forgot my password</h3>
                                        <form id="formForgotPassword" method="post" action="Controller">
                                            <fieldset>
                                                <input type="hidden" name="action" value="<%= ConstantesWeb.FORGOT_PASSWORD%>" />
                                                <p style="margin-left: 5px;color: #0f3d85">Put your username. The password will be send to your email.</p>
                                                <p></p>
                                                <label for="text1">Username</label><br /><input id="text1" type="text" name="txtUsername" value="" maxlength="50" required /><br />
                                                <input type="submit" value="Send" name="btnSend" align="center"/>
                                            </fieldset>
                                        </form>
                                    </div>
                                    <br>
                                    <div id="log">
                                        <h3>Forgot my username</h3>
                                        <form id="formForgotUsername" method="post" action="Controller">
                                            <fieldset>
                                                <input type="hidden" name="action" value="<%= ConstantesWeb.FORGOT_USERNAME%>" />
                                                <p style="margin-left: 5px;color: #0f3d85">Put your email. Your username will be send to your email.</p>
                                                <p></p>
                                                <label for="text1">Email</label><br /><input id="text1" type="email" name="txtEmail" value="" maxlength="50" required /><br />
                                                <input type="submit" value="Send" name="btnSend" align="center"/>
                                            </fieldset>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>
                    </div>
                </div>
                <%@include file="template/footer.jsp" %>
            </div>
        </div>
    </body>
</html>
<%
    }
%>