<%-- 
    Document   : register
    Created on : 20/09/2014, 05:05:05 PM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.web.util.ManejadorFechas"%>
<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ManejadorFechas manejadorFechas = new ManejadorFechas();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - Register</title>
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
                <div id="header" style="height: auto">
                    <!--img id="logoPeruRetouch" src="images/logoPeruRetouch.jpg" alt="logoPeruRetouch"-->
                    <script language="javascript">AC_FL_RunContent = 0;</script>
                    <script src="js/AC_RunActiveContent.js"></script>
                    <%@include file="template/logo.jsp" %>
                    <br><br><br>
                    <div id="menu">
                        <ul>
                            <li id="button1"><a href="index.jsp" title="">Home</a></li>
                            <li id="button2"><a href="pricesGalllery.jsp" title="">Prices & Gallery</a></li>
                            <li id="button4"><a href="about.jsp" title="">About</a></li>
                            <li id="button5"><a href="contact.jsp" title="">Contact</a></li>
                        </ul>
                    </div>
                </div>
                <!-- / header -->
                <!-- content -->
                <br><br><br><br><br><br>
                <div style="margin-left: 310px">
                    <div id="main">
                        <div id="main_bot">
                            <div id="left">
                                <div id="log">
                                    <h3>User Register</h3>
                                    <form id="formLogin" method="post" action="Controller">
                                        <fieldset>
                                            <input type="hidden" name="action" value="<%= ConstantesWeb.REGISTER_USER%>" />
                                            <%
                                                if (request.getParameter("message") != null) {
                                            %>
                                            <label for="text1" style="color: red"><%= request.getParameter("message")%></label><br />
                                            <%
                                                }
                                            %>
                                            <label for="text1">Username (*)</label><br /><input id="text1" type="text" name="txtUserName" value="" maxlength="50" required /><br />
                                            <label for="text2">Password (*)</label><br /><input id="text2" type="password" name="txtPassword" value="" maxlength="50" required /><br />
                                            <!--label for="text1">Repeat Password (*)</label><br /><input id="text1" type="text" name="txtPasswordRepeat" value="" required /><br /-->
                                            <label for="text1">Email (*)</label><br /><input id="text1" type="email" name="txtEmail" value="" maxlength="50" required /><br />
                                            <label for="text1">Name (*)</label><br /><input id="text1" type="text" name="txtName" value="" maxlength="50" required /><br />
                                            <label for="text1">Last Name (*)</label><br /><input id="text1" type="text" name="txtLastName" maxlength="50" value="" required /><br />
                                            <label for="text1">Website Address (*)</label><br /><input id="text1" type="text" name="txtWebsiteAddress" maxlength="200" value="http://" required /><br />
                                            <label for="text1">Address</label><br /><input id="text1" type="text" name="txtAddress" maxlength="200" value="" /><br />
                                            <label for="text1">Country</label><br /><input id="text1" type="text" name="txtCountry" maxlength="50" value="" /><br />
                                            <label for="text1">Birthday</label><br /><input id="text1" type="date" name="txtBirthday" value="" /><br />
                                            <label for="text1">Telephone</label><br /><input id="text1" type="text" name="txtTelephone" maxlength="50" value="" /><br /> 
                                            <label for="text1">Cellphone</label><br /><input id="text1" type="text" name="txtCellphone" maxlength="50" value="" /><br /> 
                                            <h5 align="right">(*)Required fields</h5><br>
                                            <input type="submit" value="Register" name="btnRegister" align="center"/>
                                        </fieldset>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- / content -->
                <!-- footer -->
                <%@include file="template/footer.jsp" %>
            </div>
        </div>
        <!-- / footer -->
    </body>
</html>
