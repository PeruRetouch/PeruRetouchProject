<%-- 
    Document   : about
    Created on : 16/09/2014, 10:36:54 AM
    Author     : Roy Taza Rojas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    
    boolean showPage = false;
    if (session.getAttribute(ConstantesWeb.USER_HOME) != null) {
        UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
        if (userBean.getPrivilege().equalsIgnoreCase("artist")) {
            response.sendRedirect("artist/homeArtist.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("supervisor")) {
            response.sendRedirect("supervisor/homeSupervisor.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("manager")) {
            response.sendRedirect("manager/homeManager.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("sa")) {
            response.sendRedirect("sa/homeSa.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("client")) {
            response.sendRedirect("client/homeClient.jsp");
        } else {
            showPage = true;
        }
    } else {
        showPage = true;
    }
    if (showPage) {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - About</title>
        <link rel="icon" type="image/png" href="images/iconoPR.jpg" />
        <meta name="description" content="Peru Retouch gives you a post-photography service">
        <meta name="keywords" content="retouch,peru,photo,photographer,retouch photo">
        <meta name="author" content="Roy Taza Rojas">
        <link href="css/styles.css" rel="stylesheet" type="text/css" media="screen" />
    </head>
    <body>
        <div id="bg1">
            <div id="content">
                <!-- header -->
                <%@include file="template/header.jsp" %>
                <!-- / header -->
                <!-- content -->
                <br><br><br><br><br><br>
                <div id="main1">
                    <div id="left1">
                        <h5>About Us: Peru Retouch</h5>
                        <!--iframe style="margin-left: 212px" width="560" height="315" src="//www.youtube.com/embed/Wencx57sBq4?autoplay=1" frameborder="1" allowfullscreen></iframe-->
                        <!--br><br-->
                        <div style="font-size: 15px;font-family: Arial, Helvetica, sans-serif;margin-left: 15px;margin-right: 15px;text-align: justify">
                            <p>
                                PeruRetouch is a very dynamic company that understands the need of every photographer. With PeruRetouch techniques you will get amazing results.
                            </p>
                            <p>
                                A service specially designed for photographers and businesses who just need to do the retouching and artwork of photographs.
                                We love to highlight the excellent work of professional photographer.
                            </p>
                            <p>
                                The images post-production is routine and takes too much time, for it, PeruRetouch offers a professional team with 10 years experience. 
                                We offer low prices and punctual delivery with excellent quality.
                            </p>
                            <p>
                                Take advantage of 15 free photo retouching and check our quality.
                            </p>
                        </div>
                    </div>
                    <!-- / content -->
                    <!-- footer -->
                </div>
                <%@include file="template/footer.jsp" %>
            </div>
        </div>
    </body>
</html>
<%
    }
%>