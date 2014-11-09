<%-- 
    Document   : artistUploadUtilWeb
    Created on : 29/09/2014, 06:36:40 PM
    Author     : Roy Taza Rojas
--%>

<%@page import="pe.com.peruretouch.entity.OrderXStatus"%>
<%@page import="pe.com.peruretouch.business.OrderXStatusBusiness"%>
<%@page import="pe.com.peruretouch.entity.Orden"%>
<%@page import="pe.com.peruretouch.business.OrdenBusiness"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.Transport"%>
<%@page import="pe.com.peruretouch.web.util.UtilWeb"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="pe.com.peruretouch.business.UserBusiness"%>
<%@page import="pe.com.peruretouch.entity.User"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page import="pe.com.peruretouch.business.base.BusinessException"%>
<%@page import="pe.com.peruretouch.business.base.OperacionEnum"%>
<%@page import="pe.com.peruretouch.business.RetouchXStatusBusiness"%>
<%@page import="pe.com.peruretouch.entity.RetouchXStatus"%>
<%@page import="pe.com.peruretouch.business.RetouchBusiness"%>
<%@page import="pe.com.peruretouch.entity.Retouch"%>
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
                UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
                String fileSavePath;
                String UPLOAD_DIRECTORY = "photoResources/photosRetouched";
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
                                // Con el fileName buscarlo en la base de datos si existe
                                RetouchBusiness rb = RetouchBusiness.obtenerEntidad();
                                Retouch retouch = rb.obtenerRetouchPendienteByFileNombreAndArtist(fileName, userBean.getIdUser());
                                //Retouch retouch2 = rb.obtenerByFileNombre(fileName);    
                                if (retouch != null) {
                                    RetouchXStatusBusiness retouchXStatusBusiness = RetouchXStatusBusiness.obtenerEntidad();
                                    List<RetouchXStatus> listRxS = retouchXStatusBusiness.listarByRetouch(retouch.getPhotoId());
                                    // Una foto solo puede ser new o rework
                                    // New
                                    // POR EL MOMENTO NO SE CONSIDERA EL ESTADO "Review"
                                    // YA QUE PARA ESTA ENTREGA NO SE CONSIDERA AL SUPERVISOR
                                    for (RetouchXStatus rxs : listRxS) {
                                        // Se setean convenientemente los estados de la foto
                                        if (rxs.getIdStatus() == ConstantesWeb.ID_STATUS_NEW) {
                                            retouchXStatusBusiness.ejecutar(OperacionEnum.ELIMINAR, rxs);
                                            rxs.setIdStatus(ConstantesWeb.ID_STATUS_WORKING);
                                            retouchXStatusBusiness.ejecutar(OperacionEnum.ELIMINAR, rxs);
                                            rxs.setIdStatus(ConstantesWeb.ID_STATUS_APPROVED);
                                            retouchXStatusBusiness.ejecutar(OperacionEnum.GUARDAR, rxs);
                                            break;
                                        } else if (rxs.getIdStatus() == ConstantesWeb.ID_STATUS_WORKING) {
                                            retouchXStatusBusiness.ejecutar(OperacionEnum.ELIMINAR, rxs);
                                            rxs.setIdStatus(ConstantesWeb.ID_STATUS_NEW);
                                            retouchXStatusBusiness.ejecutar(OperacionEnum.ELIMINAR, rxs);
                                            rxs.setIdStatus(ConstantesWeb.ID_STATUS_APPROVED);
                                            retouchXStatusBusiness.ejecutar(OperacionEnum.GUARDAR, rxs);
                                            break;
                                        } else if (rxs.getIdStatus() == ConstantesWeb.ID_STATUS_REWORKING) {
                                            retouchXStatusBusiness.ejecutar(OperacionEnum.ELIMINAR, rxs);
                                            rxs.setIdStatus(ConstantesWeb.ID_STATUS_REWORKED);
                                            retouchXStatusBusiness.ejecutar(OperacionEnum.GUARDAR, rxs);
                                            break;
                                        }
                                    }
                                    // Subo la foto
                                    File newPhoto = new File(fileSavePath);
                                    fPart.writeTo(newPhoto);
                                    // ENVIAR CORREO
                                    // Verificar si todas las fotos de la orden han sido enviadas
                                    int contador = 0;
                                    List<Retouch> listRetouchs = rb.listarByOrder(retouch.getIdOrder());
                                    for (Retouch ret : listRetouchs) {
                                        listRxS = retouchXStatusBusiness.listarByRetouch(ret.getPhotoId());
                                        for (RetouchXStatus rxs : listRxS) {
                                            if (rxs.getIdStatus() == ConstantesWeb.ID_STATUS_REWORKED) {
                                                contador++;
                                                break;
                                            } else if (rxs.getIdStatus() == ConstantesWeb.ID_STATUS_REFERENCE) {
                                                contador++;
                                                break;
                                            } else if (rxs.getIdStatus() == ConstantesWeb.ID_STATUS_APPROVED) {
                                                contador++;
                                                break;
                                            }
                                        }
                                    }
                                    // Envio correo si se cumplen las condiciones
                                    if (contador == listRetouchs.size()) {
                                        OrdenBusiness ordenBusiness = OrdenBusiness.obtenerEntidad();
                                        Orden orden = new Orden();
                                        orden.setIdOrder(retouch.getIdOrder());
                                        orden = ordenBusiness.ejecutar(OperacionEnum.OBTENER, orden);
                                        UserBusiness userBusiness = UserBusiness.obtenerEntidad();
                                        User user = new User();
                                        user.setIdUser(orden.getIdClient());
                                        user = userBusiness.ejecutar(OperacionEnum.OBTENER, user);
                                        
                                        /*
                                        //ACA habria que modificar el o los estados de la orden.
                                        OrderXStatusBusiness orderXStatusBusiness = OrderXStatusBusiness.obtenerEntidad();
                                        List<OrderXStatus> listOrderXStatuses = orderXStatusBusiness.listByOrder(orden.getIdOrder());
                                        for(OrderXStatus oxs : listOrderXStatuses) {
                                            
                                        }
                                        */
                                        
                                        Properties properties = new Properties();
                                        Session sescsion;

                                        properties.put("mail.smtp.host", "smtp.gmail.com");
                                        properties.put("mail.smtp.starttls.enable", "true");
                                        properties.put("mail.smtp.port", 587);
                                        properties.put("mail.smtp.mail.sender", "peruretouch@gmail.com");
                                        properties.put("mail.smtp.password", "soberanaorden1");
                                        properties.put("mail.smtp.user", "peruretouch@gmail.com");
                                        properties.put("mail.smtp.auth", "true");
                                        sescsion = Session.getDefaultInstance(properties);

                                        String destino = user.getEmail();
                                        String asunto = "Order #" + retouch.getIdOrder() + " - Photos retouched";

                                        MimeMessage message = new MimeMessage(sescsion);
                                        message.setFrom(new InternetAddress((String) properties.get("mail.smtp.mail.sender")));
                                        message.addRecipient(Message.RecipientType.TO, new InternetAddress(destino));
                                        message.setSubject(asunto);
                                        String mensaje = "Hello " + user.getName() + " " + user.getLastName() + ":<br><br>"
                                                + "The photos of the order #" + retouch.getIdOrder() + " have been retouched.<br>"
                                                + "Please, enter to your account <b> " + user.getUserLogin() + " </b> so you could review our work.<br>"
                                                + "Account: <b>" + user.getUserLogin() + "</b><br>"
                                                + "<br><br>"
                                                + "If you have some questions please send a message to <b>peruretouch@gmail.com</b><br>"
                                                + "Blessings,<br>"
                                                + "PERU RETOUCH<br>"
                                                + "www.peruretouch.com";
                                        message.setContent(mensaje, "text/html");
                                        Transport t = sescsion.getTransport("smtp");
                                        t.connect((String) properties.get("mail.smtp.user"), (String) properties.get("mail.smtp.password"));
                                        t.sendMessage(message, message.getAllRecipients());
                                        t.close();
                                    }
                                }
                            }
                        }
                    }
                }// end while 
                catch (MessagingException e) {
                    out.println(e.getMessage());
                } catch (java.io.InvalidObjectException ioe) {
                    out.println(ioe.getMessage());
                } catch (BusinessException e) {
                    out.println(e.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
        </form>
    </body>
</html>

