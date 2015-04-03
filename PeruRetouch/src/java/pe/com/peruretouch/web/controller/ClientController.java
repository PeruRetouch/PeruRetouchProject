package pe.com.peruretouch.web.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import pe.com.peruretouch.business.*;
import pe.com.peruretouch.business.base.*;
import pe.com.peruretouch.entity.*;
import pe.com.peruretouch.web.util.*;

@WebServlet(name = "ClientController", urlPatterns = {"/ClientController"})
public class ClientController extends HttpServlet {

    private final UserBusiness userBusiness = UserBusiness.obtenerEntidad();
    private HttpSession session;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("action");

        switch (accion) {
            case "search":
                this.SearchClient(request, response);
                break;
            case "new":
                this.NewClient(request, response);
                break;
            case "edit":
                this.EditClient(request, response);
                break;
            case "delete":
                this.DeleteClient(request, response);
                break;
            case "change":
                this.ChangePass(request, response);
                break;
            case "savePass":
                this.ChangePassword(request, response);
                break;
            case "save":
                this.SaveClient(request, response);
                break;
            case "cancelSave":
                String url = "manager/listClient.jsp";
                response.sendRedirect(url);
                break;
        }
    }

    protected void SearchClient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userName = request.getParameter("txtUserName")==null?"":request.getParameter("txtUserName").toString().trim();
        String name = request.getParameter("txtName")==null?"":request.getParameter("txtName").toString().trim();
        String lastName = request.getParameter("txtLastName")==null?"":request.getParameter("txtLastName").toString().trim();
        String mensaje = "";
        request.setAttribute("txtUserName", userName);
        String url = "manager/listClient.jsp";
        try {
            User user = new User();
            user.setUserLogin(userName);
            user.setName(name);
            user.setLastName(lastName);
            user.setIdProfile(ConstantesWeb.ID_CLIENT_PROFILE);
            List<User> list = userBusiness.searchUser(user);
            response.sendRedirect(url);
            session = request.getSession(true);
            session.setAttribute(ConstantesWeb.LIST, list);
            session.setMaxInactiveInterval(60 * 60);
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
    
    protected void NewClient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = new User();
        session = request.getSession(true);
        session.setAttribute(ConstantesWeb.USER, user);
        session.setMaxInactiveInterval(60 * 60);
        String url = "manager/editClient.jsp";
        response.sendRedirect(url);
    }
    
    protected void EditClient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "manager/editClient.jsp";
        Integer IdUser = (request.getParameter("idUser")==null)?0:
                Integer.parseInt(request.getParameter("idUser").toString().trim());
        String mensaje = "";
        try {
            User user = new User();
            user.setIdUser(IdUser);
            user = userBusiness.ejecutar(OperacionEnum.OBTENER, user);
            session = request.getSession(true);
            session.setAttribute(ConstantesWeb.USER, user);
            session.setMaxInactiveInterval(60 * 60);
            response.sendRedirect(url);
        } catch (BusinessException e) {
            mensaje = e.getMessage();
            url = "manager/editClient.jsp?" + ConstantesWeb.MESSAGE + "=" + mensaje;
            response.sendRedirect(url);
        } catch (Exception e) {
            mensaje = e.getMessage();
            url = "error.jsp?" + ConstantesWeb.MESSAGE + "=" + mensaje;
            response.sendRedirect(url);
        }
    }
    
    protected void ChangePass(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "manager/changePassword.jsp";
        Integer IdUser = (request.getParameter("idUser")==null)?0:
                Integer.parseInt(request.getParameter("idUser").toString().trim());
        String mensaje = "";
        try {
            User user = new User();
            user.setIdUser(IdUser);
            user = userBusiness.ejecutar(OperacionEnum.OBTENER, user);
            session = request.getSession(true);
            session.setAttribute(ConstantesWeb.USER, user);
            session.setMaxInactiveInterval(60 * 60);
            response.sendRedirect(url);
        } catch (BusinessException e) {
            mensaje = e.getMessage();
            url = "manager/editClient.jsp?" + ConstantesWeb.MESSAGE + "=" + mensaje;
            response.sendRedirect(url);
        } catch (Exception e) {
            mensaje = e.getMessage();
            url = "error.jsp?" + ConstantesWeb.MESSAGE + "=" + mensaje;
            response.sendRedirect(url);
        }
    }
    
    protected void DeleteClient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "manager/listClient.jsp";
        Integer IdUser = (request.getParameter("idUser")==null)?0:
                Integer.parseInt(request.getParameter("idUser").toString().trim());
        String mensaje = "";
        try {
            User user = new User();
            user.setIdUser(IdUser);
            user = userBusiness.ejecutar(OperacionEnum.ELIMINAR, user);
            session = request.getSession(true);
            session.setAttribute(ConstantesWeb.USER, user);
            session.setMaxInactiveInterval(60 * 60);
            response.sendRedirect(url);
        } catch (BusinessException e) {
            mensaje = e.getMessage();
            url = "manager/listClient.jsp?" + ConstantesWeb.MESSAGE + "=" + mensaje;
            response.sendRedirect(url);
        } catch (Exception e) {
            mensaje = e.getMessage();
            url = "error.jsp?" + ConstantesWeb.MESSAGE + "=" + mensaje;
            response.sendRedirect(url);
        }
    }
    
    protected void ChangePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        session = request.getSession(false);
        String rpta = "manager/listClient.jsp";
        String mensaje = "";
        Integer IdUser = (request.getParameter("txtIdUser")==null)?0:
                Integer.parseInt(request.getParameter("txtIdUser").toString().trim());
        System.out.println("IdUser"+IdUser);
        try {
            User user = new User();
            user.setIdUser(IdUser);
            user = userBusiness.ejecutar(OperacionEnum.OBTENER, user);
            System.out.println("IdUser"+IdUser);
            System.out.println("IdUser"+request.getParameter("txtPassword"));
            System.out.println("IdUser"+request.getParameter("txtPasswordR"));
            String newPassword = Encryptor.encrypt(request.getParameter("txtPassword"));
            String repeatNewPassword = Encryptor.encrypt(request.getParameter("txtPasswordR"));
            if (newPassword.equals(repeatNewPassword)) {
                user.setPassword(newPassword);
                userBusiness.ejecutar(OperacionEnum.ACTUALIZAR, user);
                mensaje = "The password has been changed";
            } else {
                mensaje = "Please repeat the new password";
                rpta = "manager/changePassword.jsp";
            }
            response.sendRedirect(rpta + "?message=" + mensaje);
        } catch (BusinessException e) {
            mensaje = e.getMessage();
            response.sendRedirect(rpta + "?message=" + mensaje);
        } catch (Exception e) {
            mensaje = e.getMessage();
            response.sendRedirect(rpta + "?message=" + mensaje);
        }
    }
    
    protected void SaveClient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer IdUser = (request.getParameter("IdUser")==null||request.getParameter("IdUser").compareTo("")==0)?0:
                Integer.parseInt(request.getParameter("IdUser").toString().trim());
        String userName = request.getParameter("txtUserName")==null?"":request.getParameter("txtUserName").toString().trim();
        String name = request.getParameter("txtName")==null?"":request.getParameter("txtName").toString().trim();
        String lastName = request.getParameter("txtLastName")==null?"":request.getParameter("txtLastName").toString().trim();
        String address = request.getParameter("txtAddress")==null?"":request.getParameter("txtAddress").toString().trim();
        String country = request.getParameter("txtCountry")==null?"":request.getParameter("txtCountry").toString().trim();
        String birthday = request.getParameter("txtBirthDay");
        Date birthdayDate = UtilWeb.convertirString(birthday, "yyyy-MM-dd");
        String telephone = request.getParameter("txtTelephone")==null?"":request.getParameter("txtTelephone").toString().trim();
        String cellphone = request.getParameter("txtCellphone")==null?"":request.getParameter("txtCellphone").toString().trim();
        Integer idClientProfile = ConstantesWeb.ID_CLIENT_PROFILE;
        String email = request.getParameter("txtEmail")==null?"":request.getParameter("txtEmail").toString().trim();
        String websiteAddress = request.getParameter("txtWebPage")==null?"":request.getParameter("txtWebPage").toString().trim();
        String mensaje = "";
        String url = "manager/listClient.jsp";
        try {
            User user = new User(IdUser, userName, Encryptor.encrypt(userName), idClientProfile, name, lastName, address, country, birthdayDate, telephone, cellphone, email, websiteAddress, ConstantesWeb.STATE_ACTIVE);
            session = request.getSession(true);
            session.setAttribute(ConstantesWeb.USER, user);
            session.setMaxInactiveInterval(60 * 60);
            if(IdUser==0){
                if(userBusiness.getUserIfExist(userName)!=null){
                    mensaje = "The user login already exist";
                    url = "manager/editClient.jsp";
                }else{
                    userBusiness.ejecutar(OperacionEnum.GUARDAR, user);
                    mensaje = "The user has been created succesfully";
                    session = request.getSession(true);
                    session.setAttribute(ConstantesWeb.LIST, null);
                    session.setMaxInactiveInterval(60 * 60);
                }
            }else{
                userBusiness.ejecutar(OperacionEnum.ACTUALIZARSPASS, user);
                mensaje = "The user has been updated succesfully";
                session = request.getSession(true);
                session.setAttribute(ConstantesWeb.LIST, null);
                session.setMaxInactiveInterval(60 * 60);
            }
            response.sendRedirect(url + "?message=" + mensaje);
        } catch (BusinessException e) {
            e.printStackTrace();
            mensaje = e.getMessage();
            url = "manager/editClient.jsp?" + ConstantesWeb.MESSAGE + "=" + mensaje;
            response.sendRedirect(url);
        } catch (Exception e) {
            e.printStackTrace();
            mensaje = e.getMessage();
            url = "error.jsp?" + ConstantesWeb.MESSAGE + "=" + mensaje;
            response.sendRedirect(url);
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
