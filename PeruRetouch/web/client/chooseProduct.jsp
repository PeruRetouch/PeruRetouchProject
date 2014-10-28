<%-- 
    Document   : chooseProduct
    Created on : 17/09/2014, 11:02:43 AM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.web.bean.PhotosBean"%>
<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
<%@page import="pe.com.peruretouch.business.ProductBusiness"%>
<%@page import="java.util.List"%>
<%@page import="pe.com.peruretouch.entity.Product"%>
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
            ProductBusiness productBusiness = ProductBusiness.obtenerEntidad();
            List<Product> products = productBusiness.listarProducts();
            PhotosBean photosBean = new PhotosBean();
            photosBean.removeAllPhotosFromTheList(session, getServletContext().getRealPath("/") + ConstantesWeb.FILE_SAVE_PATH_CLIENT);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - Choose a Product</title>
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
                <br><br><br><br><br><br>
                <div id="main1">
                    <div id="uploadFiles">
                        <br>
                        <h3>Choose a product:</h3>
                        <br>
                        <p>Click in the product to choose it.</p>
                        <br><br>
                        <table cellspacing="15" width="100%">
                            <tr>
                                <td colspan="3" width="11%" align="center"><label style="text-align: center;color: #008ae8;font-size: 17px">Product</label></td>
                                <td width="11%" align="center"><label style="text-align: center;color: #008ae8;font-size: 15px">Price per photo</label></td>
                                <td width="78%"><label style="text-align: center;color: #008ae8;font-size: 15px">Features</label></td>
                            </tr>
                            <%
                                for (Product p : products) {
                            %>
                            <tr>
                                <td><a href="uploadPhotos.jsp?idProduct=<%= p.getIdProduct()%>"><img src="../images/right.png" alt="Choose"></a></td>
                                <td><a href="uploadPhotos.jsp?idProduct=<%= p.getIdProduct()%>"><h4><%= p.getName()%></h4></a></td>
                                <td align="center"><%= p.getAbreviation()%></td>
                                <td align="center">$<%= p.getPrice()%></td>
                                <td style="text-align: justify"><%= p.getDescription()%></td>
                                <!--td><img src="#" width="400" height="120" /></td-->
                            </tr>
                            <%
                                }
                            %>
                        </table>
                        <br><br><br>
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