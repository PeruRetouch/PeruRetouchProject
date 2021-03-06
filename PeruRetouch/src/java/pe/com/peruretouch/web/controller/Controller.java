    /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.com.peruretouch.web.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import static java.nio.file.StandardCopyOption.*;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import pe.com.peruretouch.business.*;
import pe.com.peruretouch.business.base.*;
import pe.com.peruretouch.entity.*;
import pe.com.peruretouch.web.bean.*;
import pe.com.peruretouch.web.util.*;

/**
 *
 * @author Roy Taza Rojas
 */
@WebServlet(name = "Controller", urlPatterns = {"/Controller"})
public class Controller extends HttpServlet {

    private final UserBusiness userBusiness = UserBusiness.obtenerEntidad();
    private final ProductBusiness productBusiness = ProductBusiness.obtenerEntidad();
    private final OrdenBusiness ordenBusiness = OrdenBusiness.obtenerEntidad();
    private final OrderXStatusBusiness orderXStatusBusiness = OrderXStatusBusiness.obtenerEntidad();
    private final RetouchXStatusBusiness retouchXStatusBusiness = RetouchXStatusBusiness.obtenerEntidad();
    private final RetouchXSpecificationBusiness retouchXSpecificationBusiness = RetouchXSpecificationBusiness.obtenerEntidad();
    private final ProfileBusiness profileBusiness = ProfileBusiness.obtenerEntidad();
    private final RetouchBusiness retouchBusiness = RetouchBusiness.obtenerEntidad();
    private HttpSession session;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("action");

