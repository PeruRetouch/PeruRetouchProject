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

                    <form method="post" action="../Controller" onsubmit="document.forms['frmPhotos']['btnSendNow'].disabled = true;" name="frmPhotos">
                        <div id="uploadFiles">
                            <h3><%= product.getName()%></h3>
                            <br>
                            <p style="text-align: justify"><%= product.getDescription()%></p>
                            <br>
                            <br>
                            <p><img src="../images/dollar.png" alt="#"> Price per photo : $<%= product.getPrice()%></p>
                            <p style="font-size: 15px">Photo references does NOT have price.</p>
                            <br>
                            <br>
                            <p>Add the requirement for all the photos and/or each photo:</p>
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
                                    <img src="../photoResources/temporary/<%= s%>" width="200"><br />
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
                                <input type="checkbox" name="chkConfirm" value="1" required />I'm sure about the specifications, pay $<%= product.getPrice()%> per photo and SEND the order.
                            </div>
                            <br><br>
                            <!--button onclick="location.href = 'chooseProduct.jsp';" name="btnCancel" style="float: left;" >Choose another product</button-->
                            <a href="chooseProduct.jsp" style="float: left;" ><img src="../images/cancel.png" alt="Cancel" height="40"></a>
                            <div style="float: right;">
                                <input type="hidden" name="idClient" value="<%= product.getIdProduct()%>" />
                                <input type="hidden" name="idProduct" value="<%= product.getIdProduct()%>" />
                                <input type="hidden" name="action" value="<%= ConstantesWeb.UPLOAD_PHOTOS_CLIENT%>" />
                                <input type="image" src="../images/send.png" name="btnSendNow" style="float: right;margin-top: -12px;" height="55" alt="SendNow"/>
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