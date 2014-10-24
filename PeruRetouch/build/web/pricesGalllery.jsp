<%-- 
    Document   : pricesGalllery
    Created on : 16/09/2014, 07:16:49 AM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - Prices & Gallery</title>
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
                    <img id="logoPeruRetouch" src="images/logoPeruRetouch.jpg" alt="logoPeruRetouch">
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
                <br><br><br><br><br><br><br>
                <div id="main1">
                    <div id="left1">
                        <h5>Basic retouch: $2.50/image</h5><img src="images/portrait1.jpg" alt="" style="float: left; padding-right: 10px;height: 200px;" />
                        <div style="margin-left: 650px">
                            <p style="font-size: 15px;"><b>INCLUDES:</b></p>
                            <ul>
                                <li style="font-size: 15px;">Remove tan lines</li>
                                <li style="font-size: 15px;">Remove blemishes</li>
                                <li style="font-size: 15px;">Remove under eye bags</li>
                                <li style="font-size: 15px;">Remove facial glare</li>
                                <li style="font-size: 15px;">Whitening teeth and eyes</li>
                                <li style="font-size: 15px;">Remove stray hairs around heads</li>
                                <li style="font-size: 15px;">Remove sensor dust</li>
                                <li style="font-size: 15px;">Fix spots in background</li>
                                <li style="font-size: 15px;">Overall skin smoothing</li>
                            </ul>
                        </div>
                        <div class="readl"><a href="viewExamples.jsp?product=basic&photo=1">more</a></div>
                    </div>
                    <br><br><br><br><br>
                    <div id="left1">
                        <h5>Plus Retouch: $5.00/image</h5><img src="images/portrait4.jpg" alt="" style="float: left; padding-right: 10px;height: 200px;" />
                        <div style="margin-left: 650px">
                            <p style="font-size: 15px;"><b>INCLUDES:</b></p>
                            <ul>
                                <li style="font-size: 15px;">“Basic retouch”</li>
                                <li style="font-size: 15px;">Smoothing background wrinkles and creases</li>
                                <li style="font-size: 15px;">Braces removal</li>
                                <li style="font-size: 15px;">Eyeglass glare removal</li>
                                <li style="font-size: 15px;">Head swap</li>
                                <li style="font-size: 15px;">Opening eyes</li>
                                <li style="font-size: 15px;">Extending the background</li>
                                <li style="font-size: 15px;">Moderate Lense Flare / Hot Spots</li>
                                <li style="font-size: 15px;">Background removal (original solid color replacement only)</li>
                                <li style="font-size: 15px;">Spot Coloring (all B&W except 1 object)</li>
                                <li style="font-size: 15px;">Remove doble chin.</li>
                            </ul>
                        </div>
                        <div class="readl"><a href="viewExamples.jsp?product=plus&photo=1">more</a></div>
                    </div>
                    <br><br><br>
                    <div id="left1">
                        <h5>Special Retouch: $10.00/image</h5><img src="images/portrait2.jpg" alt="" style="float: left; padding-right: 10px;height: 200px;" />
                        <div style="margin-left: 650px">
                            <p style="font-size: 15px;"><b>INCLUDES:</b></p>
                            <ul>
                                <li style="font-size: 15px;">“Basic retouch” and “plus retouch”</li>
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
                        <!-- / content -->
                        <!-- footer -->
                    </div>
                    <br><br><br>
                </div>
                <%@include file="template/footer.jsp" %>
            </div>
        </div>
        <!-- / footer -->
    </body>
</html>
