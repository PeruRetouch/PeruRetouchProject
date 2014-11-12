<%-- 
    Document   : footer
    Created on : 15/09/2014, 04:15:26 PM
    Author     : Roy Taza Rojas
--%>
<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
<%@page import="pe.com.peruretouch.web.bean.UserBean"%>
<%
    UserBean userAux = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
%>
<div id="footer">
    <div id="left_con_bot">
        <%
            if (userAux != null) {
        %>
        <p>Copyright  2014. <!--a href="#">Privacy Policy | </a--><a href="../terms.jsp" target="_blank">Terms & Conditions</a></p>
        <p>Developed by Roy Taza Rojas</p>
        <p><img src="../images/compatible_chrome2020.gif" alt="Chrome">&nbsp;&nbsp;<img src="../images/compatible_firefox2020.gif" alt="Firefox">&nbsp;&nbsp;<img src="../images/compatible_ie10.jpg" alt="IE10"></p>
        <%
        } else {
        %>
        <p>Copyright  2014. <!--a href="#">Privacy Policy | </a--><a href="terms.jsp" target="_blank">Terms & Conditions</a></p> 
        <p>Developed by Roy Taza Rojas</p>
        <p><img src="images/compatible_chrome2020.gif" alt="Chrome">&nbsp;&nbsp;<img src="images/compatible_firefox2020.gif" alt="Firefox">&nbsp;&nbsp;<img src="images/compatible_ie10.jpg" alt="IE10"></p>
        <%
            }
        %>
        <!--p>Design by <a>Free Flash Templates</a></p>
        <p>M&aacute;s <a href="#" title="MPG - plantillas web y plantillas Flash" target="_blank">Plantillas Web Gratis</a> en MPG.</p-->
    </div>
</div>