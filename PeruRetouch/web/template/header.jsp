<div id="header" style="height: auto">
    
    <%    UserBean userBeanxx = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
        if (userBeanxx != null) {
    %>
    <img id="logoPeruRetouch" src="../images/LogoPeruRetouch.gif" alt="logoPeruRetouch">
    <div id="contenedorLogout">
        Welcome <%= userBeanxx.getName()%> <%= userBeanxx.getLastName()%>&nbsp;&nbsp;<a href="../Controller?action=<%= ConstantesWeb.LOGOUT%>"><div id="btnLogout"></div></a>
    </div>
    <%@include file="menu.jsp" %>
    <%
    } else {
    %>
    <img id="logoPeruRetouch" src="images/LogoPeruRetouch.gif" alt="logoPeruRetouch">
    <br><br><br>
    <div id="menu">
        <ul>
            <li id="button1"><a href="index.jsp" title="">Home</a></li>
            <li id="button2"><a href="pricesGalllery.jsp" title="">Prices & Gallery</a></li>
            <li id="button4"><a href="about.jsp" title="">About</a></li>
            <li id="button5"><a href="contact.jsp" title="">Contact</a></li>
        </ul>
    </div>
    <%
        }
    %>
</div>