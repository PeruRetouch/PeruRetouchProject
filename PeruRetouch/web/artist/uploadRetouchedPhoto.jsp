<%-- 
    Document   : uploadRetouchedPhoto
    Created on : 23/09/2014, 11:32:52 AM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.business.ProductBusiness"%>
<%@page import="pe.com.peruretouch.web.bean.PhotosBean"%>
<%@page import="pe.com.peruretouch.web.bean.UserBean"%>
<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute(ConstantesWeb.USER_HOME) == null) {
        response.sendRedirect("../index.jsp");
    } else {
        UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
        if (userBean.getPrivilege().equalsIgnoreCase("client")) {
            response.sendRedirect("../client/homeClient.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("supervisor")) {
            response.sendRedirect("../supervisor/homeSupervisor.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("manager")) {
            response.sendRedirect("../manager/homeManager.jsp");
        } else if (userBean.getPrivilege().equalsIgnoreCase("sa")) {
            response.sendRedirect("../sa/homeSa.jsp");
        } else {
            try {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - Upload Retouched Photos</title>
        <link rel="icon" type="image/png" href="../images/iconoPR.jpg" />
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
    </head>
    <body>
        <div id="bg1">
            <div id="content">
                <!-- header -->
                <%@include file="../template/header.jsp" %>
                <!-- / header -->
                <!-- content -->
                <br><br><br>
                <div id="main1">
                    <div id="uploadFiles">
                        <h3>Upload Retouched Photos</h3>
                        <br>
                        <p>Upload the photos that has been retouched.</p>
                        <p>By clicking Start Upload the photos will be sent to the client.</p>
                        <p>Please, be sure about the photo names; if not , the system won't reconigze them.</p>
                        <br>
                        <br>
                        <br>
                        <div id="uploader">
                            <p>Your browser doesn't have Flash, Silverlight or HTML5 support.</p>
                        </div>
                        <br>
                    </div>
                    <br><br><br><br>
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
                    url: '../plupload/ArtistUploadUtilWeb.jsp',
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

            } catch (Exception e) {
                response.sendRedirect("errorClient.jsp?message=" + e.getMessage());
            }
        }
    }
%>

