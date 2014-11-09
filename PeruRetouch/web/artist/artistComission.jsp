<%-- 
    Document   : artistComission
    Created on : 26/10/2014, 12:34:40 PM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.business.RetouchBusiness"%>
<%@page import="pe.com.peruretouch.entity.Retouch"%>
<%@page import="java.util.List"%>
<%@page import="pe.com.peruretouch.entity.Product"%>
<%@page import="pe.com.peruretouch.business.ProductBusiness"%>
<%@page import="pe.com.peruretouch.web.bean.PhotosBean"%>
<%@page import="pe.com.peruretouch.web.bean.UserBean"%>
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
            try {
                ProductBusiness productBusiness = ProductBusiness.obtenerEntidad();
                RetouchBusiness retouchBusiness = RetouchBusiness.obtenerEntidad();
                List<Product> listProducts = productBusiness.listarProducts();
                List<Retouch> listRetouchs;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - Upload Retouched Photos</title>
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
                    <div id="uploadFiles">
                        <h3>The photos you have work</h3>
                        <br><br>
                        <div style="margin-left: 15px">
                            <%
                                for (Product product : listProducts) {
                            %>
                            <h3><%= product.getName()%></h3>
                            <%
                                listRetouchs = retouchBusiness.listarRetouchsApprovedOfTheArtistByProduct(userBean.getIdUser(), product.getIdProduct());
                            %>
                            <p>Number of retouched Photos: <%= listRetouchs.size()%></p>
                            <br><br><br>
                            <%
                                }
                            %>
                        </div>
                    </div>
                    <br><br><br><br>
                </div>
                <%@include file="../template/footer.jsp" %>
            </div>
        </div>
    </body>
</html>
<%
            } catch (Exception e) {
                response.sendRedirect("errorClient.jsp?message=" + e.getMessage());
            }
        }
    }
%>

