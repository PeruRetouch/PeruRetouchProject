<%-- 
    Document   : editUserInfo
    Created on : 17/09/2014, 08:40:54 AM
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
        } else if (userBean.getPrivilege().equalsIgnoreCase("artist")) {
            response.sendRedirect("../manager/homeArtist.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("sa")) {
            response.sendRedirect("../sa/homeSa.jsp");
        } else {
            //PhotosBean.removeAllPhotosFromTheList(session, getServletContext().getRealPath("/") + ConstantesWeb.FILE_SAVE_PATH_CLIENT);
            UserBusiness userBusiness = UserBusiness.obtenerEntidad();
            User user = userBusiness.getUserIfExist(userBean.getUserName());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - Edit user Info</title>
        <link rel="icon" type="image/png" href="../images/iconoPR.jpg" />
        <meta name="author" content="Roy Taza Rojas">
        <link href="../css/styles.css" rel="stylesheet" type="text/css" media="screen" />
    </head>
    <body>
        <div id="bg1">
            <div id="content">
                <!-- header -->
                <%@include file="../template/header.jsp" %>
                <br><br><br><br>
                <!-- content -->
                <div style="margin-left: 310px">
                    <div id="main">
                        <div id="main_bot">
                            <div id="left">
                                <div id="log">
                                    <h3>User Info</h3>
                                    <form id="formLogin" method="post" action="../Controller">
                                        <fieldset>
                                            <input type="hidden" name="action" value="<%= ConstantesWeb.EDIT_USER %>" />
                                            <input type="hidden" name="idUser" value="<%= userBean.getIdUser() %>" />
                                            <label for="text1">Name (*)</label><br /><input id="text1" type="text" name="txtName" value="<%= user.getName()%>" maxlength="50" required /><br />
                                            <label for="text1">Last Name (*)</label><br /><input id="text1" type="text" name="txtLastName" maxlength="50" value="<%= user.getLastName()%>" required /><br />
                                            <label for="text1">Email (*)</label><br /><input id="text1" type="text" name="txtEmail" value="<%= user.getEmail()%>" maxlength="50" required /><br />
                                            <label for="text1">Address</label><br /><input id="text1" type="text" name="txtAddress" maxlength="200" value="<%= user.getAddress()%>" /><br />
                                            <label for="text1">Country</label><br /><input id="text1" type="text" name="txtCountry" maxlength="50" value="<%= user.getCountry()%>" /><br />
                                            <!--label for="text1">Birthday</label><br /><input id="text1" type="date" name="txtBirthday" value="" /><br /-->
                                            <label for="text1">Telephone</label><br /><input id="text1" type="text" name="txtTelephone" maxlength="50" value="<%= user.getTelephone()%>" /><br /> 
                                            <label for="text1">Cellphone</label><br /><input id="text1" type="text" name="txtCellphone" maxlength="50" value="<%= user.getCellphone()%>" /><br /> 
                                            <h5 align="right">(*)Required fields</h5><br>
                                            <input type="submit" value="Save Changes" name="btnSaveChanges" align="center"/>
                                        </fieldset>
                                    </form>
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