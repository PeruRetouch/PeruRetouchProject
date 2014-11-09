<%-- 
    Document   : orderDetail
    Created on : 19/09/2014, 10:43:43 AM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.web.util.UtilWeb"%>
<%@page import="java.util.List"%>
<%@page import="pe.com.peruretouch.entity.Product"%>
<%@page import="pe.com.peruretouch.business.ProductBusiness"%>
<%@page import="pe.com.peruretouch.business.base.OperacionEnum"%>
<%@page import="pe.com.peruretouch.entity.Orden"%>
<%@page import="pe.com.peruretouch.business.OrdenBusiness"%>
<%@page import="pe.com.peruretouch.web.bean.PhotosBean"%>
<%@page import="pe.com.peruretouch.web.bean.UserBean"%>
<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    if (session.getAttribute(ConstantesWeb.USER_HOME) == null) {
        response.sendRedirect("../index.jsp");
    } else if (request.getParameter("order") == null) {
        response.sendRedirect("homeClient.jsp");
    } else {
        UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
        if (userBean.getPrivilege().equalsIgnoreCase("artist")) {
            response.sendRedirect("../artist/homeArtist.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("supervisor")) {
            response.sendRedirect("../supervior/homeSupervisor.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("manager")) {
            response.sendRedirect("../manager/homeManager.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("sa")) {
            response.sendRedirect("../sa/homeSa.jsp");
        } else {
            PhotosBean photosBean = new PhotosBean();
            photosBean.removeAllPhotosFromTheList(session, getServletContext().getRealPath("/") + ConstantesWeb.FILE_SAVE_PATH_CLIENT);
            Integer idOrder = Integer.parseInt(request.getParameter("order"));
            OrdenBusiness ordenBusiness = OrdenBusiness.obtenerEntidad();
            Orden orden = new Orden();
            orden.setIdOrder(idOrder);
            orden = ordenBusiness.ejecutar(OperacionEnum.OBTENER, orden);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - Order Details</title>
        <link rel="icon" type="image/png" href="../images/iconoPR.jpg" />
        <meta name="author" content="Roy Taza Rojas">
        <link href="../css/styles.css" rel="stylesheet" type="text/css" media="screen" />
    </head>
    <body>
        <div id="bg1">
            <div id="content">
                <!-- header -->
                <%@include file="../template/header.jsp" %>
                <!-- / header -->
                <!-- content -->
                <br><br><br><br>
                <div id="main1">
                    <br>
                    <div id="viewOrder">
                        <h1>Order Details</h1>
                        <br>
                        <h2>ID: # <%= orden.getIdOrder()%></h2>
                        <%
                            if (request.getParameter("n") != null) {
                        %>
                        <p><b>Product:</b> <%= request.getParameter("n")%></p>
                        <%
                            }
                        %>
                        <p><b>Order's specifications:</b> <%= orden.getSpecifications()%></p>
                        <p><b>Number of Photos:</b> <%= ordenBusiness.orderNumberOfPhotos(orden.getIdOrder())%></p>
                        <p><b>Number of References:</b> <%= ordenBusiness.orderNumberOfReferences(orden.getIdOrder())%></p>
                        <p><b>Date:</b> <%= UtilWeb.convertirDate(orden.getDateTimeClientRequest(), "MM/dd/yyyy HH:mm:ss")%></p>
                        <p><b>Total: <%= orden.getTotal()%></b></p>                                
                        <br>
                        <br>
                        <a href="homeClient.jsp">Go Home</a>
                        <!-- / content -->
                        <!-- footer -->
                    </div>
                    <br><br><br>
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