        switch (accion) {
            case ConstantesWeb.REGISTER_USER:
                this.RegisterUser(request, response);
                break;
            case ConstantesWeb.LOGIN:
                this.Login(request, response);
                break;
            case ConstantesWeb.LOGOUT:
                this.Logout(request, response);
                break;
            case ConstantesWeb.UPLOAD_PHOTOS_CLIENT:
                this.uploadPhotosClient(request, response);
                break;
            case ConstantesWeb.GET_NEW_ORDER:
                this.GetNewOrder(request, response);
                break;
            case ConstantesWeb.EDIT_USER:
                this.EditUser(request, response);
                break;
            case ConstantesWeb.CHANGE_PASSWORD:
                this.ChangePassword(request, response);
                break;
            case ConstantesWeb.SEND_ANSWER:
                this.SendAnswer(request, response);
                break;
            case ConstantesWeb.CONTACT_US_SEND_EMAIL:
                this.ConstactUsSendEmail(request, response);
                break;
            case ConstantesWeb.HELP_CLIENT_SEND_EMAIL:
                this.HelpSendEmail(request, response);
                break;
            case ConstantesWeb.FORGOT_PASSWORD:
                this.ForgotPassword(request, response);
                break;
            case ConstantesWeb.FORGOT_USERNAME:
                this.ForgotUsername(request, response);
                break;
            case ConstantesWeb.MANAGER_PAY_ORDER:
                this.ManagerPayOrder(request, response);
                break;
            case ConstantesWeb.ARTIST_DELETE_REFERENCES_APPROVED_ORDERS:
                this.ArtistDeleteReferencesOfApprovedOrders(request, response);
                break;
            case ConstantesWeb.DONWLOAD_RETOUCHED_PHOTOS:
                this.DonwloadRetouchedPhotos(request, response);
                break;
            case ConstantesWeb.DONWLOAD_ARTIST_PHOTOS:
                this.DonwloadArtistPhotos(request, response);
                break;
            case ConstantesWeb.ORDERS_BETWEEN_DATES:
                this.RedirectOrdersBetweenDates(request, response);
                break;
        }
    }

    protected void Login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String mensaje = "";
        String url = "";
        try {
            UserBean userBean = new UserBean();
            String usuario = request.getParameter("txtUser");
            String clave = Encryptor.encrypt(request.getParameter("txtPassword"));
            if (!usuario.isEmpty() && !clave.isEmpty()) {
                User user = userBusiness.userAuthentication(usuario, clave);
                if (user != null) {
                    userBean.setIdUser(user.getIdUser());
                    userBean.setName(user.getName());
                    userBean.setLastName(user.getLastName());
                    userBean.setIdProfile(user.getIdProfile());
                    userBean.setUserName(user.getUserLogin());
                    userBean.setEmail(user.getEmail());
                    Profile p = new Profile();
                    p.setIdProfile(user.getIdProfile());
                    userBean.setPrivilege(profileBusiness.ejecutar(OperacionEnum.OBTENER, p).getName());
                    if (user.getState().equalsIgnoreCase(ConstantesWeb.STATE_INACTIVE)) {
                        mensaje += "Your account has been disabled";
                        url = "index.jsp?" + ConstantesWeb.MESSAGE + "=" + mensaje;
                    } else if (user.getIdProfile() == ConstantesWeb.ID_CLIENT_PROFILE) {
                        session = request.getSession(true);
                        session.setAttribute(ConstantesWeb.USER_HOME, userBean);
                        session.setMaxInactiveInterval(60 * 60);
                        url = "client/homeClient.jsp";
                    } else if (user.getIdProfile() == ConstantesWeb.ID_ARTIST_PROFILE) {
                        session = request.getSession(true);
                        session.setAttribute(ConstantesWeb.USER_HOME, userBean);
                        session.setMaxInactiveInterval(60 * 60);
                        url = "artist/retouchOrders.jsp";
                    } else if (user.getIdProfile() == ConstantesWeb.ID_SUPERVISOR_PROFILE) {
                        session = request.getSession(true);
                        session.setAttribute(ConstantesWeb.USER_HOME, userBean);
                        session.setMaxInactiveInterval(60 * 60);
                        url = "supervisor/homeSupervisor.jsp";
                    } else if (user.getIdProfile() == ConstantesWeb.ID_MANAGER_PROFILE) {
                        session = request.getSession(true);
                        session.setAttribute(ConstantesWeb.USER_HOME, userBean);
                        session.setMaxInactiveInterval(60 * 60);
                        url = "manager/homeManager.jsp";
                    } else if (user.getIdProfile() == ConstantesWeb.ID_SYSTEM_PROFILE) {
                        session = request.getSession(true);
                        session.setAttribute(ConstantesWeb.USER_HOME, userBean);
                        session.setMaxInactiveInterval(60 * 60);
                        url = "sa/homeSa.jsp";
                    } else {
                        mensaje += "An error has ocurred";
                        url = "index.jsp?" + ConstantesWeb.MESSAGE + "=" + mensaje;
                    }
                } else {
                    mensaje += "User or password incorrect";
                    url = "index.jsp?" + ConstantesWeb.MESSAGE + "=" + mensaje;
                }
            }
            response.sendRedirect(url);
        } catch (BusinessException e) {
            mensaje = e.getMessage();
            url = "error.jsp?" + ConstantesWeb.MESSAGE + "=" + mensaje;
            response.sendRedirect(url);
        } catch (Exception e) {
            mensaje = e.getMessage();
            url = "error.jsp?" + ConstantesWeb.MESSAGE + "=" + mensaje;
            response.sendRedirect(url);
        }
    }

    protected void Logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        session = request.getSession(false);
        PhotosBean photosBean = new PhotosBean();
        photosBean.removeAllPhotosFromTheList(session, getServletContext().getRealPath("/") + ConstantesWeb.FILE_SAVE_PATH_CLIENT);
        if (session != null) {
            if (session.getAttribute(ConstantesWeb.USER_HOME) != null) {
                session.removeAttribute(ConstantesWeb.USER_HOME);
            }
            if (session.getAttribute(ConstantesWeb.PHOTO_LIST) != null) {
                session.removeAttribute(ConstantesWeb.USER_HOME);
            }
            session.invalidate();
        }
        response.sendRedirect("index.jsp");
    }

    protected void RegisterUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String rpta = "";
        String mensaje = "";
        try {
                String userLogin = request.getParameter("txtUserName");
                // Comprobar si el usuario ya existe
                User userAux = new User();
                userAux.setUserLogin(userLogin);
                if (userBusiness.getUserIfExist(userLogin) != null) {
                    rpta = "register.jsp";
                    mensaje = "The username is being used";
                    response.sendRedirect(rpta + "?message=" + mensaje);
                } else {
                    //
                    String password = Encryptor.encrypt(request.getParameter("txtPassword"));
                    String name = request.getParameter("txtName");
                    String lastName = request.getParameter("txtLastName");
                    String email = request.getParameter("txtEmail");
                    String websiteAddress = request.getParameter("txtWebsiteAddress");
                    String address = request.getParameter("txtAddress");
                    String country = request.getParameter("txtCountry");
                    String birthday = request.getParameter("txtBirthday");
                    Date birthdayDate = UtilWeb.convertirString(birthday, "yyyy-MM-dd");
                    String telephone = request.getParameter("txtTelephone");
                    String cellphone = request.getParameter("txtCellphone");
                    Integer idClientProfile = ConstantesWeb.ID_CLIENT_PROFILE;

                    User user = new User(0, userLogin, password, idClientProfile, name, lastName, address, country, birthdayDate, telephone, cellphone, email, websiteAddress, ConstantesWeb.STATE_ACTIVE);
                    userBusiness.ejecutar(OperacionEnum.GUARDAR, user);
                    rpta = "index.jsp";
                    mensaje = "The user has been created succesfully";
                    response.sendRedirect(rpta + "?message=" + mensaje);
                }
        } catch (BusinessException e) {
            rpta = "error.jsp";
            response.sendRedirect(rpta + "?message=" + e.getMessage());
        } catch (Exception e) {
            rpta = "error.jsp";
            response.sendRedirect(rpta + "?message=" + e.getMessage());
        }
    }

    protected void uploadPhotosClient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            session = request.getSession(false);
            PhotosBean photosBean = new PhotosBean();
            if (photosBean.getListPhotos(session).isEmpty()) {
                response.sendRedirect("client/homeClient.jsp");
            } else {
                Date dateTimeUserRequest = new Date();
                /////// CREATE ORDER
                UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
                Product product = new Product();
                product.setIdProduct(Integer.parseInt(request.getParameter("idProduct")));
                product = productBusiness.ejecutar(OperacionEnum.OBTENER, product);
                String orderEpecifications = request.getParameter("txtOrderSpecification");

                Orden orden = new Orden();
                orden.setIdClient(userBean.getIdUser());
                orden.setOrderName(request.getParameter("txtOrderName"));
                orden.setDateTimeClientRequest(dateTimeUserRequest);
                orden.setSpecifications(orderEpecifications);
                orden.setTotal(0D);
                orden.setState(ConstantesWeb.STATE_ACTIVE);

                OrderXStatus orderXStatus1 = new OrderXStatus();
                orderXStatus1.setIdStatus(ConstantesWeb.ID_STATUS_ACTIVE);
                OrderXStatus orderXStatus2 = new OrderXStatus();
                orderXStatus2.setIdStatus(ConstantesWeb.ID_STATUS_NEW);
                // Insert the order and its status in the database
                int idorder = ordenBusiness.insertOrderAndReturnId(orden);
                orderXStatus1.setIdOrder(idorder);
                orderXStatus2.setIdOrder(idorder);
                orderXStatusBusiness.ejecutar(OperacionEnum.GUARDAR, orderXStatus1);
                orderXStatusBusiness.ejecutar(OperacionEnum.GUARDAR, orderXStatus2);

                ////// CREATE RETOUCH and RetouchXSpecification FOR EVERY PHOTO
                Double totalOrder = 0D;
                LinkedHashSet<String> lstPhotos = photosBean.getListPhotos(session);
                String[] lstSpecifications = request.getParameterValues("txtPhotoSpecification");
                String[] lstReferences = request.getParameterValues("chkReference");
                String fileSavePathOrigen = getServletContext().getRealPath("/") + ConstantesWeb.FILE_SAVE_PATH_TEMPORARY;
                String fileSavePathDestino = getServletContext().getRealPath("/") + ConstantesWeb.FILE_SAVE_PATH_CLIENT;
                int idSpecification = ConstantesWeb.ID_SPECIFICATION_NORMAL;
                boolean isReference;
                for (int i = 0; i < lstPhotos.size(); i++) {
                    isReference = false;
                    String photoName = (String) lstPhotos.toArray()[i];
                    Retouch retouch = new Retouch();
                    retouch.setIdOrder(idorder);
                    retouch.setIdProduct(product.getIdProduct());
                    retouch.setIdArtist(ConstantesWeb.ID_ARTIST_NOT_ASSIGNED);
                    retouch.setIdSupervisor(ConstantesWeb.ID_SUPERVISOR_NOT_ASSIGNED);
                    retouch.setDateTimeArtistRequest(dateTimeUserRequest);
                    retouch.setDateTimeUploadRetouch(dateTimeUserRequest);
                    retouch.setFileNombre(photoName);
                    retouch.setPhotoId(idorder);
                    // Verify if the photo is a reference and what kind of
                    // specification would have
                    if (lstReferences != null) {
                        for (String aux : lstReferences) {
                            if (aux.equalsIgnoreCase(photoName)) {
                                retouch.setIdProduct(ConstantesWeb.ID_PRODUCT_REFERENCE);
                                idSpecification = ConstantesWeb.ID_SPECIFICATION_REFERENCE;
                                isReference = true;
                                break;
                            }
                        }
                    }
                    if (!isReference) {
                        idSpecification = ConstantesWeb.ID_SPECIFICATION_NORMAL;
                        totalOrder += product.getPrice();
                    }
                    // Save Retouch in the database
                    int idRetouch = retouchBusiness.insertOrderAndReturnId(retouch);
                    // Check if the photo has specifications
                    String comparation = lstSpecifications[i].replace(" ", "");
                    if (!comparation.equalsIgnoreCase("")) {
                        // Photo has specification, so create RetouchXSpecification
                        RetouchXSpecification rxs = new RetouchXSpecification();
                        rxs.setIdRetouch(idRetouch);
                        rxs.setIdSpecificationType(idSpecification);
                        rxs.setIdAutor(userBean.getIdUser());
                        rxs.setDateTimeSpecification(dateTimeUserRequest);
                        rxs.setSpecification(lstSpecifications[i]);
                        retouchXSpecificationBusiness.ejecutar(OperacionEnum.GUARDAR, rxs);
                    }
                    retouch.setIdRetouch(idRetouch);
                    retouch.setPhotoId(idRetouch);

                    String newFileName = idRetouch + photoName.substring(userBean.getIdUser().toString().length());
                    UtilWeb.renameFile(fileSavePathOrigen, photoName, newFileName);

                    Path source = Paths.get(fileSavePathOrigen + "/" + newFileName);
                    Path destiny = Paths.get(fileSavePathDestino + "/" + newFileName);
                    Files.move(source, destiny, REPLACE_EXISTING);
                    retouch.setFileNombre(newFileName);

                    retouchBusiness.ejecutar(OperacionEnum.ACTUALIZAR, retouch);
                    // Insert Reotuch status
                    if (isReference) {
                        RetouchXStatus rxs1 = new RetouchXStatus(idRetouch, ConstantesWeb.ID_STATUS_ACTIVE);
                        retouchXStatusBusiness.ejecutar(OperacionEnum.GUARDAR, rxs1);
                        RetouchXStatus rxs2 = new RetouchXStatus(idRetouch, ConstantesWeb.ID_STATUS_REFERENCE);
                        retouchXStatusBusiness.ejecutar(OperacionEnum.GUARDAR, rxs2);
                    } else {
                        RetouchXStatus rxs1 = new RetouchXStatus(idRetouch, ConstantesWeb.ID_STATUS_ACTIVE);
                        RetouchXStatus rxs2 = new RetouchXStatus(idRetouch, ConstantesWeb.ID_STATUS_NEW);
                        RetouchXStatus rxs3 = new RetouchXStatus(idRetouch, ConstantesWeb.ID_STATUS_WORKING);
                        retouchXStatusBusiness.ejecutar(OperacionEnum.GUARDAR, rxs1);
                        retouchXStatusBusiness.ejecutar(OperacionEnum.GUARDAR, rxs2);
                        retouchXStatusBusiness.ejecutar(OperacionEnum.GUARDAR, rxs3);
                    }
                }
                orden.setIdOrder(idorder);
                orden.setTotal(totalOrder);
                ordenBusiness.ejecutar(OperacionEnum.ACTUALIZAR, orden);
                photosBean.cleartList2(session);
                response.sendRedirect("client/orderDetail.jsp?order=" + idorder + "&n=" + product.getName());
            }
        } catch (BusinessException ex) {
            response.sendRedirect("client/errorClient.jsp?message=" + ex.getMessage());
        } catch (Exception e) {
            response.sendRedirect("client/errorClient.jsp?message=" + e.getMessage());
        }
    }

    protected void GetNewOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            session = request.getSession(false);
            Date dateTimeUserRequest = new Date();
            UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
            // Get the order
            int idOrder = Integer.parseInt(request.getParameter("idOrder"));
            Orden orden = new Orden();
            orden.setIdOrder(idOrder);
            // Setear la orden ya NO es nueva
            List<OrderXStatus> listOxS = orderXStatusBusiness.listByOrder(idOrder);
            for (OrderXStatus oxs : listOxS) {
                if (oxs.getIdStatus() == ConstantesWeb.ID_STATUS_NEW) {
                    orderXStatusBusiness.ejecutar(OperacionEnum.ELIMINAR, oxs);
                    break;
                }
            }
            // Obtener todas las fotos de la orden y actualizar
            // Retouch
            List<Retouch> listRetouchs = retouchBusiness.listarByOrder(idOrder);
            for (Retouch r : listRetouchs) {
                r.setIdArtist(userBean.getIdUser());
                r.setDateTimeArtistRequest(dateTimeUserRequest);
                retouchBusiness.ejecutar(OperacionEnum.ACTUALIZAR, r);
            }
            response.sendRedirect("artist/retouchOrders.jsp");
        } catch (BusinessException ex) {
            response.sendRedirect("artist/errorArtist.jsp?message=" + ex.getMessage());
        } catch (Exception e) {
            response.sendRedirect("artist/errorArtist.jsp?message=" + e.getMessage());
        }
    }

    protected void ArtistDeleteReferencesOfApprovedOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            session = request.getSession(false);
            UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
            List<Retouch> listRetouchs = retouchBusiness.listarReferencesOfApprovedOrders(userBean.getIdUser());
            for (Retouch retouch : listRetouchs) {
                retouch.setIdArtist(ConstantesWeb.ID_ARTIST_NOT_ASSIGNED);
                retouchBusiness.ejecutar(OperacionEnum.ACTUALIZAR, retouch);
            }
            response.sendRedirect("artist/retouchOrders.jsp");
        } catch (Exception e) {
        }
    }

    protected void EditUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String rpta = "";
        String mensaje = "";
        session = request.getSession(false);
        UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
        try {
            // Setear datos actualizados del usuario
            User userRefresh = new User();
            userRefresh.setIdUser(userBean.getIdUser());
            userRefresh = userBusiness.ejecutar(OperacionEnum.OBTENER, userRefresh);
            userRefresh.setName(request.getParameter("txtName"));
            userRefresh.setLastName(request.getParameter("txtLastName"));
            userRefresh.setEmail(request.getParameter("txtEmail"));
            if (userBean.getIdProfile() == ConstantesWeb.ID_CLIENT_PROFILE) {
                userRefresh.setWebPage(request.getParameter("txtWebsiteAddress"));
            }
            userRefresh.setAddress(request.getParameter("txtAddress"));
            userRefresh.setCountry(request.getParameter("txtCountry"));
            userRefresh.setTelephone(request.getParameter("txtTelephone"));
            userRefresh.setCellphone(request.getParameter("txtCellphone"));
            userBusiness.ejecutar(OperacionEnum.ACTUALIZAR, userRefresh);
            userBean.setName(userRefresh.getName());
            userBean.setLastName(userRefresh.getLastName());
            session.setAttribute(ConstantesWeb.USER_HOME, userBean);
            rpta = userBean.getPrivilege().toLowerCase() + "/viewUserInfo.jsp";
            mensaje = "Changes've been saved succesfully";
            response.sendRedirect(rpta + "?message=" + mensaje);
        } catch (BusinessException e) {
            rpta = userBean.getPrivilege().toLowerCase() + "/errorClient.jsp";
            mensaje = e.getMessage();
            response.sendRedirect(rpta + "?message=" + mensaje);
        } catch (Exception e) {
            rpta = userBean.getPrivilege().toLowerCase() + "/errorClient.jsp";;
            mensaje = e.getMessage();
            response.sendRedirect(rpta + "?message=" + mensaje);
        }
    }

    protected void ChangePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        session = request.getSession(false);
        String rpta = "";
        String mensaje = "";
        UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
        try {
            User user = new User();
            user.setIdUser(userBean.getIdUser());
            user = userBusiness.ejecutar(OperacionEnum.OBTENER, user);
            String currentPassword = Encryptor.encrypt(request.getParameter("txtCurrentPassword"));
            String newPassword = Encryptor.encrypt(request.getParameter("txtNewPassword"));
            String repeatNewPassword = Encryptor.encrypt(request.getParameter("txtRepeatNewPassword"));
            if (user.getPassword().equals(currentPassword)) {
                if (newPassword.equals(repeatNewPassword)) {
                    user.setPassword(newPassword);
                    userBusiness.ejecutar(OperacionEnum.ACTUALIZAR, user);
                    rpta = userBean.getPrivilege().toLowerCase() + "/viewUserInfo.jsp";
                    mensaje = "The password has been changed";
                } else {
                    rpta = userBean.getPrivilege().toLowerCase() + "/changePassword.jsp";
                    mensaje = "Please repeat the new password";
                }
            } else {
                rpta = userBean.getPrivilege().toLowerCase() + "/changePassword.jsp";
                mensaje = "Please enter the correct current password";
            }
            response.sendRedirect(rpta + "?message=" + mensaje);
        } catch (BusinessException e) {
            rpta = userBean.getPrivilege().toLowerCase() + "/error" + userBean.getPrivilege() + ".jsp";
            mensaje = e.getMessage();
            response.sendRedirect(rpta + "?message=" + mensaje);
        } catch (Exception e) {
            rpta = userBean.getPrivilege().toLowerCase() + "/error" + userBean.getPrivilege() + ".jsp";
            mensaje = e.getMessage();
            response.sendRedirect(rpta + "?message=" + mensaje);
        }
    }

    protected void SendAnswer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        session = request.getSession(false);
        String rpta = "";
        String mensaje = "";
        UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
        try {
            User user = new User();
            user.setIdUser(userBean.getIdUser());
            user = userBusiness.ejecutar(OperacionEnum.OBTENER, user);
            int idOrder = Integer.parseInt(request.getParameter("idOrder"));
            int idPhoto = Integer.parseInt(request.getParameter("idPhoto"));
            rpta = "client/orderPhotos.jsp?idOrder=" + idOrder + "&idPhoto=" + idPhoto;
            String answerType = request.getParameter("rdbAnswer");
            if (answerType.equalsIgnoreCase("A")) {
                // Active, Approved
                List<RetouchXStatus> listRetouchXStatus = retouchXStatusBusiness.listarByRetouch(idPhoto);
                for (RetouchXStatus rxs : listRetouchXStatus) {
                    if (rxs.getIdStatus() != ConstantesWeb.ID_STATUS_ACTIVE) {
                        retouchXStatusBusiness.ejecutar(OperacionEnum.ELIMINAR, rxs);
                    }
                }
                RetouchXStatus retouchXStatus = new RetouchXStatus(idPhoto, ConstantesWeb.ID_STATUS_APPROVED);
                retouchXStatusBusiness.ejecutar(OperacionEnum.GUARDAR, retouchXStatus);
                // Verifica si todas las fotos de la ordenhan sido aprobadas
                List<Retouch> lstRetouchs = retouchBusiness.obtenerRetouchByOrderAndClient(idOrder, user.getIdUser());
                int aux = 1;
                for (Retouch retouch : lstRetouchs) {
                    if (retouch.getIdRetouch() != idPhoto) {
                        listRetouchXStatus = retouchXStatusBusiness.listarByRetouch(retouch.getIdRetouch());
                        for (RetouchXStatus rxs : listRetouchXStatus) {
                            if (rxs.getIdStatus() == ConstantesWeb.ID_STATUS_APPROVED || rxs.getIdStatus() == ConstantesWeb.ID_STATUS_REFERENCE) {
                                aux++;
                                break;
                            }
                        }
                    }
                }
                if (aux == lstRetouchs.size()) {
                    List<OrderXStatus> lstOrderXStatuses = orderXStatusBusiness.listByOrder(idOrder);
                    for (OrderXStatus orderXStatus : lstOrderXStatuses) {
                        orderXStatusBusiness.ejecutar(OperacionEnum.ELIMINAR, orderXStatus);
                    }
                    OrderXStatus oxs1 = new OrderXStatus(idOrder, ConstantesWeb.ID_STATUS_ACTIVE);
                    OrderXStatus oxs2 = new OrderXStatus(idOrder, ConstantesWeb.ID_STATUS_APPROVED);
                    orderXStatusBusiness.ejecutar(OperacionEnum.GUARDAR, oxs1);
                    orderXStatusBusiness.ejecutar(OperacionEnum.GUARDAR, oxs2);
                }
                mensaje = "The photo retouch has been approved";
            } else if (answerType.equalsIgnoreCase("R")) {
                // Active, Reworking
                List<RetouchXStatus> listRetouchXStatus = retouchXStatusBusiness.listarByRetouch(idPhoto);
                for (RetouchXStatus rxs : listRetouchXStatus) {
                    if (rxs.getIdStatus() != ConstantesWeb.ID_STATUS_ACTIVE) {
                        retouchXStatusBusiness.ejecutar(OperacionEnum.ELIMINAR, rxs);
                    }
                }
                RetouchXStatus retouchXStatus = new RetouchXStatus(idPhoto, ConstantesWeb.ID_STATUS_REWORKING);
                retouchXStatusBusiness.ejecutar(OperacionEnum.GUARDAR, retouchXStatus);
                RetouchXSpecification retouchXSpecification = new RetouchXSpecification(0,
                        idPhoto, ConstantesWeb.ID_SPECIFICATION_REWORK, user.getIdUser(),
                        new Date(), request.getParameter("txtSpecification"));
                retouchXSpecificationBusiness.ejecutar(OperacionEnum.GUARDAR, retouchXSpecification);
                mensaje = "The photo has been send to rework";
            }

            response.sendRedirect(rpta + "&message=" + mensaje);

        } catch (BusinessException e) {
            rpta = userBean.getPrivilege().toLowerCase() + "/error" + userBean.getPrivilege() + ".jsp";
            mensaje = e.getMessage();
            response.sendRedirect(rpta + "?message=" + mensaje);
        } catch (Exception e) {
            rpta = userBean.getPrivilege().toLowerCase() + "/error" + userBean.getPrivilege() + ".jsp";
            mensaje = e.getMessage();
            response.sendRedirect(rpta + "?message=" + mensaje);
        }
    }

    protected void ConstactUsSendEmail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

        try {
            String destino = "peruretouch@gmail.com";
            String asunto = request.getParameter("txtSubject");

            MimeMessage message = new MimeMessage(sescsion);
            message.setFrom(new InternetAddress((String) properties.get("mail.smtp.mail.sender")));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(destino));
            message.setSubject(asunto);
            message.setContent("<b>De: </b>" + request.getParameter("txtName") + "<br><b>Email: </b>" + request.getParameter("txtEmail") + "<br><br><b>Message: </b><br>" + request.getParameter("txtMessage"), "text/html");
            Transport t = sescsion.getTransport("smtp");
            t.connect((String) properties.get("mail.smtp.user"), (String) properties.get("mail.smtp.password"));
            t.sendMessage(message, message.getAllRecipients());
            t.close();
            response.sendRedirect("contact.jsp?message=sent");
        } catch (MessagingException e) {
            response.sendRedirect("contact.jsp?message=" + e.getMessage());
        }
    }

    protected void ForgotPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String userName = request.getParameter("txtUsername");
            User user = userBusiness.getUserIfExist(userName);
            if (user == null) {
                response.sendRedirect("requestPassword.jsp?type=2&message=The username doesn't exists");
            } else {
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
                String asunto = "New password for " + user.getUserLogin();

                MimeMessage message = new MimeMessage(sescsion);
                message.setFrom(new InternetAddress((String) properties.get("mail.smtp.mail.sender")));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(destino));
                message.setSubject(asunto);
                String newPassword = UtilWeb.newRandomString(new Random(), "123abcdefg456hijklmnop789qrstuvwxyz0", 7);
                user.setPassword(Encryptor.encrypt(newPassword));
                userBusiness.ejecutar(OperacionEnum.ACTUALIZAR, user);
                String mensaje = "Hello " + user.getName() + " " + user.getLastName() + ":<br><br>"
                        + "You have requested a new password for your account <b>" + user.getUserLogin() + "<br>"
                        + "New password: " + newPassword + "</b><br>"
                        + "Use this password to enter to your account.<br><br>"
                        + "If you didn't make this request, please send us a message to <b>peruretouch@gmail.com</b><br><br>"
                        + "Blessings,<br>"
                        + "PERU RETOUCH<br>"
                        + "www.peruretouch.com";
                message.setContent(mensaje, "text/html");
                Transport t = sescsion.getTransport("smtp");
                t.connect((String) properties.get("mail.smtp.user"), (String) properties.get("mail.smtp.password"));
                t.sendMessage(message, message.getAllRecipients());
                t.close();
                response.sendRedirect("requestPassword.jsp?type=1&message=Your new password has been sent to your email.");
            }
        } catch (MessagingException e) {
            response.sendRedirect("requestPassword.jsp?type=2&message=" + e.getMessage());
        } catch (BusinessException e) {
            response.sendRedirect("requestPassword.jsp?type=2&message=" + e.getMessage());
        }
    }

    protected void ForgotUsername(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String eMail = request.getParameter("txtEmail");
            List<User> lstUsers = userBusiness.listarByEmail(eMail);
            if (lstUsers.isEmpty()) {
                response.sendRedirect("requestPassword.jsp?type=2&message=There aren't accounts related to this email");
            } else {
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

                String destino = eMail;
                String asunto = "Peru Retouch - Usernames";
                MimeMessage message = new MimeMessage(sescsion);
                message.setFrom(new InternetAddress((String) properties.get("mail.smtp.mail.sender")));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(destino));
                message.setSubject(asunto);
                String mensaje = "Hello<br><br>"
                        + "You have requested your usernames.<br><br>"
                        + "The following usernames are related to your email:<br>"
                        + "<ul>";
                for (User user : lstUsers) {
                    mensaje += "<li>" + user.getUserLogin() + "</li>";
                }
                mensaje += "</ul>"
                        + "Use one of these usernames to acces to Peru Retouch.<br><br>"
                        + "If you didn't make this request, please send us a message to <b>peruretouch@gmail.com</b><br><br>"
                        + "Blessings,<br>"
                        + "PERU RETOUCH<br>"
                        + "www.peruretouch.com";
                message.setContent(mensaje, "text/html");
                Transport t = sescsion.getTransport("smtp");
                t.connect((String) properties.get("mail.smtp.user"), (String) properties.get("mail.smtp.password"));
                t.sendMessage(message, message.getAllRecipients());
                t.close();
                response.sendRedirect("requestPassword.jsp?type=1&message=The usernames related to this email has been sent to your email.");
            }
        } catch (MessagingException e) {
            response.sendRedirect("requestPassword.jsp?type=2&message=" + e.getMessage());
        } catch (BusinessException e) {
            response.sendRedirect("requestPassword.jsp?type=2&message=" + e.getMessage());
        }
    }

    protected void HelpSendEmail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

        try {
            session = request.getSession(false);
            UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
            String destino = "peruretouch@gmail.com";
            String asunto = request.getParameter("txtSubject");

            MimeMessage message = new MimeMessage(sescsion);
            message.setFrom(new InternetAddress((String) properties.get("mail.smtp.mail.sender")));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(destino));
            message.setSubject(asunto);
            message.setContent("<b>De: </b>" + userBean.getName() + " " + userBean.getLastName()
                    + "<br><b>Usuario: </b>" + userBean.getUserName()
                    + "<br><b>Email: </b>" + userBean.getEmail()
                    + "<br><br><b>Message: </b><br>" + request.getParameter("txtMessage"), "text/html");
            Transport t = sescsion.getTransport("smtp");
            t.connect((String) properties.get("mail.smtp.user"), (String) properties.get("mail.smtp.password"));
            t.sendMessage(message, message.getAllRecipients());
            t.close();
            response.sendRedirect("client/help.jsp?message=sent");
        } catch (MessagingException e) {
            response.sendRedirect("client/help.jsp?message=" + e.getMessage());
        }
    }

    protected void ManagerPayOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        session = request.getSession(false);
        String rpta = "";
        String mensaje = "";
        try {
            int idOrder = Integer.parseInt(request.getParameter("idOrder"));
            Orden orden = new Orden();
            orden.setIdOrder(idOrder);
            List<OrderXStatus> listoOrderXStatuses = orderXStatusBusiness.listByOrder(idOrder);
            for (OrderXStatus orderXStatus : listoOrderXStatuses) {
                if (orderXStatus.getIdStatus() == ConstantesWeb.ID_STATUS_APPROVED) {
                    orderXStatusBusiness.ejecutar(OperacionEnum.ELIMINAR, orderXStatus);
                    OrderXStatus oxs = new OrderXStatus(idOrder, ConstantesWeb.ID_STATUS_PAYED);
                    orderXStatusBusiness.ejecutar(OperacionEnum.GUARDAR, oxs);
                    break;
                }
            }
            rpta = "manager/payOrder.jsp";
            mensaje = "The order " + idOrder + " has been marked as PAYED";
            response.sendRedirect(rpta + "?message=" + mensaje);
        } catch (BusinessException e) {
            rpta = "manager/errorManager.jsp";
            mensaje = e.getMessage();
            response.sendRedirect(rpta + "?message=" + mensaje);
        } catch (Exception e) {
            rpta = "manager/errorManager.jsp";
            mensaje = e.getMessage();
            response.sendRedirect(rpta + "?message=" + mensaje);
        }
    }

    protected void ManagerDisableOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        session = request.getSession(false);
        String rpta = "";
        String mensaje = "";
        try {
            int idOrder = Integer.parseInt(request.getParameter("idOrder"));
            Orden orden = new Orden();
            orden.setIdOrder(idOrder);
            orden = ordenBusiness.ejecutar(OperacionEnum.OBTENER, orden);
            orden.setState("Inactive");
            List<OrderXStatus> listoOrderXStatuses = orderXStatusBusiness.listByOrder(idOrder);
            for (OrderXStatus orderXStatus : listoOrderXStatuses) {
                if (orderXStatus.getIdStatus() == ConstantesWeb.ID_STATUS_PAYED) {
                    orderXStatusBusiness.ejecutar(OperacionEnum.ELIMINAR, orderXStatus);
                }
            }
            rpta = "manager/listOrders.jsp";
            mensaje = "The order " + idOrder + " has been DISABLED";
            response.sendRedirect(rpta + "?message=" + mensaje);
        } catch (BusinessException e) {
            rpta = "manager/errorManager.jsp";
            mensaje = e.getMessage();
            response.sendRedirect(rpta + "?message=" + mensaje);
        } catch (Exception e) {
            rpta = "manager/errorManager.jsp";
            mensaje = e.getMessage();
            response.sendRedirect(rpta + "?message=" + mensaje);
        }
    }

    protected void DonwloadRetouchedPhotos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        session = request.getSession(false);
        String rpta = "";
        String mensaje = "";
        try {
            int idOrder = Integer.parseInt(request.getParameter("idOrder"));
            List<Retouch> listRetouchs = retouchBusiness.listarByOrder(idOrder);
            String fileSavePathDestino = getServletContext().getRealPath("/") + ConstantesWeb.FILE_SAVE_PATH_RETOUCHED;
            String fileSavePathZip = getServletContext().getRealPath("/") + ConstantesWeb.FILE_SAVE_PATH_ZIP_CLIENT;
            String filenameZip = request.getParameter("orderName") + ".zip";
            String resultadoCompresion = UtilZip.generateZipClient(session, listRetouchs, fileSavePathDestino, fileSavePathZip, filenameZip);
            if (!resultadoCompresion.equalsIgnoreCase("invalid")) {
                response.reset();
                ServletOutputStream sOutStream = response.getOutputStream();
                streamBinaryData(filenameZip, fileSavePathZip + "/" + filenameZip, sOutStream, response);
            } else {
                PrintWriter out = response.getWriter();
                response.setContentType("text/html");
                out.println("There aren't retouched photos for this order.");
            }
            File file = new File(fileSavePathZip + "/" + filenameZip);
            file.delete();
        } catch (BusinessException e) {
            rpta = "client/errorClient.jsp";
            mensaje = e.getMessage();
            response.sendRedirect(rpta + "?message=" + mensaje);
        } catch (Exception e) {
            rpta = "client/errorClient.jsp";
            mensaje = e.getMessage();
            response.sendRedirect(rpta + "?message=" + mensaje);
        }
    }

    protected void DonwloadArtistPhotos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        session = request.getSession(false);
        String rpta = "";
        String mensaje = "";
        try {
            UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
            int idOrder = Integer.parseInt(request.getParameter("idOrder"));
            List<Retouch> listRetouchs = retouchBusiness.obtenerRetouchPendienteByOrder(userBean.getIdUser(), idOrder);
            String fileSavePathDestino = getServletContext().getRealPath("/") + ConstantesWeb.FILE_SAVE_PATH_CLIENT;
            String fileSavePathZip = getServletContext().getRealPath("/") + ConstantesWeb.FILE_SAVE_PATH_ZIP_ARTIST;
            String filenameZip = "Order" + idOrder + ".zip";
            String resultadoCompresion = UtilZip.generateZipArtist(session, listRetouchs, fileSavePathDestino, fileSavePathZip, filenameZip);
            if (!resultadoCompresion.equalsIgnoreCase("invalid")) {
                response.reset();
                ServletOutputStream sOutStream = response.getOutputStream();
                streamBinaryData(filenameZip, fileSavePathZip + "/" + filenameZip, sOutStream, response);
            }
            File file = new File(fileSavePathZip + "/" + filenameZip);
            file.delete();
        } catch (Exception e) {
            rpta = "artist/errorArtist.jsp";
            mensaje = e.getMessage();
            response.sendRedirect(rpta + "?message=" + mensaje);
        }
    }

    private void streamBinaryData(String fileName, String filePath, ServletOutputStream outstr, HttpServletResponse resp) throws IOException {
        String ErrorStr = null;

        try {
            BufferedInputStream bis = null;
            BufferedOutputStream bos = null;
            String inFile = filePath;
            int tam = (int) new File(inFile).length();
            bis = new BufferedInputStream(new FileInputStream(inFile));

            try {
                //Asignamos el tipo de fichero zip
                resp.setContentType("application/x-zip-compressed"); //Cualquier mime type
                //Seteamos el tamaño de la respuesta
                resp.setContentLength(tam);
                resp.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\"");

                bos = new BufferedOutputStream(outstr);

                // Bucle para leer de un fichero y escribir en el otro.
                byte[] array = new byte[1000];
                int leidos = bis.read(array);
                while (leidos > 0) {
                    bos.write(array, 0, leidos);
                    leidos = bis.read(array);
                }
            } catch (Exception e) {
                e.printStackTrace();
                ErrorStr = "Error Streaming the Data";
                outstr.print(ErrorStr);
            } finally {
                if (bis != null) {
                    bis.close();
                }
                if (bos != null) {
                    bos.close();
                }
                if (outstr != null) {
                    outstr.flush();
                    outstr.close();
                }
            }
        } catch (Exception e) {
            System.out.println("Fichero no encontrado");
            resp.sendRedirect("fileNotFound.jsp");
        }
    }

    protected void RedirectOrdersBetweenDates(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        session = request.getSession(false);
        UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
        String dateFrom = request.getParameter("dateFrom");
        String dateTo = request.getParameter("dateTo");
        if (userBean.getPrivilege().equalsIgnoreCase("client")) {
            response.sendRedirect("client/ordersClient.jsp?abc=alert&from=" + dateFrom + "&to=" + dateTo);
        } else if (userBean.getPrivilege().equalsIgnoreCase("artist")) {
        }
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
