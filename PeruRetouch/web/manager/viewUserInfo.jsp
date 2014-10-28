<%-- 
    Document   : viewUserInfo
    Created on : 01/10/2014, 11:26:44 AM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.business.base.OperacionEnum"%>
<%@page import="pe.com.peruretouch.entity.User"%>
<%@page import="pe.com.peruretouch.business.UserBusiness"%>
<%@page import="pe.com.peruretouch.web.bean.PhotosBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    if (session.getAttribute(ConstantesWeb.USER_HOME) == null) {
        response.sendRedirect("../index.jsp");
    } else {
        UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
        if (userBean.getPrivilege().equalsIgnoreCase("client")) {
            response.sendRedirect("../client/homeClient.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("supervisor")) {
            response.sendRedirect("../supervisor/homeSupervisor.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("artist")) {
            response.sendRedirect("../manager/homeArtist.jsp");
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
        <title>Peru Retouch - View User Info</title>
        <link rel="icon" type="image/png" href="images/iconoPR.jpg" />
        <meta name="author" content="Roy Taza Rojas">
        <link href="../css/styles.css" rel="stylesheet" type="text/css" media="screen" />
    </head>
    <body>
        <div id="bg1">
            <div id="content">
                <!-- header -->
                <div id="header" style="height: auto">
                    <img id="logoPeruRetouch" src="../images/logoPeruRetouch.jpg" alt="logoPeruRetouch">
                    <div id="contenedorLogout">
                        Bienvenido <%= userBean.getName()%> <%= userBean.getLastName()%>&nbsp;&nbsp;<a href="../Controller?action=<%= ConstantesWeb.LOGOUT%>"><div id="btnLogout"></div></a>
                    </div>
                    <%@include file="../template/menu.jsp" %>
                </div>
                <br><br><br>
                <!-- content -->
                <div style="margin-left: 310px">
                    <div id="main">
                        <div id="main_bot">
                            <div id="left">
                                <div id="log">
                                    <h3>User Info</h3>
                                    <fieldset>
                                        <!--input type="hidden" name="action" value="" /-->
                                        <!--label for="text1">Username</label><br /><label for="text1">UserName</label><br /-->
                                        <!--label for="text1">Repeat Password (*)</label><br /><input id="text1" type="text" name="txtPasswordRepeat" value="" required /><br /-->
                                        <%
                                            if (!message.equalsIgnoreCase("")) {
                                        %>
                                        <label for="message" style="color: green"><%= message%></label><br /><br />
                                        <%
                                            }
                                        %>
                                        <label for="text1">Name</label><br /><label for="text1" style="color: black"><%= user.getName()%></label><br /><br />
                                        <label for="text1">Last Name</label><br /><label for="text1" style="color: black"><%= user.getLastName()%></label><br /><br />
                                        <label for="text1">Email</label><br /><label for="text1" style="color: black"><%= user.getEmail()%></label><br /><br />
                                        <label for="text1">Address</label><br /><label for="text1" style="color: black"><%= user.getAddress()%></label><br /><br />
                                        <label for="text1">Country</label><br /><label for="text1" style="color: black"><%= user.getCountry()%></label><br /><br />
                                        <label for="text1">Birthday</label><br /><label for="text1" style="color: black"><%= user.getBirthDay()%></label><br /><br />
                                        <label for="text1">Telephone</label><br /><label for="text1" style="color: black"><%= user.getTelephone()%></label><br /> <br />
                                        <label for="text1">Cellphone</label><br /><label for="text1" style="color: black"><%= user.getCellphone()%></label><br /> <br />
                                        <input type="button" id="btnEditInfo" value="Edit User Info" name="btnEditInfo" style="margin-left: 105px" onclick="location.href = 'editUserInfo.jsp';"/><br />
                                        <input type="button" id="btnChangePassword" value="Change Password" name="btnChangePassword" style="margin-left: 90px" onclick="location.href = 'changePassword.jsp';"/>
                                    </fieldset>

                                    <!-- / content -->
                                    <!-- footer -->
                                </div>
                            </div>
                        </div>
                    </div>
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