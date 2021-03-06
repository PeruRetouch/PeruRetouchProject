<%-- 
    Document   : orders
    Created on : 19/09/2014, 11:47:01 AM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.web.util.UtilWeb"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="pe.com.peruretouch.business.base.OperacionEnum"%>
<%@page import="pe.com.peruretouch.entity.Orden"%>
<%@page import="pe.com.peruretouch.business.OrdenBusiness"%>
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
            OrdenBusiness ordenBusiness = OrdenBusiness.obtenerEntidad();
            List<Orden> listOrders = new ArrayList<Orden>();
            if (request.getParameter("from") != null) {
                if (request.getParameter("to") != null) {
                    listOrders = ordenBusiness.listOrdersBetweenDates(userBean.getIdUser(),
                            UtilWeb.convertirString(request.getParameter("from"), "yyyy-MM-dd"),
                            UtilWeb.convertirString(request.getParameter("to"), "yyyy-MM-dd"));
                } else {
                    listOrders = ordenBusiness.listOrdersByClient(userBean.getIdUser());
                }
            } else {
                listOrders = ordenBusiness.listOrdersByClient(userBean.getIdUser());
            }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - Orders</title>
        <link rel="icon" type="image/png" href="../images/iconoPR.jpg" />
        <meta name="author" content="Roy Taza Rojas">
        <link href="../css/styles.css" rel="stylesheet" type="text/css" media="screen" />

        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="//cdn.jsdelivr.net/webshim/1.14.5/polyfiller.js"></script>
        <script>
            webshims.setOptions('forms-ext', {types: 'date'});
            webshims.polyfill('forms forms-ext');
        </script>
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
                        <h1><%= userBean.getName()%>'s Orders</h1><br><br>
                        <form action="../Controller" method="post">
                            <input type="hidden" name="action" value="<%= ConstantesWeb.ORDERS_BETWEEN_DATES%>">
                            <p>From: <input type="date" name="dateFrom" value="" required>
                                &nbsp;&nbsp;&nbsp;&nbsp;To: <input type="date" name="dateTo" value="" required>
                                &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="btnSearch" value="Search"></p>
                        </form>
                        <br><br>
                        <%
                            if (listOrders.size() > 0) {
                                if (request.getParameter("abc") != null) {
                        %>
                        <h2>Orders from <%= request.getParameter("from")%> to <%= request.getParameter("to")%></h2>
                        <br>
                        <%
                        } else {
                        %>
                        <h2>All the orders.</h2>
                        <br>
                        <%
                            }
                            int i = 0;
                            for (Orden orden : listOrders) {
                                i++;
                        %>
                        <h2>ID: # <%= i%></h2>
                        <%
                            if (request.getParameter("n") != null) {
                        %>
                        <p><b>Product:</b> <%= request.getParameter("n")%></p>
                        <%
                            }
                        %>
                        <p><b>Order name:</b> <%= orden.getOrderName()%></p>
                        <p><b>Order's specifications:</b> <%= orden.getSpecifications()%></p>
                        <p><b>Number of Photos:</b> <%= ordenBusiness.orderNumberOfPhotos(orden.getIdOrder())%></p>
                        <p><b>Number of References:</b> <%= ordenBusiness.orderNumberOfReferences(orden.getIdOrder())%></p>
                        <p><b>Date:</b> <%= UtilWeb.convertirDate(orden.getDateTimeClientRequest(), "MMM/dd/yyyy HH:mm:ss")%></p>
                        <p><b>Total: <%= orden.getTotal()%></b></p>
                        <p><a href="orderPhotos.jsp?idOrder=<%= orden.getIdOrder()%>">View photos</a></p>
                        <br>
                        <br>
                        <%
                            }
                        } else {
                            if (request.getParameter("abc") != null) {
                                if (request.getParameter("abc").equalsIgnoreCase("alert")) {
                        %>
                        <br>
                        <h2>You don't have orders from <%= request.getParameter("from")%> to <%= request.getParameter("to")%></h2>
                        <p><a href="ordersClient.jsp">View all the orders</a></p>
                        <%
                            }
                        } else {
                        %>
                        <br>
                        <h2>You don't have orders.</h2>
                        <p><a href="chooseProduct.jsp">Upload Photos</a></p>
                        <%
                                }
                            }
                        %>
                        <br>
                        <!-- / content -->
                        <!-- footer -->
                    </div>
                    <br><br>
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