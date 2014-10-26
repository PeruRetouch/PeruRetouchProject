<%-- 
    Document   : uploadPhotos
    Created on : 19/09/2014, 09:58:55 AM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.business.base.OperacionEnum"%>
<%@page import="pe.com.peruretouch.entity.Product"%>
<%@page import="pe.com.peruretouch.business.ProductBusiness"%>
<%@page import="pe.com.peruretouch.web.bean.PhotosBean"%>
<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    if (session.getAttribute(ConstantesWeb.USER_HOME) == null) {
        response.sendRedirect("../index.jsp");
    } else if (request.getParameter("idProduct") == null) {
        response.sendRedirect("chooseProduct.jsp");
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
                ProductBusiness productBusiness = ProductBusiness.obtenerEntidad();
                Product product = new Product();
                product.setIdProduct(Integer.parseInt(request.getParameter("idProduct")));
                product = productBusiness.ejecutar(OperacionEnum.OBTENER, product);
                if (product.getIdProduct() == ConstantesWeb.ID_PRODUCT_REFERENCE) {
                    response.sendRedirect("chooseProduct.jsp");
                } else {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - Upload Photos</title>
        <meta name="author" content="Roy Taza Rojas">
        <link href="../css/styles.css" rel="stylesheet" type="text/css" media="screen" />
        <!-- PLUPLOAD IMPORTS-->
        <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/themes/base/jquery-ui.css" type="text/css" />
        <link rel="stylesheet" href="../plupload/jquery.ui.plupload.css" type="text/css" />

        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>

        <script type="text/javascript" src="../plupload/plupload.full.min.js"></script>
        <script type="text/javascript" src="../plupload/jquery.ui.plupload.min.js"></script>
        <script type="text/javascript" src="../plupload/uploadScript.js.js"></script>
        <!-- PLUPLOAD IMPORTS-->

        <!--script>
            var bPreguntar = false;
            window.onbeforeunload = preguntarAntesDeSalir;

            function preguntarAntesDeSalir() {
                if (bPreguntar)
                    return "Are you sure you want to leave?";
            }
        </script-->
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
                <!-- / header -->
                <!-- content -->
                <br><br><br><br><br><br>
                <div id="main1">
                    <div id="uploadFiles">
                        <h3><%= product.getName()%></h3>
                        <br>
                        <p style="text-align: justify"><%= product.getDescription()%></p>
                        <br>
                        <p><img src="../images/dollar.png" alt="#"> Price per photo : $<%= product.getPrice()%></p>
                        <br>
                        <br>
                        <br>
                        <p>Choose the photos to be retouched. <label style="font-size: 15px">(You can upload photo references. Photo references does NOT have price.)</label></p>
                        <br>
                        <div id="uploader">
                            <p>Your browser doesn't have Flash, Silverlight or HTML5 support.</p>
                        </div>
                        <br>
                    </div>
                    <br>
                    <div id="buttonsUploadFiles" style="margin-left: 12px;margin-right: 12px">
                        <!--button onclick="location.href = 'chooseProduct.jsp';" name="btnCancel" style="float: left;" ><img src="../images/cancel.png" alt="Cancel" height="50"></button-->
                        <a href="chooseProduct.jsp" style="float: left;" ><img src="../images/cancel.png" alt="Cancel" height="40"></a>
                        <form id="form" method="post" action="addSpecifications.jsp?idProduct=<%= product.getIdProduct()%>" >
                            <input type="image" src="../images/continue.png" name="btnContinue" style="float: right;margin-top: -10px;" height="70" alt="Continue"/>
                            <!--a href="chooseProduct.jsp" style="float: left;" ><img src="../images/continue.png" alt="Cancel" height="50"></a-->
                        </form>
                    </div>
                    <!-- / content -->
                    <!-- footer -->
                </div>
                <%@include file="../template/footer.jsp" %>
            </div>
        </div>
        <script type="text/javascript">
            // Initialize the widget when the DOM is ready
            $(function() {
                $("#uploader").plupload({
                    // General settings
                    runtimes: 'html5,flash,silverlight,html4',
                    url: '../plupload/UploadFilesUtilWeb.jsp',
                    // User can upload no more then 20 files in one go (sets multiple_queues to false)
                    multiple_queues: true,
                    // I don't to chunk the files
                    //chunk_size: '1024mb',
                    //unique_names: true,
                    filters: {
                        // Avoid reoeted files
                        prevent_duplicates: true,
                        // Maximum file size
                        max_file_size: '1024mb',
                        // Specify what files to browse for
                        mime_types: [
                            {title: "Image files", extensions: "jpg,gif,png,tiff,bmp"}
                        ]
                    },
                    // Rename files by clicking on their titles
                    rename: false,
                    // Sort files
                    sortable: true,
                    // Enable ability to drag'n'drop files onto the widget (currently only HTML5 supports that)
                    dragdrop: true,
                    // Views to activate
                    views: {
                        list: true,
                        thumbs: true, // Show thumbs
                        active: 'thumbs'
                    },
                    // Flash settings
                    flash_swf_url: 'http://rawgithub.com/moxiecode/moxie/master/bin/flash/Moxie.cdn.swf',
                    // Silverlight settings
                    silverlight_xap_url: 'http://rawgithub.com/moxiecode/moxie/master/bin/silverlight/Moxie.cdn.xap'
                });

                // Handle the case when form was submitted before uploading has finished
                $('#form').submit(function(e) {
                    // Files in queue upload them first

                    if ($('#uploader').plupload('getFiles').length > 0) {
                        // When all files are uploaded submit form
                        $('#uploader').on('complete', function() {
                            $('#form')[0].submit();
                        });

                        $('#uploader').plupload('start');
                    } else {
                        alert("You must have at least one file in the queue.");
                    }
                    return false; // Keep the form from submitting
                });
            });
        </script>
    </body>
</html>
<%
                }
            } catch (Exception e) {
                response.sendRedirect("errorClient.jsp?message=" + e.getMessage());
            }
        }
    }
%>
