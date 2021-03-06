<%-- 
    Document   : register
    Created on : 20/09/2014, 05:05:05 PM
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

        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="//cdn.jsdelivr.net/webshim/1.14.5/polyfiller.js"></script>
        <script>
            webshims.setOptions('forms-ext', {types: 'date'});
            webshims.polyfill('forms forms-ext');
        </script>
    </head>
    <body>
        <div id="bg1">
            <div id="content">
                <!-- header -->
                <%@include file="template/header.jsp" %>
                <!-- / header -->
                <!-- content -->
                <br><br><br><br><br><br>
                <div style="margin-left: 327px">
                    <div id="main">
                        <div id="main_bot">
                            <div id="left">
                                <div id="log">
                                    <h3>User Register</h3>
                                    <form id="formLogin" method="post" action="Controller" onSubmit="return validarPasswd()">
                                        <fieldset>
                                            <script>
                                                var validarPasswd = function() {
                                                    var p1 = document.getElementById("passwd").value;
                                                    var p2 = document.getElementById("passwd2").value;
                                                    if (p1 != p2) {
                                                        alert("Review the password.");
                                                        return false;
                                                    } else {
                                                        return true;
                                                    }
                                                };
                                            </script>
                                            <input type="hidden" name="action" value="<%= ConstantesWeb.REGISTER_USER%>" />
                                            <%
                                                if (request.getParameter("message") != null) {
                                            %>
                                            <label for="text1" style="color: red"><%= request.getParameter("message")%></label><br />
                                            <%
                                                }
                                            %>
                                            <label for="text1">Username (*)</label><br /><input id="text1" type="text" name="txtUserName" value="" maxlength="50" required /><br />
                                            <label for="text2">Password (*)</label><br /><input id="passwd" type="password" name="txtPassword" value="" maxlength="50" required /><br />
                                            <label for="text1">Repeat Password (*)</label><br /><input id="passwd2" type="password" name="txtPasswordRepeat" value="" required /><br />
                                            <label for="text1">Email (*)</label><br /><input id="text1" type="email" name="txtEmail" value="" maxlength="50" required /><br />
                                            <label for="text1">Name (*)</label><br /><input id="text1" type="text" name="txtName" value="" maxlength="50" required /><br />
                                            <label for="text1">Last Name (*)</label><br /><input id="text1" type="text" name="txtLastName" maxlength="50" value="" required /><br />
                                            <label for="text1">Website Address or Facebook Page (*)</label><br /><input id="text1" type="text" name="txtWebsiteAddress" maxlength="200" value="http://" required /><br />
                                            <label for="text1">Address</label><br /><input id="text1" type="text" name="txtAddress" maxlength="200" value="" /><br />
                                            <label for="text1">Country</label><br /><input id="text1" type="text" name="txtCountry" maxlength="50" value="" /><br />
                                            <label for="text1">Birthdate</label><br /><input id="text1" type="date" name="txtBirthday" value="" lang="" /><br />
                                            <label for="text1">Telephone</label><br /><input id="text1" type="text" name="txtTelephone" maxlength="50" value="" /><br /> 
                                            <label for="text1">Cellphone</label><br /><input id="text1" type="text" name="txtCellphone" maxlength="50" value="" /><br /> <br />
                                            <label for="text1"><input type="checkbox" name="txtCellphone" value="Agree" required />I agree to all the <a href="terms.jsp" target="_blank">TERMS AND CONDITIONS</a>(*)</label><br /> 
                                            <h5 align="right">(*)Required fields</h5><br>
                                            <!--input type="submit" value="Register" name="btnRegister" align="center"/-->
                                            <input type="image" style="margin-left: 75px" src="images/register.png" name="btnRegister" width="154" alt="Register"/>
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
<%
    }
%>