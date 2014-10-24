<%-- 
    Document   : upload
    Created on : 20/08/2014, 08:30:21 AM
    Author     : Usuario
--%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="pe.com.peruretouch.web.bean.UserBean"%>
<%@page import="pe.com.peruretouch.web.util.ConstantesWeb"%>
<%@page import="pe.com.peruretouch.web.bean.PhotosBean"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.Part"%>
<%@page import="com.oreilly.servlet.multipart.FilePart"%>
<%@page import="com.oreilly.servlet.multipart.MultipartParser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form method="post" action="upload.jsp" name="upform" enctype="multipart/form-data">
            <%
                String fileSavePath;
                String UPLOAD_DIRECTORY = "photoResources/photos";
                UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
                // idClient - fileName - dateTime
                // Guardar las fotos en el directorio "" de la aplicacion web
                fileSavePath = getServletContext().getRealPath("/") + UPLOAD_DIRECTORY;
                // Se crea la carpeta si esta no existe
                if (!(new File(fileSavePath)).exists()) {
                    (new File(fileSavePath)).mkdir();
                }

                try {
                    // Tamanio limite de la foto de 1GB
                    MultipartParser parser = new MultipartParser(request, 1024 * 1024 * 1024);
                    Part _part;
                    while ((_part = parser.readNextPart()) != null) {
                        if (_part.isFile()) {
                            FilePart fPart = (FilePart) _part;  // get some info about the file
                            String fileName = fPart.getFileName();
                            if (fileName != null) {
                                String newFileName = userBean.getIdUser() + " - " + fPart.getFileName();
                                //if (PhotosBean.addPhotoToList(newFileName)) {
                                if (PhotosBean.addPhotoToList(session, fileName)) {
                                    //  fPart.writeTo(new File(fileSavePath));
                                    File newPhoto = new File(fileSavePath);
                                    fPart.writeTo(newPhoto);
                                    // Renombra el archivo
                                    String pathFileA = fileSavePath + "/" + fileName;
                                    String pathFileB = fileSavePath + "/" + newFileName;
                                    File aaa = new File(pathFileA);
                                    File bbb = new File(pathFileB);
                                    aaa.renameTo(bbb);
                                }
                            }
                        }
                    }// end while 
                } catch (java.io.InvalidObjectException ioe) {
                    out.println(ioe.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
        </form>
    </body>
</html>
