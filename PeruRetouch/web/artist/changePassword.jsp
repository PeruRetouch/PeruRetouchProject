<%-- 
    Document   : changePassword
    Created on : 03/10/2014, 09:27:32 AM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.entity.User"%>
<%@page import="pe.com.peruretouch.business.UserBusiness"%>
<%@page import="pe.com.peruretouch.web.bean.PhotosBean"%>
<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    if (session.getAttribute(ConstantesWeb.USER_HOME) == null) {
        response.sendRedirect("../index.jsp");
    } else {
        UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
        if (userBean.getPrivilege().equalsIgnoreCase("client")) {
            response.sendRedirect("../client/homeArtist.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("supervisor")) {
            response.sendRedirect("../supervisor/homeSupervisor.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("manager")) {
            response.sendRedirect("../manager/homeManager.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("sa")) {
            response.sendRedirect("../sa/homeSa.jsp");
        } else {
            //PhotosBean.removeAllPhotosFromTheList(session, getServletContext().getRealPath("/") + ConstantesWeb.FILE_SAVE_PATH_CLIENT);
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
        <title>Peru Retouch - Change Password</title>
        <link rel="icon" type="image/png" href="../images/iconoPR.jpg" />
        <meta name="author" content="Roy Taza Rojas">
        <link href="../css/styles.css" rel="stylesheet" type="text/css" media="screen" />
    </head>
    <body>
        <div id="bg1">
            <div id="content">
                <!-- header -->
                <%@include file="../template/header.jsp" %>
                <br><br><br><br><br><br>
                <!-- content -->
                <div style="margin-left: 310px">
                    <div id="main">
                        <div id="main_bot">
                            <div id="left">
                                <div id="log">
                                    <h3>Change Password</h3>
                                    <form id="formLogin" method="post" action="../Controller">
                                        <fieldset>
                                            <input type="hidden" name="action" value="<%= ConstantesWeb.CHANGE_PASSWORD%>" />
                                            <%
                                                if (!message.equalsIgnoreCase("")) {
                                            %>
                                            <label for="message" style="color: red"><%= message%></label><br /><br />
                                            <%
                                                }
                                            %>
                                            <label for="text1">Current Password</label><br /><input id="text1" type="password" name="txtCurrentPassword" value="" maxlength="50" required /><br />
                                            <label for="text1">New Password</label><br /><input id="text1" type="password" name="txtNewPassword" value="" maxlength="50" required /><br />
                                            <label for="text1">Repeat New Password</label><br /><input id="text1" type="password" name="txtRepeatNewPassword" value="" maxlength="50" required /><br />
                                            <input type="submit" value="Save Changes" name="btnSaveChanges" style="margin-left: 95px"/><br /><br />
                                        </fieldset>
                                    </form>
                                    <!-- / content -->
                                    <!-- footer -->
                                </div>
                            </div>
                        </div>
                    </div>
                    <br /><br /><br /><br /><br /><br />
                </div>
                <%@include file="../template/footer.jsp" %>
            </div>
        </div>
    </body>
</html>
<%
        }
    }
%>