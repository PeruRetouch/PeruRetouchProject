<%-- 
    Document   : help
    Created on : 11/10/2014, 03:30:27 PM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.entity.User"%>
<%@page import="pe.com.peruretouch.business.UserBusiness"%>
<%@page import="pe.com.peruretouch.web.bean.PhotosBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    if (session.getAttribute(ConstantesWeb.USER_HOME) == null) {
        response.sendRedirect("../index.jsp");
    } else {
        UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
        if (userBean.getPrivilege().equalsIgnoreCase("artist")) {
            response.sendRedirect("../artist/homeArtist.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("supervisor")) {
            response.sendRedirect("../supervisor/homeSupervisor.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("manager")) {
            response.sendRedirect("../manager/homeManager.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("sa")) {
            response.sendRedirect("../sa/homeSa.jsp");
        } else {
            PhotosBean photosBean = new PhotosBean();
            photosBean.removeAllPhotosFromTheList(session, getServletContext().getRealPath("/") + ConstantesWeb.FILE_SAVE_PATH_CLIENT);
            UserBusiness userBusiness = UserBusiness.obtenerEntidad();
            User user = userBusiness.getUserIfExist(userBean.getUserName());
            String message = "";
            if (request.getParameter(ConstantesWeb.MESSAGE) != null) {
                message = request.getParameter(ConstantesWeb.MESSAGE);
            }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - Help</title>
        <meta name="author" content="Roy Taza Rojas">
        <link rel="icon" type="image/png" href="../images/iconoPR.jpg" />
        <link href="../css/styles.css" rel="stylesheet" type="text/css" media="screen" />
    </head>
    <body>
        <div id="bg1">
            <div id="content">
                <!-- header -->
                <%@include file="../template/header.jsp" %>
                <br><br><br><br>
                <p style="font-family:Arial, Helvetica, sans-serif;text-align: center;margin-left: 20px;margin-right: 20px;font-size:15px;color: #0f3d85">
                    If you have some request or need some help, please send us a message.<br>
                    We are glad to help you.<br>
                </p>
                <p style="font-family:Arial, Helvetica, sans-serif;text-align: center;margin-left: 20px;margin-right: 20px;font-size:16px;color: #008ae8">
                    <b>PERU RETOUCH</b>
                </p>
                <!-- content -->
                <div style="margin-left: 335px;min-height: 300px">
                    <div id="main">
                        <div id="main_bot">
                            <div id="left">
                                <div id="log">

                                    <h3>Contact US</h3>
                                    <form id="formLogin" method="post" action="../Controller">
                                        <fieldset>
                                            <input type="hidden" name="action" value="<%= ConstantesWeb.HELP_CLIENT_SEND_EMAIL%>" />
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
                                            <label for="text1">Subject (*)</label><br /><input id="text2" type="text" name="txtSubject" value="" maxlength="50" required/><br />
                                            <label for="text1">Message (*)</label><br /><textarea name="txtMessage" rows="5" cols="38" required></textarea><br />
                                            <h5 align="right">(*)Required fields</h5><br>
                                            <input type="submit" value="Send" name="btnSend" align="center"/>
                                        </fieldset>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div align="center">
                    <label style="font-family:Arial, Helvetica, sans-serif;text-align: center;margin-left: 20px;margin-right: 20px;font-size:15px;color: #0f3d85">See a video to get reference</label><br>
                    <iframe width="300" height="190" src="//www.youtube.com/embed/qfkv-ZegXoA" frameborder="1" allowfullscreen></iframe>
                </div>
                <br>
                <%@include file="../template/footer.jsp" %>
            </div>
        </div>
    </body>
</html>
<%
        }
    }
%>