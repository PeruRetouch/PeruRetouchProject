<%-- 
    Document   : viewExamples
    Created on : 11/10/2014, 09:10:06 AM
    Author     : Roy Taza Rojas
--%>

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
        String idProduct = request.getParameter("product");
        if (idProduct != null) {
            if (idProduct.equalsIgnoreCase("basic") || idProduct.equalsIgnoreCase("plus") || idProduct.equalsIgnoreCase("special")) {
                Integer idPhoto = Integer.parseInt(request.getParameter("photo"));
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - View Examples</title>
        <link rel="icon" type="image/png" href="images/iconoPR.jpg" />
        <meta name="description" content="Peru Retouch gives you a post-photography service">
        <meta name="keywords" content="retouch,peru,photo,photographer,retouch photo">
        <meta name="author" content="Roy Taza Rojas">
        <link href="css/styles.css" rel="stylesheet" type="text/css" media="screen" />

        <link rel="stylesheet" href="slider/styles-nivo-slider.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="slider/nivo-slider.css" type="text/css" media="screen" />
    </head>
    <body bgcolor="#FFFFFF" text="#000000" onLoad="presImagen()">
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
                <br><br><br><br>
                <div id="main1" style="text-align: center">
                    <!-- INICIO SCRIPT CHANGE IMAGE -->
                    <script language="javascript">
                        function get(name) {
                            if (name = (new RegExp('[?&]' + encodeURIComponent(name) + '=([^&]*)')).exec(location.search))
                                return decodeURIComponent(name[1]);
                        }
                        //Aquí cambia los nombres de las imágenes por las tuyas.
                        var imagenes = new Array()

                        imagenes[0] = new Image(380, 288);
                        imagenes[0].src = "/PeruRetouch/images/" + get("product") + "/" + get("photo") + ".jpg"
                        imagenes[1] = new Image(399, 291);
                        imagenes[1].src = "/PeruRetouch/images/" + get("product") + "/" + get("photo") + "0.jpg"

                        cont = 0
                        function presImagen()
                        {
                            if (document.all) {
                                document.getElementById('foto').filters.blendTrans.apply()
                                document.getElementById('foto').src = imagenes[cont].src
                                document.getElementById('foto').filters.blendTrans.play()
                            } else {
                                document.images.foto.src = imagenes[cont].src
                            }
                            if (cont < imagenes.length - 1)
                            {
                                cont++
                            } else {
                                cont = 0
                            }
                            tiempo = window.setTimeout('presImagen()', 1000)
                            //cada 5000 milisegundos (5 seg.) cambia la imagen.
                        }
                    </script>
                    <!-- FIN SCRIPT CHANGE IMAGE -->
                    <%
                        if (idProduct.equalsIgnoreCase("basic")) {
                    %>
                    <p id="titleProduct">Basic Retouch</p>
                    <%
                    } else if (idProduct.equalsIgnoreCase("plus")) {
                    %>
                    <p id="titleProduct">Plus Retouch</p>
                    <%
                    } else if (idProduct.equalsIgnoreCase("special")) {
                    %>
                    <p id="titleProduct">Special Retouch</p>
                    <%
                        }
                    %>
                    <br />
                    <div id="contenedorImagenMuestra">
                        <%
                            if (idPhoto != null) {
                                if (idPhoto == 99) {
                        %>
                        <a id="flechaBack" href="viewExamples.jsp?product=<%= request.getParameter("product")%>&photo=<%= 9%>"><img src="images/back.png" alt="back" height="20"></a>
                            <%
                            } else if (idPhoto > 1) {
                            %>
                        <a id="flechaBack" href="viewExamples.jsp?product=<%= request.getParameter("product")%>&photo=<%= idPhoto - 1%>"><img src="images/back.png" alt="back" height="20"></a>
                            <%
                                    }
                                }
                            %>
                        <img id="foto" src="/PeruRetouch/images/<%= request.getParameter("product")%>/<%= request.getParameter("photo")%>.jpg" style="filter:blendTrans(duration=[b]3[/b])" height="600">
                        <%
                            if (idPhoto != null) {
                                if (idProduct.equalsIgnoreCase("basic")) {
                                    if (idPhoto < 4) {
                        %>
                        <a id="flechaNext" href="viewExamples.jsp?product=<%= request.getParameter("product")%>&photo=<%= idPhoto + 1%>"><img src="images/next.png" alt="next" height="20"></a>
                            <%
                                }
                            } else if (idProduct.equalsIgnoreCase("plus")) {
                                if (idPhoto < 9) {
                            %>
                        <a id="flechaNext" href="viewExamples.jsp?product=<%= request.getParameter("product")%>&photo=<%= idPhoto + 1%>"><img src="images/next.png" alt="next" height="20"></a>
                            <%
                            } else if (idPhoto == 9) {
                            %>
                        <a id="flechaNext" href="viewExamples.jsp?product=<%= request.getParameter("product")%>&photo=99"><img src="images/next.png" alt="next" height="20"></a>
                            <%
                                }
                            } else if (idProduct.equalsIgnoreCase("special")) {
                                if (idPhoto < 6) {
                            %>
                        <a id="flechaNext" href="viewExamples.jsp?product=<%= request.getParameter("product")%>&photo=<%= idPhoto + 1%>"><img src="images/next.png" alt="next" height="20"></a>
                            <%
                                        }
                                    }
                                }
                            %>
                        <br><br><br>
                        <label id="titleProduct" style="font-size: 17px;font-weight: normal">EXAMPLES</label>
                        <%
                            if (idProduct.equalsIgnoreCase("basic")) {
                        %>
                        <div style="margin-left: 35px;margin-right: 35px;border: 1pt solid black; text-align: center;">
                            <table cellspacing="30" align="center" width="100%" >
                                <tr>
                                    <td><a href="viewExamples.jsp?product=basic&photo=1"><img src="images/basic/1.jpg" width="100"></a></td>
                                    <td><a href="viewExamples.jsp?product=basic&photo=2"><img src="images/basic/2.jpg" width="100"></a></td>
                                    <td><a href="viewExamples.jsp?product=basic&photo=3"><img src="images/basic/3.jpg" width="100"></a></td>
                                    <td><a href="viewExamples.jsp?product=basic&photo=4"><img src="images/basic/4.jpg" width="100"></a></td>
                                </tr>
                            </table>
                        </div>
                        <%
                        } else if (idProduct.equalsIgnoreCase("plus")) {
                        %>
                        <div style="margin-left: 35px;margin-right: 35px;border: 1pt solid black; text-align: center;">
                            <table cellspacing="30" align="center" width="100%" >
                                <tr>
                                    <td><a href="viewExamples.jsp?product=plus&photo=1"><img src="images/plus/1.jpg" width="100"></a></td>
                                    <td><a href="viewExamples.jsp?product=plus&photo=2"><img src="images/plus/2.jpg" width="100"></a></td>
                                    <td><a href="viewExamples.jsp?product=plus&photo=3"><img src="images/plus/3.jpg" width="100"></a></td>
                                    <td><a href="viewExamples.jsp?product=plus&photo=4"><img src="images/plus/4.jpg" width="100"></a></td>
                                    <td><a href="viewExamples.jsp?product=plus&photo=5"><img src="images/plus/5.jpg" width="100"></a></td>
                                </tr>
                                <tr>
                                    <td><a href="viewExamples.jsp?product=plus&photo=6"><img src="images/plus/6.jpg" width="100"></a></td>
                                    <td><a href="viewExamples.jsp?product=plus&photo=7"><img src="images/plus/7.jpg" width="100"></a></td>
                                    <td><a href="viewExamples.jsp?product=plus&photo=8"><img src="images/plus/8.jpg" width="100"></a></td>
                                    <td><a href="viewExamples.jsp?product=plus&photo=9"><img src="images/plus/9.jpg" width="100"></a></td>
                                    <td><a href="viewExamples.jsp?product=plus&photo=99"><img src="images/plus/99.jpg" width="100"></a></td>
                                </tr>
                            </table>
                        </div>
                        <%
                        } else if (idProduct.equalsIgnoreCase("special")) {
                        %>
                        <div style="margin-left: 35px;margin-right: 35px;border: 1pt solid black; text-align: center;">
                            <table cellspacing="30" align="center" width="100%" >
                                <tr>
                                    <td><a href="viewExamples.jsp?product=special&photo=1"><img src="images/special/1.jpg" width="100"></a></td>
                                    <td><a href="viewExamples.jsp?product=special&photo=2"><img src="images/special/2.jpg" width="100"></a></td>
                                    <td><a href="viewExamples.jsp?product=special&photo=3"><img src="images/special/3.jpg" width="100"></a></td>
                                    <td><a href="viewExamples.jsp?product=special&photo=4"><img src="images/special/4.jpg" width="100"></a></td>
                                    <td><a href="viewExamples.jsp?product=special&photo=5"><img src="images/special/5.jpg" width="100"></a></td>
                                    <td><a href="viewExamples.jsp?product=special&photo=6"><img src="images/special/6.jpg" width="100"></a></td>
                                </tr>
                            </table>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <br />
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
            } else {
                response.sendRedirect("pricesGalllery.jsp");
            }
        } else {
            response.sendRedirect("pricesGalllery.jsp");
        }
    }
%>
