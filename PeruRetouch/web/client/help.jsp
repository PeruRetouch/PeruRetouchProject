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
        <link rel="icon" type="image/png" href="images/iconoPR.jpg" />
        <link href="../css/styles.css" rel="stylesheet" type="text/css" media="screen" />
    </head>
    <body>
        <div id="bg1">
            <div id="content">
                <!-- header -->
                <div id="header" style="height: auto">
                    <!--img id="logoPeruRetouch" src="images/logoPeruRetouch.jpg" alt="logoPeruRetouch"-->
                    <script language="javascript">AC_FL_RunContent = 0;</script>
                    <script src="../js/AC_RunActiveContent.js"></script>
                    <%@include file="../template/logo.jsp" %>
                    <div id="contenedorLogout">
                        Welcome <%= userBean.getName()%> <%= userBean.getLastName()%>&nbsp;&nbsp;<a href="../Controller?action=<%= ConstantesWeb.LOGOUT%>"><div id="btnLogout"></div></a>
                    </div>
                    <%@include file="../template/menu.jsp" %>
                </div>
                <br><br><br><br>
                <!-- content -->
                <div style="margin-left: 310px">
                    <div id="main">
                        Under construction.
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