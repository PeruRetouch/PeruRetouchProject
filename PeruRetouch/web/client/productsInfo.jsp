<%-- 
    Document   : productsInfo
    Created on : 01/10/2014, 11:10:10 AM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.business.base.OperacionEnum"%>
<%@page import="pe.com.peruretouch.business.ProductBusiness"%>
<%@page import="pe.com.peruretouch.entity.Product"%>
<%@page import="pe.com.peruretouch.web.bean.PhotosBean"%>
<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
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
            try {
                PhotosBean photosBean = new PhotosBean();
                photosBean.removeAllPhotosFromTheList(session, getServletContext().getRealPath("/") + ConstantesWeb.FILE_SAVE_PATH_CLIENT);
                ProductBusiness productBusiness = ProductBusiness.obtenerEntidad();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - Products Info</title>
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

                    <div id="left1">
                        <h5>Complete retouch: $2.50/image</h5><img src="../images/portrait1.jpg" alt="" style="float: left; padding-right: 10px;height: 200px;" />
                        <div style="margin-left: 10px;">
                            <p style="font-size: 15px;"><b>INCLUDES:</b></p>
                            <ul>
                                <li style="font-size: 15px;">Removal of facial glare</li>
                                <li style="font-size: 15px;">Stray hairs</li>
                                <li style="font-size: 15px;">Skin blemishes</li>
                                <li style="font-size: 15px;">Spots in background</li>
                                <li style="font-size: 15px;">Whitening of teeth and eyes</li>
                                <li style="font-size: 15px;">Image exposure</li>
                            </ul>
                        </div>
                        <div class="readl"><a href="viewExamples.jsp?product=basic&photo=1">more</a></div>
                    </div>
                    <br><br><br><br><br><br>
                    <div id="left1">
                        <h5>Complete plus: $5.00/image</h5><img src="../images/portrait4.jpg" alt="" style="float: left; padding-right: 10px;height: 200px;" />
                        <div>
                            <p style="font-size: 15px;"><b>INCLUDES:</b></p>
                            <ul>
                                <li style="font-size: 15px;">All "complete retouch" image enhancements</li>
                                <li style="font-size: 15px;">Braces removal</li>
                                <li style="font-size: 15px;">Eyeglass glare removal</li>
                                <li style="font-size: 15px;">Head swap</li>
                                <li style="font-size: 15px;">Opening eyes</li>
                                <li style="font-size: 15px;">Extending the background</li>
                                <li style="font-size: 15px;">Moderate Lense Flare / Hot Spots</li>
                                <li style="font-size: 15px;">Background removal (solid color replacement)</li>
                                <li style="font-size: 15px;">Spot Coloring (all B&W except 1 object)</li>
                            </ul>
                        </div>
                        <div class="readl"><a href="viewExamples.jsp?product=plus&photo=1">more</a></div>
                    </div>
                    <br><br><br><br>
                    <div id="left1">
                        <h5>Special services: $10.00/image</h5><img src="../images/portrait2.jpg" alt="" style="float: left; padding-right: 10px;height: 200px;" />
                        <div>
                            <p style="font-size: 15px;"><b>INCLUDES:</b></p>
                            <ul>
                                <li style="font-size: 15px;">All "complete" and "complete plus" image enhancements</li>
                                <li style="font-size: 15px;">Change color of clothing</li>
                                <li style="font-size: 15px;">Background change (new background image)</li>
                                <li style="font-size: 15px;">Add or Remove people</li>
                                <li style="font-size: 15px;">Remove buildings, cars, etc.</li>
                                <li style="font-size: 15px;">Extreme Lense Flare / Hot Spots</li>
                                <li style="font-size: 15px;">Take off 10 years, 20 lbs, etc.</li>
                                <li style="font-size: 15px;">Anything not covered by complete or complete plus</li>
                            </ul>                                
                            <div class="readl"><a href="viewExamples.jsp?product=special&photo=1">more</a></div>
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
            } catch (Exception e) {
                response.sendRedirect("errorClient.jsp?message=" + e.getMessage());
            }
        }
    }
%>
