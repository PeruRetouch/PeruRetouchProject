<%-- 
    Document   : getOrder
    Created on : 23/09/2014, 11:32:18 AM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.entity.Product"%>
<%@page import="pe.com.peruretouch.business.ProductBusiness"%>
<%@page import="pe.com.peruretouch.entity.Orden"%>
<%@page import="java.util.List"%>
<%@page import="pe.com.peruretouch.entity.Retouch"%>
<%@page import="pe.com.peruretouch.business.RetouchBusiness"%>
<%@page import="pe.com.peruretouch.business.OrderXStatusBusiness"%>
<%@page import="pe.com.peruretouch.business.OrdenBusiness"%>
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
        } else if (userBean.getPrivilege().equalsIgnoreCase("manager")) {
            response.sendRedirect("../manager/homeManager.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("sa")) {
            response.sendRedirect("../sa/homeSa.jsp");
        } else {
            //PhotosBean.removeAllPhotosFromTheList(session, getServletContext().getRealPath("/") + ConstantesWeb.FILE_SAVE_PATH_CLIENT);
            OrdenBusiness ordenBusiness = OrdenBusiness.obtenerEntidad();
            List<Orden> listOrders = ordenBusiness.listOrdersNoAssigned();
            ProductBusiness productBusiness = ProductBusiness.obtenerEntidad();
            List<Product> listProducts = productBusiness.listar();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - Get New Order</title>
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
                <!-- / header -->
                <!-- content -->
                <br><br><br>
                <div id="main1">
                    <%
                        if (listOrders.size() > 0) {
                    %>
                    <form action="../Controller" method="post">
                        <table cellspacing="30">
                            <tr>
                                <td>Id Order</td>
                                <td>Date Time Client Request</td>
                                <td># Photos</td>
                                <td># References</td>
                                <td>Type Retouch</td>
                                <td>Get Order</td>
                            </tr>
                            <%
                                for (Orden r : listOrders) {
                            %>
                            <tr>
                                <td><%= r.getIdOrder()%></td>
                                <td><%= r.getDateTimeClientRequest()%></td>
                                <td><%= ordenBusiness.orderNumberOfPhotos(r.getIdOrder())%></td>
                                <td><%= ordenBusiness.orderNumberOfReferences(r.getIdOrder())%></td>
                                <%
                                    int idProduct = ordenBusiness.orderProductType(r.getIdOrder());
                                    for (Product p : listProducts) {
                                        if (p.getIdProduct() == idProduct) {
                                %>
                                <td><%= p.getName()%></td>
                                <%
                                        }
                                    }
                                %>
                                <td align="center"><a href="../Controller?idOrder=<%= r.getIdOrder()%>&action=<%= ConstantesWeb.GET_NEW_ORDER%>"><img src="../images/get.png" alt="Request" height="20"></a></td>
                            </tr>
                            <%
                                }%>
                        </table>
                    </form>
                    <%
                    } else {
                    %>
                    <h2>There aren't current orders.</h2>
                    <%
                        }
                    %>
                </div>
                <!-- / content -->
                <!-- footer -->
                <%@include file="../template/footer.jsp" %>
            </div>
        </div>
    </body>
</html>
<%
        }
    }
%>