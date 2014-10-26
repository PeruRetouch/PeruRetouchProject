<%-- 
    Document   : addSpecifications
    Created on : 19/09/2014, 10:22:27 AM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.web.util.UtilWeb"%>
<%@page import="pe.com.peruretouch.business.base.OperacionEnum"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="pe.com.peruretouch.web.bean.PhotosBean"%>
<%@page import="pe.com.peruretouch.entity.Product"%>
<%@page import="pe.com.peruretouch.business.ProductBusiness"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    if (session.getAttribute(ConstantesWeb.USER_HOME) == null) {
        response.sendRedirect("../index.jsp");
    } else {
        UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
        PhotosBean photosBean = new PhotosBean();
        if (userBean.getPrivilege().equalsIgnoreCase("artist")) {
            response.sendRedirect("../artist/homeArtist.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("supervisor")) {
            response.sendRedirect("../supervisor/homeSupervisor.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("manager")) {
            response.sendRedirect("../manager/homeManager.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("sa")) {
            response.sendRedirect("../sa/homeSa.jsp");
        } else if (request.getParameter("idProduct") == null) {
            response.sendRedirect("chooseProduct.jsp");
            //} else if (PhotosBean.getListPhotos().size() == 0) {
        } else if (photosBean.getListPhotos(session).size() == 0) {
            response.sendRedirect("chooseProduct.jsp");
        } else {
            try {
                ProductBusiness productBusiness = ProductBusiness.obtenerEntidad();
                Product product = new Product();
                product.setIdProduct(Integer.parseInt(request.getParameter("idProduct")));
                if (product.getIdProduct() == ConstantesWeb.ID_PRODUCT_REFERENCE) {
                    response.sendRedirect("chooseProduct.jsp");
                } else if (photosBean.getListPhotos(session).size() == 0) {
                    response.sendRedirect("chooseProduct.jsp");
                } else {
                    product = productBusiness.ejecutar(OperacionEnum.OBTENER, product);
                    LinkedHashSet<String> photos = photosBean.getListPhotos(session);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - Add Photo Specifications</title>
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
                <br><br><br><br><br><br>
                <div id="main1">

                    <form method="post" action="../Controller">
                        <div id="uploadFiles">
                            <h3><%= product.getName()%></h3>
                            <br>
                            <p style="text-align: justify"><%= product.getDescription()%></p>
                            <br><br><br>
                            <p>Add the requirement for all the photos or/and each photo and choose an artist if you prefer:</p>
                            <br>

                            <!--p>
                                Artist: <select>
                                    <option value="0">Anyone</option>
                                    <option value="1">Luis Deudor</option>
                                    <option value="2">Jose Herrera</option>
                                    <option value="3">Williams Carmona</option>
                                    <option value="4">Nemias Estrella</option>
                                </select>
                            </p-->
                            <textarea name="txtOrderSpecification" cols="75" rows="5" placeholder="Order's specification"></textarea>
                        </div>

                        <%
                            if (photos.size() > 0) {
                        %>
                        <table cellspacing="40" align="center">
                            <%
                                int i = 1;
                                boolean aux = true;
                                for (String s : photos) {
                                    if (i == 1) {
                            %>
                            <tr align="center">
                                <%
                                    }
                                    if (i % 4 == 0) {

                                        if (aux) {
                                            aux = false;
                                            i--;
                                        } else {
                                            //Agrego una fila
                                %>
                            </tr>
                            <tr align="center">
                                <%
                                        }
                                    }
                                    //Agrego una columna
                                %>
                                <td>
                                    <%= UtilWeb.formatName(s, userBean.getIdUser().toString().length())%><br />
                                    <img src="../photoResources/photos/<%= s%>" height="100"><br />
                                    <textarea name="txtPhotoSpecification" cols="20" rows="4" placeholder="Photo's specification"></textarea><br />
                                    <input type="checkbox" name="chkReference" value="<%= s%>" >Reference
                                </td>
                                <%
                                        i++;
                                    }
                                %>
                            </tr>
                        </table>
                        <%}%>
                        <br />
                        <div id="buttonsUploadFiles">
                            <div style="float: right">
                                <input type="checkbox" name="chkConfirm" value="1" required />I'm sure about the specifications and I want to Send the order.
                            </div>
                            <br><br>
                            <button onclick="location.href = 'chooseProduct.jsp';" name="btnCancel" style="float: left;" >Choose another product</button>
                            <div style="float: right;">
                                <input type="hidden" name="idClient" value="<%= product.getIdProduct()%>" />
                                <input type="hidden" name="idProduct" value="<%= product.getIdProduct()%>" />
                                <input type="hidden" name="action" value="<%= ConstantesWeb.UPLOAD_PHOTOS_CLIENT%>" />
                                <input type="submit" name="btnContinue" value="Confirm and Send the Order" />
                            </div>
                        </div>
                    </form>
                    <br><br><br><br>
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
            } catch (Exception e) {
                response.sendRedirect("errorClient.jsp?message=" + e.getMessage());
            }
        }
    }
%>