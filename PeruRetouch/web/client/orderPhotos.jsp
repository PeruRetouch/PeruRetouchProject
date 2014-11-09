<%-- 
    Document   : orderPhotos
    Created on : 19/09/2014, 01:37:06 PM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.entity.RetouchXSpecification"%>
<%@page import="pe.com.peruretouch.business.RetouchXSpecificationBusiness"%>
<%@page import="pe.com.peruretouch.business.base.BusinessException"%>
<%@page import="pe.com.peruretouch.web.util.UtilWeb"%>
<%@page import="pe.com.peruretouch.entity.RetouchXStatus"%>
<%@page import="pe.com.peruretouch.business.RetouchXStatusBusiness"%>
<%@page import="pe.com.peruretouch.business.RetouchBusiness"%>
<%@page import="pe.com.peruretouch.entity.Retouch"%>
<%@page import="pe.com.peruretouch.business.base.OperacionEnum"%>
<%@page import="pe.com.peruretouch.entity.Orden"%>
<%@page import="java.util.List"%>
<%@page import="pe.com.peruretouch.business.OrdenBusiness"%>
<%@page import="pe.com.peruretouch.web.bean.PhotosBean"%>
<%@page import="pe.com.peruretouch.web.bean.UserBean"%>
<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    if (session.getAttribute(ConstantesWeb.USER_HOME) == null) {
        response.sendRedirect("../index.jsp");
    } else if (request.getParameter("idOrder") == null || request.getParameter("idOrder").equalsIgnoreCase("")) {
        response.sendRedirect("homeClient.jsp");
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
            try {
                PhotosBean photosBean = new PhotosBean();
                photosBean.removeAllPhotosFromTheList(session, getServletContext().getRealPath("/") + ConstantesWeb.FILE_SAVE_PATH_CLIENT);
                OrdenBusiness ordenBusiness = OrdenBusiness.obtenerEntidad();
                Integer idOrder = Integer.parseInt(request.getParameter("idOrder"));
                Orden orden = new Orden();
                orden.setIdOrder(idOrder);
                orden = ordenBusiness.ejecutar(OperacionEnum.OBTENER, orden);
                RetouchBusiness retouchBusiness = RetouchBusiness.obtenerEntidad();
                List<Retouch> lstRetouch = retouchBusiness.obtenerRetouchByOrderAndClient(idOrder, userBean.getIdUser());
                RetouchXStatusBusiness retouchXStatusBusiness = RetouchXStatusBusiness.obtenerEntidad();
                RetouchXSpecificationBusiness retouchXSpecificationBusiness = RetouchXSpecificationBusiness.obtenerEntidad();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - See Order Photos</title>
        <link rel="icon" type="image/png" href="../images/iconoPR.jpg" />
        <meta name="author" content="Roy Taza Rojas">
        <link href="../css/styles.css" rel="stylesheet" type="text/css" media="screen" />
    </head>
    <body>
        <script>
            function enableSpec() {
                document.getElementById('Specifications').disabled = true;
            }
            function disableSpec() {
                document.getElementById('Specifications').disabled = false;
            }
        </script>
        <div id="bg1">
            <div id="content">
                <!-- header -->
                <%@include file="../template/header.jsp" %>
                <!-- / header -->
                <!-- content -->
                <br><br><br><br>
                <div id="main1">
                    <br>
                    <div id="viewOrder">
                        <!-- / content -->
                        <%
                            if (request.getParameter("idPhoto") != null) {
                                // Verficar que la foto le pertenezaca al cliente respectivo
                                Integer idPhoto = Integer.parseInt(request.getParameter("idPhoto"));
                                Retouch retouch = new Retouch();
                                retouch.setIdRetouch(idPhoto);
                                // CREAR UN PROCEDIMIENTO QUE RECIBA EL ID DE RETOQUE Y EL ID DEL USUARIO   
                                retouch = retouchBusiness.ejecutar(OperacionEnum.OBTENER, retouch);
                                List<RetouchXStatus> listRetouchXStatus = retouchXStatusBusiness.listarByRetouch(idPhoto);
                                for (RetouchXStatus rxs : listRetouchXStatus) {
                                    switch (rxs.getIdStatus()) {
                                        case ConstantesWeb.ID_STATUS_REFERENCE:
                        %>
                        <div id="photoWorking">
                            <img src="../photoResources/photos/<%= retouch.getFileNombre()%>" alt="<%= retouch.getFileNombre()%>-Retouched" width="400"><br />
                            <a style="text-decoration: none" href="../photoResources/photos/<%= retouch.getFileNombre()%>" download="<%= retouch.getFileNombre().substring(userBean.getIdUser().toString().length() + 3)%>" target="_blank">DOWNLOAD</a><br>
                            <label>PHOTO REFERENCE</label><br />
                        </div>
                        <%
                                break;
                            case ConstantesWeb.ID_STATUS_WORKING:
                        %>
                        <div id="photoWorking">
                            <img src="../photoResources/photos/<%= retouch.getFileNombre()%>" alt="<%= retouch.getFileNombre()%>-Retouched" width="400"><br />
                            <a style="text-decoration: none" href="../photoResources/photos/<%= retouch.getFileNombre()%>" download="<%= retouch.getFileNombre().substring(userBean.getIdUser().toString().length() + 3)%>" target="_blank">DOWNLOAD</a><br>
                            <label>STATUS: WORKING</label><br />
                        </div>
                        <br />
                        <%
                                break;
                            case ConstantesWeb.ID_STATUS_REWORKING:
                        %>
                        <div id="photoWorking">
                            <img src="../photoResources/photos/<%= retouch.getFileNombre()%>" alt="<%= retouch.getFileNombre()%>-Retouched" width="400"><br />
                            <a style="text-decoration: none" href="../photoResources/photos/<%= retouch.getFileNombre()%>" download="<%= retouch.getFileNombre().substring(userBean.getIdUser().toString().length() + 3)%>" target="_blank">DOWNLOAD</a><br>
                            <label>STATUS: RE-WORKING</label><br />
                            <%
                                if (request.getParameter("message") != null) {
                            %>
                            <label for="message" style="color: green"><%= request.getParameter("message")%></label><br /><br />
                            <%
                                }
                            %>
                        </div>
                        <br />
                        <%
                                break;
                            case ConstantesWeb.ID_STATUS_REWORKED:
                        %>
                        <div id="photoWorking">
                            <div id="before" style="float: left">
                                <label>BEFORE</label><br>
                                <img src="../photoResources/photos/<%= retouch.getFileNombre()%>" alt="<%= retouch.getFileNombre()%>-Retouched" width="450"><br>
                                <a style="text-decoration: none" href="../photoResources/photos/<%= retouch.getFileNombre()%>" download="<%= retouch.getFileNombre().substring(userBean.getIdUser().toString().length() + 3)%>" target="_blank">DOWNLOAD</a>
                            </div>
                            <div id="after" style="float: right;margin-right: 5px">
                                <label>AFTER</label><br>
                                <img src="../photoResources/photosRetouched/<%= retouch.getFileNombre()%>" alt="<%= retouch.getFileNombre()%>-Retouched" width="450"><br>
                                <a style="text-decoration: none" href="../photoResources/photosRetouched/<%= retouch.getFileNombre()%>" download="<%= retouch.getFileNombre().substring(userBean.getIdUser().toString().length() + 3)%>" target="_blank">DOWNLOAD</a>
                            </div>
                            <br /><br /><br /><br /><br /><br /><br /><br />
                            <label>STATUS: RE-WORKED</label><br />
                            <form method="post" action="../Controller">
                                <input type="hidden" name="action" value="<%=ConstantesWeb.SEND_ANSWER%>" />
                                <input type="hidden" name="idOrder" value="<%= retouch.getIdOrder()%>" />
                                <input type="hidden" name="idPhoto" value="<%= retouch.getIdRetouch()%>" />
                                <input id="rdbApproved" type="radio" name="rdbAnswer" value="A" required onclick="enableSpec()">Approved&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input id="rdbRework" type="radio" name="rdbAnswer" value="R" required onclick="disableSpec()">Rework<br />

                                <textarea id="Specifications" name="txtSpecification" placeholder="Specification" cols="25" rows="5" required></textarea><br />
                                <input id="btnSendAnswer" type="submit" name="btnSendAnswer" value="Send Answer"><br />
                            </form>
                        </div>
                        <br />
                        <%
                                break;
                            case ConstantesWeb.ID_STATUS_APPROVED:
                        %>
                        <div id="photoWorking">
                            <div id="before" style="float: left">
                                <label>BEFORE</label><br>
                                <img src="../photoResources/photos/<%= retouch.getFileNombre()%>" alt="<%= retouch.getFileNombre()%>-Retouched" width="450"><br>
                                <a style="text-decoration: none" href="../photoResources/photos/<%= retouch.getFileNombre()%>" download="<%= retouch.getFileNombre().substring(userBean.getIdUser().toString().length() + 3)%>" target="_blank">DOWNLOAD</a>
                            </div>
                            <div id="after" style="float: right;margin-right: 5px">
                                <label>AFTER</label><br>
                                <img src="../photoResources/photosRetouched/<%= retouch.getFileNombre()%>" alt="<%= retouch.getFileNombre()%>-Retouched" width="450"><br>
                                <a style="text-decoration: none" href="../photoResources/photosRetouched/<%= retouch.getFileNombre()%>" download="<%= retouch.getFileNombre().substring(userBean.getIdUser().toString().length() + 3)%>" target="_blank">DOWNLOAD</a>
                            </div>
                            <br /><br /><br /><br /><br />
                            <form method="post" action="../Controller">
                                <input type="hidden" name="action" value="<%=ConstantesWeb.SEND_ANSWER%>" />
                                <input type="hidden" name="idOrder" value="<%= retouch.getIdOrder()%>" />
                                <input type="hidden" name="idPhoto" value="<%= retouch.getIdRetouch()%>" />
                                <input type="hidden" name="rdbAnswer" value="R" />
                                <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
                                <label style="">If you want to send the order to rework:</label><br />
                                <textarea id="Specifications" name="txtSpecification" placeholder="Specification" cols="25" rows="5" required></textarea><br />
                                <input id="btnSendAnswer" type="submit" name="btnSendAnswer" value="Send to Rework"><br />
                            </form>
                            <br />
                            <%
                                if (request.getParameter("message") != null) {
                            %>
                            <label for="message" style="color: green"><%= request.getParameter("message")%></label><br /><br />
                            <%
                                }
                            %>
                        </div>
                        <%
                                        break;
                                }
                            }
                            // Mostrar las especificaicones de la foto
                            List<RetouchXSpecification> listRetouchXSpecifications
                                    = retouchXSpecificationBusiness.obtenerByAutor(idPhoto, userBean.getIdUser());
                        %>
                        <div id="photoSpecification">
                            <b>Specification:</b>
                            <%
                                if (listRetouchXSpecifications.size() > 0) {
                                    for (RetouchXSpecification rxsItem : listRetouchXSpecifications) {
                                        switch (rxsItem.getIdSpecificationType()) {
                                            case ConstantesWeb.ID_SPECIFICATION_NORMAL:
                            %>
                            <br>
                            <%= rxsItem.getSpecification()%>
                            <%
                                    break;
                                case ConstantesWeb.ID_SPECIFICATION_REFERENCE:
                            %>
                            <br>
                            <%= rxsItem.getSpecification()%>
                            <%
                                    break;
                                case ConstantesWeb.ID_SPECIFICATION_REWORK:
                            %>
                            <br><br>
                            Rework:&nbsp
                            <%= UtilWeb.convertirDate(rxsItem.getDateTimeSpecification(), "MM/dd/yyyy HH:mm:ss")%><br>
                            <%= rxsItem.getSpecification()%>
                            <%
                                            break;
                                    }
                                }
                            } else {
                            %>
                            - - - -
                            <%
                                }
                            %>
                        </div>
                        <br /><br /><br /><br />
                        <%
                            }
                        %>
                        <!-- SHOW ORDER PHOTOS -->
                        <%
                            if (lstRetouch.size() > 0) {
                        %>
                        <a style="float: right;text-decoration: none" href="../Controller?action=<%= ConstantesWeb.DONWLOAD_RETOUCHED_PHOTOS%>&idOrder=<%= orden.getIdOrder()%>" target="_blank"><img src="../images/download-all-files.png" alt="#" height="15">&nbsp;Donwload all retouched photos</a><br>
                        <fieldset style="width: 100%">
                            <legend><h2>Order's Photos</h2></legend>
                            <br>
                            <p style="margin-left: 10px;margin-right: 10px;text-align: justify"><b>Specification:</b> <%= orden.getSpecifications()%></p>
                            <table cellspacing="40" align="center">
                                <%
                                    int i = 1;
                                    boolean aux = true;
                                    for (Retouch r : lstRetouch) {
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
                                        <b><%= UtilWeb.formatName(r.getFileNombre(), userBean.getIdUser().toString().length())%></b><br />
                                        <a href="orderPhotos.jsp?idOrder=<%= idOrder%>&idPhoto=<%= r.getPhotoId()%>"><img src="../photoResources/photos/<%= r.getFileNombre()%>" height="110"></a><br />
                                            <%
                                                List<RetouchXStatus> lstRxS = retouchXStatusBusiness.listarByRetouch(r.getIdRetouch());
                                                for (RetouchXStatus rxs : lstRxS) {
                                                    switch (rxs.getIdStatus()) {
                                                        case ConstantesWeb.ID_STATUS_APPROVED:
                                            %>
                                        <img src="../images/approved.png" alt="approved" height="11" /><label id="photoType" style="color: green"></label>
                                        <%
                                                break;
                                            case ConstantesWeb.ID_STATUS_PAYED:
                                        %>
                                        <img src="../images/approvedAndPayed.png" alt="approved" height="11" /><label id="photoType" style="color: green">Payed</label>
                                        <%
                                                break;
                                            case ConstantesWeb.ID_STATUS_REFERENCE:
                                        %>
                                        <!--img src="../images/reference.png" alt="reference" height="11" /--><label id="photoType">Reference</label>
                                        <%
                                                break;
                                            case ConstantesWeb.ID_STATUS_REWORKED:
                                        %>
                                        <img src="../images/reworked.png" alt="approved" height="11" /><label id="photoType" style="color: green;font-weight: bold;font-size: 16px">Reworked</label>
                                        <%
                                                break;
                                            case ConstantesWeb.ID_STATUS_REWORKING:
                                        %>
                                        <img src="../images/reworking.png" alt="approved" height="11" /><label id="photoType">Reworking</label>
                                        <%
                                                break;
                                            case ConstantesWeb.ID_STATUS_WAITING_ANSWER:
                                        %>
                                        <img src="../images/waitingAnswer.png" alt="approved" height="11" /><label id="photoType" style="color: green;font-weight: bold;font-size: 16px">Waiting Answer</label>
                                        <%
                                                break;
                                            case ConstantesWeb.ID_STATUS_WORKING:
                                        %>
                                        <img src="../images/working.png" alt="approved" height="11" /><label id="photoType">Working</label>
                                        <%
                                                        break;
                                                }
                                            }
                                        %>
                                    </td>
                                    <%
                                            i++;
                                        }
                                    %>
                                </tr>
                            </table>
                        </fieldset>
                        <%
                            }
                        %>
                        <br>
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
            } catch (BusinessException e) {
                response.sendRedirect("errorClient.jsp?message=" + e.getMessage());
            } catch (Exception e) {
                response.sendRedirect("errorClient.jsp?message=" + e.getMessage());
            }
        }
    }
%>