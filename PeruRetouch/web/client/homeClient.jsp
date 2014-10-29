<%-- 
    Document   : homeClient
    Created on : 17/09/2014, 07:25:13 AM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.entity.OrderXStatus"%>
<%@page import="pe.com.peruretouch.business.OrderXStatusBusiness"%>
<%@page import="pe.com.peruretouch.entity.RetouchXStatus"%>
<%@page import="pe.com.peruretouch.business.RetouchXStatusBusiness"%>
<%@page import="pe.com.peruretouch.web.util.UtilWeb"%>
<%@page import="java.util.List"%>
<%@page import="pe.com.peruretouch.business.base.OperacionEnum"%>
<%@page import="pe.com.peruretouch.entity.Orden"%>
<%@page import="pe.com.peruretouch.business.OrdenBusiness"%>
<%@page import="pe.com.peruretouch.web.bean.PhotosBean"%>
<%@page import="pe.com.peruretouch.web.bean.UserBean"%>
<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    if (session.getAttribute(ConstantesWeb.USER_HOME) == null) {
        response.sendRedirect("../index.jsp");
    } else {
        UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
        if (userBean.getPrivilege().equalsIgnoreCase("artist")) {
            response.sendRedirect("../artist/homeArtist.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("supervisor")) {
            response.sendRedirect("../supervisor/homeSupervisor.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("manager")) {
            response.sendRedirect("../manager/homeManager.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("sa")) {
            response.sendRedirect("../sa/homeSa.jsp");
        } else {
            PhotosBean photosBean = new PhotosBean();
            photosBean.removeAllPhotosFromTheList(session, getServletContext().getRealPath("/") + ConstantesWeb.FILE_SAVE_PATH_CLIENT);
            OrdenBusiness ordenBusiness = OrdenBusiness.obtenerEntidad();
            List<Orden> listOrders = ordenBusiness.listOrdersByClient(userBean.getIdUser());
            OrderXStatusBusiness orderXStatusBusiness = OrderXStatusBusiness.obtenerEntidad();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - Welcome</title>
        <link rel="icon" type="image/png" href="images/iconoPR.jpg" />
        <meta name="author" content="Roy Taza Rojas">
        <link href="../css/styles.css" rel="stylesheet" type="text/css" media="screen" />
    </head>
    <body>
        <div id="bg1">
            <div id="content">
                <!-- header -->
                <div id="header" style="height: auto">
                    <!--img id="logoPeruRetouch" src="images/logoPeruRetouch.jpg" alt="logoPeruRetouch"-->
                    <script language="javascript">AC_FL_RunContent = 0;</script>
                    <script src="../js/AC_RunActiveContent.js"></script>
                    <%@include file="../template/logo.jsp" %>
                    <div id="contenedorLogout">
                        Welcome <%= userBean.getName()%> <%= userBean.getLastName()%>&nbsp;&nbsp;<a href="../Controller?action=<%= ConstantesWeb.LOGOUT%>"><div id="btnLogout"></div></a>
                    </div>
                    <%@include file="../template/menu.jsp" %>
                </div>
                <!-- / header -->
                <!-- content -->
                <br><br><br>
                <div id="main1">
                    <br>
                    <div id="viewOrder" style="margin-left: 0px">
                        <%
                            if (listOrders.size() > 0) {
                        %>
                        <h1 style="margin-left: 50px"></h1>
                        <div align="center">
                            <a href="uploadPhotos.jsp">Let's start uploading photo's.</a>
                            <br><br>See a video to get reference.<br>
                            <iframe width="300" height="190" src="//www.youtube.com/embed/T2bL65weZt4" frameborder="1" allowfullscreen></iframe>
                        </div>
                        <br><br>
                        <fieldset>
                            <legend><h2>Select an order to see the photos and retouches</h2></legend>
                            <table cellspacing="35" align="center">
                                <%
                                    int i = 1;
                                    boolean aux = true;
                                    for (Orden o : listOrders) {
                                        List<OrderXStatus> lsrOxS = orderXStatusBusiness.listByOrder(o.getIdOrder());
                                        if (i == 1) {
                                %>
                                <tr align="center">
                                    <%
                                        }
                                        if (i % 4 == 0) {

                                            if (aux) {
                                                aux = false;
                                                i--;
                                            } else {
                                                //Agrego una fila
                                    %>
                                </tr>
                                <tr align="center">
                                    <%
                                            }
                                        }
                                        //Agrego una columna
                                    %>
                                    <td>
                                        <h2># <%= o.getIdOrder()%></h2><br />
                                        <a href="orderPhotos.jsp?idOrder=<%= o.getIdOrder()%>"><img src="../images/folderImage.png" alt="<%= o.getIdOrder()%>"></a><br>
                                            <%
                                                for (OrderXStatus aid : lsrOxS) {
                                                    switch (aid.getIdStatus()) {
                                                        case ConstantesWeb.ID_STATUS_WORKING:
                                            %><img src="../images/working.png" alt="W"><%
                                                    break;
                                                case ConstantesWeb.ID_STATUS_WAITING_ANSWER:
                                        %><img src="../images/waitingAnswer.png" alt="WA"><%
                                                break;
                                            case ConstantesWeb.ID_STATUS_REWORKING:
                                        %><img src="../images/reworking.png" alt="r"><%
                                                break;
                                            case ConstantesWeb.ID_STATUS_REWORKED:
                                        %><img src="../images/reworked.png" alt="R"><%
                                                break;
                                            case ConstantesWeb.ID_STATUS_APPROVED:
                                        %><img src="../images/approved.png" alt="A"><%
                                                break;
                                            case ConstantesWeb.ID_STATUS_PAYED:
                                        %><img src="../images/approvedAndPayed.png" alt="AP"><%
                                                break;
                                            case ConstantesWeb.ID_STATUS_CANCELED:
                                        %><img src="../images/canceled.png" alt="C"><%
                                                        break;
                                                }
                                            }%>
                                        <p>Date: <%= o.getDateTimeClientRequest()%></p>
                                    </td>
                                    <%
                                            i++;
                                        }
                                    %>
                                </tr>
                            </table>
                        </fieldset>
                        <%} else {%>
                        <div align="center">
                            <a href="uploadPhotos.jsp">Let's start uploading photo's.</a>
                            <br><br>See a video to get reference.<br>
                            <iframe width="560" height="315" src="//www.youtube.com/embed/T2bL65weZt4" frameborder="1" allowfullscreen></iframe>
                        </div>
                        <%}%>
                        <br>
                        <!-- / content -->
                        <!-- footer -->
                    </div>
                    <br>
                </div>
                <%@include file="../template/footer.jsp" %>
            </div>
        </div>
    </body>
</html>
<%
        }
    }
%>