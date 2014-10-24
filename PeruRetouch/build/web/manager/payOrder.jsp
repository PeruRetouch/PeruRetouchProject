<%-- 
    Document   : listOrders
    Created on : 13/10/2014, 04:39:15 PM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.business.UserBusiness"%>
<%@page import="pe.com.peruretouch.entity.User"%>
<%@page import="pe.com.peruretouch.entity.Orden"%>
<%@page import="java.util.List"%>
<%@page import="pe.com.peruretouch.business.OrdenBusiness"%>
<%@page import="pe.com.peruretouch.web.bean.PhotosBean"%>
<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    if (session.getAttribute(ConstantesWeb.USER_HOME) == null) {
        response.sendRedirect("../index.jsp");
    } else {
        UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
        if (userBean.getPrivilege().equalsIgnoreCase("client")) {
            response.sendRedirect("../client/homeArtist.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("supervisor")) {
            response.sendRedirect("../supervisor/homeSupervisor.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("artist")) {
            response.sendRedirect("../manager/homeArtist.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("sa")) {
            response.sendRedirect("../sa/homeSa.jsp");
        } else {
            PhotosBean.removeAllPhotosFromTheList(session, getServletContext().getRealPath("/") + ConstantesWeb.FILE_SAVE_PATH_CLIENT);
            OrdenBusiness ordenBusiness = OrdenBusiness.obtenerEntidad();
            UserBusiness userBusiness = UserBusiness.obtenerEntidad();
            List<Orden> lstOrden = ordenBusiness.listOrdersNoPayed();
            List<User> lstUser = userBusiness.listar();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - Pay Order</title>
        <meta name="author" content="Roy Taza Rojas">
        <link href="../css/styles.css" rel="stylesheet" type="text/css" media="screen" />
    </head>
    <body>
        <div id="bg1">
            <div id="content">
                <!-- header -->
                <div id="header" style="height: auto">
                    <img id="logoPeruRetouch" src="../images/logoPeruRetouch.jpg" alt="logoPeruRetouch">
                    <div id="contenedorLogout">
                        Bienvenido <%= userBean.getName()%> <%= userBean.getLastName()%>&nbsp;&nbsp;<a href="../Controller?action=<%= ConstantesWeb.LOGOUT%>"><div id="btnLogout"></div></a>
                    </div>
                    <%@include file="../template/menu.jsp" %>
                </div>
                <br><br><br><br>
                <!-- content -->
                <div id="main1">
                    <%
                        if (request.getParameter("message") != null) {
                    %>
                    <br>
                    <label for="text1" style="color: green;font-size: 18px"><%= request.getParameter("message")%></label><br />
                    <%
                        }
                    %>
                    <%
                        if (lstOrden.size() > 0) {
                    %>
                    <table cellspacing="20" style="text-align: center">
                        <tr>
                            <td>ID Order</td>
                            <td>Date</td>
                            <td>ID User</td>
                            <td>Name and Last name</td>
                            <td>Pay</td>
                            <!--td>Desactive</td-->
                        </tr>
                        <%
                            for (Orden o : lstOrden) {
                        %>
                        <tr>
                            <td><%= o.getIdOrder()%></td>
                            <td><%= o.getDateTimeClientRequest()%></td>
                            <%
                                for (User u : lstUser) {
                                    if (o.getIdClient() == u.getIdUser()) {
                            %>
                            <td><%= u.getIdUser()%></td>
                            <td><%= u.getName()%>&nbsp;<%= u.getLastName()%></td>
                            <td><a href="../Controller?idOrder=<%= o.getIdOrder()%>&action=<%= ConstantesWeb.MANAGER_PAY_ORDER%>"><img src="../images/pay.png" alt="pay order" height="21"></a></td>
                            <!--td><a href="../Controller?idOrder=<%= o.getIdOrder()%>&action=<%= ConstantesWeb.MANAGER_DISABLE_ACOCUNT%>"><img src="../images/desactivar.png" alt="to inactive order" height="22"></a></td-->
                                    <%
                                                break;
                                            }
                                        }
                                    %>
                        </tr>
                        <%
                            }
                        %>
                    </table>
                    <%
                        }
                    %>
                    <%
                    %>
                    <%
                    %>
                </div>
                <%@include file="../template/footer.jsp" %>
            </div>
        </div>
    </body>
</html>
<%        }
    }
%>