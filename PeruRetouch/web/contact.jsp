<%-- 
    Document   : contact
    Created on : 16/09/2014, 10:37:00 AM
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
                <%@include file="template/header.jsp" %>
                <!-- / header -->
                <!-- content -->
                <br><br><br><br><br><br>
                <p style="font-family:Arial, Helvetica, sans-serif;text-align: center;margin-left: 20px;margin-right: 20px;font-size:15px;color: #0f3d85">
                    If you have some request or need some help, please send us a message. We are glad to help you.<br>
                    Please, make sure your email is correct. This is the way we'll contact you.<br>
                    Your information is private. It'll not be published.
                </p>
                <p style="font-family:Arial, Helvetica, sans-serif;text-align: center;margin-left: 20px;margin-right: 20px;font-size:16px;color: #008ae8">
                    <b>PERU RETOUCH</b>
                </p>
                <br>
                <div style="margin-left: 335px">
                    <div id="main">
                        <div id="main_bot">
                            <div id="left">
                                <div id="log">
                                    <h3>Contact US</h3>
                                    <form id="formLogin" method="post" action="Controller">
                                        <fieldset>
                                            <input type="hidden" name="action" value="<%= ConstantesWeb.CONTACT_US_SEND_EMAIL%>" />
                                            <%
                                                if (request.getParameter("message") != null) {
                                                    if (request.getParameter("message").contentEquals("sent")) {
                                            %>
                                            <label for="text1" style="color: green">Your message has been sent.</label><br />
                                            <label for="text1" style="color: green">We will contact you by your email.</label><br />
                                            <%
                                            } else {
                                            %>
                                            <label for="text1" style="color: red"><%= request.getParameter("message")%></label><br />
                                            <%
                                                    }
                                                }
                                            %>
                                            <label for="text1">Name (*)</label><br /><input id="text1" type="text" name="txtName" value="" maxlength="50" required /><br />
                                            <label for="text2">E-mail (*)</label><br /><input id="text2" type="email" name="txtEmail" value="" maxlength="50" required /><br />
                                            <label for="text2">Subject (*)</label><br /><input id="text2" type="text" name="txtSubject" value="" maxlength="50" required/><br />
                                            <label for="text1">Message (*)</label><br /><textarea style="border-color: #0e3c85;min-width: 100%" name="txtMessage" rows="5" cols="33" required></textarea><br />
                                            <h5 align="right">(*)Required fields</h5><br>
                                            <input type="image" style="margin-left: 102px" src="images/send.png" width="76" name="btnSend" alt="Send"/>
                                        </fieldset>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br>
                </div>
                <!-- / content -->
                <!-- footer -->
                <%@include file="template/footer.jsp" %>
            </div>
        </div>
        <!-- / footer -->
    </body>
</html>
<%
    }
%>