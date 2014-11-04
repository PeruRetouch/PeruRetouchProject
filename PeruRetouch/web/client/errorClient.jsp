<%-- 
    Document   : errorClient
    Created on : 17/09/2014, 10:29:04 AM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.entity.User"%>
<%@page import="pe.com.peruretouch.business.UserBusiness"%>
<%@page import="pe.com.peruretouch.web.bean.PhotosBean"%>
<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
<%@page import="pe.com.peruretouch.web.bean.UserBean"%>
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
        <title>Error Client</title>
        <link rel="icon" type="image/png" href="../images/iconoPR.jpg" />
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
                <div id="main1">
                    <div id="left1">
                        <h5>Error <img src="../images/error.png" alt="X"></h5>
                        <br>
                        <div style="font-size: 15px;font-family: Arial, Helvetica, sans-serif;margin-left: 15px;margin-right: 15px;text-align: justify">
                            <p>
                                Copy the message and enter<a href="help.jsp" target="_blank"> HERE </a>, put the subject <b>Error</b> and send us the message.
                            </p>
                            <p>
                                <b>Message: </b><br><%= message%>
                            </p>
                            <br><br>
                            <p style="text-align: center">
                                <a href="homeClient.jsp">Go Home</a>
                            </p>
                        </div>
                    </div>
                    <!-- / content -->
                    <!-- footer -->
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