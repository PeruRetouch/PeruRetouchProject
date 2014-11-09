<%-- 
    Document   : index
    Created on : 15/09/2014, 03:36:25 PM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    boolean showPage = false;
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
        String message = "";
        if (request.getParameter("message") != null) {
            message = request.getParameter("message").toString();
        }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch</title>
        <link rel="icon" type="image/png" href="images/iconoPR.jpg" />
        <meta name="description" content="Peru Retouch gives you a post-photography service">
        <meta name="keywords" content="retouch,peru,photo,photographer,retouch photo">
        <meta name="author" content="Roy Taza Rojas">
        <link href="css/styles.css" rel="stylesheet" type="text/css" media="screen" />

        <link rel="stylesheet" href="slider/styles-nivo-slider.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="slider/nivo-slider.css" type="text/css" media="screen" />
    </head>
    <body>
        <!-- PONERLE NOMBRE A CADA ORDEN DEL CLIENTE PARA QUE ASI NO PUEDA VER EL IDORDEN DE LA BASE DE DATOS -->
        <div id="bg1">
            <div id="content">
                <!-- header -->
                <%@include file="template/header.jsp" %>
                <!--div id="logo"-->
                <br><br><br><br><br>
                <div style="background: gray;height: 10px;width: 987px;"></div>
                <!--Carrusel de imagenes-->
                <div id="wrap">
                    <div id="slider-wrapper">
                        <div id="slider" class="nivoSlider">
                            <img src="images/portrait0.jpg" alt=""/>
                            <img src="images/portrait1.jpg" alt=""/>
                            <img src="images/portrait2.jpg" alt=""/>
                            <img src="images/portrait3.jpg" alt=""/>
                            <img src="images/portrait4.jpg" alt=""/>
                        </div>
                    </div>
                </div>
                <script type="text/javascript" src="slider/jquery-1.4.3.min.js"></script>
                <script type="text/javascript" src="slider/jquery.nivo.slider.pack.js"></script>
                <script type="text/javascript">
                    $(window).load(function() {
                        $('#slider').nivoSlider();
                    });
                </script>
                <!--Carrusel de imagenes-->
                <!--/div-->
                <div class="inner_copy"></div>
                <div style="background: gray;height: 10px;width: 987px;"></div>
                <br><br>
                <!-- / header -->
                <!-- content -->
                <div id="main">
                    <div id="main_bot">
                        <div id="right">
                            <h5>Reviews</h5><img src="images/img1.jpg" alt="" title="" style="float: left; padding-right: 10px;" />
                            <p><strong>"Very good service, efficient in their work."</strong><br>Esteban Huamán</p>
                            <p><strong>"Delivery on time, very good service"</strong><br>Ángel Chávez B.</p>
                            <p><strong>"Amazing job! This was a part of my first order and I am VERY happy!!! Will certainly be back!!!"</strong><br>Jorge Colina</p>
                            <p><strong>"Thank you very much for doing such a great job!"</strong><br>George Alania Bravo</p>
                        </div>
                        <div id="left">
                            <div id="log">
                                <h3>User Login</h3>
                                <form id="formLogin" method="post" action="Controller">
                                    <fieldset>
                                        <input type="hidden" name="action" value="<%=ConstantesWeb.LOGIN%>" />
                                        <%
                                            if (!message.equalsIgnoreCase("")) {
                                                if (message.contentEquals("The user has been created succesfully")) {
                                        %>
                                        <label for="text1" style="color: green"><%= message%></label><br />
                                        <%
                                        } else {
                                        %>
                                        <label for="text1" style="color: red"><%= message%></label><br />
                                        <%
                                                }
                                            }
                                        %>
                                        <label for="text1">Username</label><br /><input id="text1" type="text" name="txtUser" value="" maxlength="50" required/><br />
                                        <label for="text2">Password</label><br /><input id="text2" type="password" name="txtPassword" value="" maxlength="50" required /><br />
                                        <input type="submit" id="login-submit" value="Login" name="btnLogin" />
                                    </fieldset>
                                </form>
                                <img src="images/logls.jpg" title="" alt="" style="padding-right: 5px; padding-left:10px;"/><a href="register.jsp">Create new account</a><br />
                                <img src="images/logls.jpg" title="" alt="" style="padding-right: 5px; padding-left:10px;"/><a href="requestPassword.jsp">Forgot your password?</a>
                            </div>
                        </div>
                        <div style="clear:none;height:15px"></div>
                        <!-- / content -->
                        <!-- footer -->
                    </div>
                </div>
                <br>
                <%@include file="template/footer.jsp" %>
            </div>
        </div>
        <!-- / footer -->
    </body>
</html>
<%
    }
%>