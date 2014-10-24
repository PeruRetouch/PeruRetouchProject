<%-- 
Document   : menu
Created on : 17/09/2014, 08:41:14 AM
Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
<%@page import="pe.com.peruretouch.web.bean.UserBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    UserBean usuariox = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
    if (usuariox != null) {
        if (usuariox.getPrivilege().equalsIgnoreCase("client")) {
%>
<div id="menu">
    <ul>
        <li id="button1"><a href="../client/homeClient.jsp">Home</a></li>
        <li id="button2"><a href="../client/viewUserInfo.jsp">My Profile</a></li>
        <li id="button3"><a href="../client/chooseProduct.jsp">Upload Photos</a></li>
        <li id="button4"><a href="../client/productsInfo.jsp">Our Products</a></li>
        <li id="button5"><a href="../client/ordersClient.jsp">My Orders</a></li>
        <li id="button9"><a href="../client/help.jsp">Help</a></li>
    </ul>
</div>
<%
} else if (usuariox.getPrivilege().equalsIgnoreCase("artist")) {
%>
<br /><br /><br /><br /><br /><br /><br /><br />
<div id="menu">
    <ul>
        <!--li id="button1"><a href="../artist/homeArtist.jsp">Home</a></li-->
        <li id="button2"><a href="../artist/viewUserInfo.jsp">My Profile</a></li>
        <li id="button3"><a href="../artist/retouchOrders.jsp">Retouch Orders</a></li>
        <li id="button4"><a href="../artist/getNewOrder.jsp">Get New Order</a></li>
        <li id="button5"><a href="../artist/uploadRetouchedPhoto.jsp">Upload Retouched Photo</a></li>
    </ul>
</div>
<%
} else if (usuariox.getPrivilege().equalsIgnoreCase("supervisor")) {

%>
<div id="menu">
    <ul>
        <li id="button1"><a href="../supervisor/homeClient.jsp">Home</a></li>
        <li id="button2"><a href="../supervisor/viewUserInfo.jsp">My Profile</a></li>
        <li id="button3"><a href="../supervisor/chooseProduct.jsp">Upload Photos</a></li>
        <li id="button4"><a href="../supervisor/productsInfo.jsp">Our Products</a></li>
        <li id="button5"><a href="../supervisor/ordersClient.jsp">My Orders</a></li>
        <li id="button9"><a href="../supervisor/help.jsp">Help</a></li>
    </ul>
</div>
<%
} else if (usuariox.getPrivilege().equalsIgnoreCase("manager")) {
%>
<br /><br /><br /><br /><br /><br /><br /><br />
<div id="menu">
    <ul>
        <li id="button2"><a href="../manager/viewUserInfo.jsp">My Profile</a></li>
        <li id="button1"><a href="../manager/payOrder.jsp">PAY Order</a></li>
        <li id="button2"><a href="../manager/listUsers.jsp">DISABLE User</a></li>
    </ul>
</div>
<%
        }
    }
%>
