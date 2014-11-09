<%-- 
    Document   : retouchOrders
    Created on : 26/09/2014, 09:30:49 AM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.web.util.UtilWeb"%>
<%@page import="pe.com.peruretouch.entity.Orden"%>
<%@page import="pe.com.peruretouch.business.OrdenBusiness"%>
<%@page import="pe.com.peruretouch.business.RetouchXSpecificationBusiness"%>
<%@page import="pe.com.peruretouch.entity.RetouchXSpecification"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pe.com.peruretouch.business.base.OperacionEnum"%>
<%@page import="pe.com.peruretouch.entity.Product"%>
<%@page import="pe.com.peruretouch.business.ProductBusiness"%>
<%@page import="java.util.List"%>
<%@page import="pe.com.peruretouch.entity.Retouch"%>
<%@page import="pe.com.peruretouch.business.RetouchBusiness"%>
<%@page import="pe.com.peruretouch.web.bean.PhotosBean"%>
<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
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
            RetouchBusiness retouchBusiness = RetouchBusiness.obtenerEntidad();
            List<Retouch> lstRetouchs = retouchBusiness.listarByArtist(userBean.getIdUser());
            ProductBusiness productBusiness = ProductBusiness.obtenerEntidad();
            Product productAux = new Product();
            int idRetouch = 0;
            Retouch retouch = null;
            List<Retouch> lstReworks = retouchBusiness.listarReworkByArtist(userBean.getIdUser());
            if (request.getParameter("idRetouch") != null) {
                idRetouch = Integer.parseInt(request.getParameter("idRetouch"));
            }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - Retouch Orders</title>
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
                <br><br><br>
                <div id="main1">

                    <h2>Photos to rework</h2>
                    <%
                        if (lstReworks.size() > 0) {
                    %>
                    <table cellspacing="10">
                        <tr>
                            <td>File</td>
                            <td>Date Time Request</td>
                            <td>Type</td>
                            <td>Specifications</td>
                            <td>Donwload</td>
                        </tr>
                        <%
                            for (Retouch r : lstReworks) {
                                if (request.getParameter("idRetouch") != null) {
                                    if (r.getIdRetouch() == idRetouch) {
                                        retouch = r;
                                    }
                                }
                        %>
                        <tr>
                            <td><%= r.getFileNombre()%></td>
                            <td><%= UtilWeb.convertirDate(r.getDateTimeArtistRequest(), "MM/dd/yyyy HH:mm:ss")%></td>
                            <%
                                productAux.setIdProduct(r.getIdProduct());
                            %>
                            <td><%= productBusiness.ejecutar(OperacionEnum.OBTENER, productAux).getName()%></td>
                            <%
                            %>
                            <td><a href="retouchOrders.jsp?idRetouch=<%= r.getIdRetouch()%>" style="text-decoration: none;color: #008ae8;">View</a></td>
                            <td align="center"><a href="../photoResources/photos/<%= r.getFileNombre()%>" download target="_blank"><img src="../images/download.png" height="20"></a></td>
                        </tr>
                        <%
                            }
                        %>
                    </table>
                    <%
                    } else {
                    %>
                    <h3 style="margin-left: 10px">You don't have photos to rework.</h3>

                    <%
                        }%>
                    <br><hr><br>
                    <h2>Photos to retouch</h2>
                    <%
                        if (lstRetouchs.size() > 0) {
                    %>
                    <a href="../Controller?action=<%= ConstantesWeb.ARTIST_DELETE_REFERENCES_APPROVED_ORDERS%>" style="">Clean References</a>
                    <table cellspacing="10">
                        <tr>
                            <td>File</td>
                            <td>Date Time Request</td>
                            <td>Type</td>
                            <td>Specifications</td>
                            <td>Donwload</td>
                        </tr>
                        <%
                            for (Retouch r : lstRetouchs) {
                                if (request.getParameter("idRetouch") != null) {
                                    if (r.getIdRetouch() == idRetouch) {
                                        retouch = r;
                                    }
                                }
                        %>
                        <tr>
                            <td><%= r.getFileNombre()%></td>
                            <td><%= UtilWeb.convertirDate(r.getDateTimeArtistRequest(), "MM/dd/yyyy HH:mm:ss")%></td>
                            <%
                                productAux.setIdProduct(r.getIdProduct());
                            %>
                            <td><%= productBusiness.ejecutar(OperacionEnum.OBTENER, productAux).getName()%></td>
                            <%
                            %>
                            <td><a href="retouchOrders.jsp?idRetouch=<%= r.getIdRetouch()%>" style="text-decoration: none;color: #008ae8;">View</a></td>
                            <td align="center"><a href="../photoResources/photos/<%= r.getFileNombre()%>" download target="_blank"><img src="../images/download.png" height="20"></a></td>
                        </tr>
                        <%
                            }
                        %>
                    </table>
                    <%
                    } else {
                    %>
                    <h3 style="margin-left: 10px">You don't have assigned photos.</h3>
                    <%
                        }
                        if (retouch != null) {
                            // Mostrar la especificacion del retoque solicitado
                            RetouchXSpecificationBusiness retouchXSpecificationBusiness = RetouchXSpecificationBusiness.obtenerEntidad();
                            List<RetouchXSpecification> listRxS = retouchXSpecificationBusiness.obtenerByRetouch(idRetouch);
                    %>
                    <br><hr><br>
                    <h2>Specifications</h2><br>
                    <div id="specifications" style="text-align: justify">
                        <h3><img src="../images/item.png">Retouch #<%= retouch.getIdRetouch()%></h3>
                            <%
                                if (listRxS.size() > 0) {
                                    for (RetouchXSpecification rxs : listRxS) {
                                        switch (rxs.getIdSpecificationType()) {
                                            case ConstantesWeb.ID_SPECIFICATION_NORMAL:
                            %>
                            <%= rxs.getSpecification()%><br>
                        <%
                                break;
                            case ConstantesWeb.ID_SPECIFICATION_REFERENCE:
                        %>
                        <b>Reference:</b> <%= rxs.getSpecification()%>
                        <%
                                break;
                            case ConstantesWeb.ID_SPECIFICATION_REWORK:
                        %>
                        <b>Rework (<%= UtilWeb.convertirDate(rxs.getDateTimeSpecification(), "MM/dd/yyyy HH:mm:ss")%>):</b><br>
                        <%= rxs.getSpecification()%><br>
                        <%
                                    break;
                            }
                        %>
                        <%
                            }
                        } else {
                        %>
                        - - -<br>
                        <%
                            }
                            // Mostrar la informacion de todos los retoques de la orden
                            OrdenBusiness ordenBusiness = OrdenBusiness.obtenerEntidad();
                            Orden orden = new Orden();
                            orden.setIdOrder(retouch.getIdOrder());
                            orden = ordenBusiness.ejecutar(OperacionEnum.OBTENER, orden);
                        %>
                        <br><br><br><h2><img src="../images/principalItem.png">Order #<%= retouch.getIdOrder()%></h2>
                        <div id="retouchesSpecifications" style="margin-left: 10px;margin-right: 20px">
                            <%= orden.getSpecifications()%><br>
                            <%
                                List<Retouch> lstR = retouchBusiness.obtenerRetouchPendienteByOrder(userBean.getIdUser(), retouch.getIdOrder());
                                for (Retouch r : lstR) {
                                    listRxS = retouchXSpecificationBusiness.obtenerByRetouch(r.getIdRetouch());
                            %>
                            <br><h3><img src="../images/item.png" height="12">Retouch #<%= r.getIdRetouch()%></h3>
                                <%
                                    if (listRxS.size() > 0) {
                                        for (RetouchXSpecification rxs : listRxS) {
                                            switch (rxs.getIdSpecificationType()) {
                                                case ConstantesWeb.ID_SPECIFICATION_NORMAL:
                                %>
                                <%= rxs.getSpecification()%><br>
                            <%
                                    break;
                                case ConstantesWeb.ID_SPECIFICATION_REFERENCE:
                            %>
                            <b>Reference:</b> <%= rxs.getSpecification()%><br>
                            <%
                                    break;
                                case ConstantesWeb.ID_SPECIFICATION_REWORK:
                            %>
                            <b>Rework (<%= UtilWeb.convertirDate(rxs.getDateTimeSpecification(), "MM/dd/yyyy HH:mm:ss")%>):</b>
                            <%= rxs.getSpecification()%><br>
                            <%
                                        break;
                                }
                            %>
                            <%
                                }
                            } else {
                            %>
                            - - -
                            <%
                                    }
                                }
                            %>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
                <br><br>
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