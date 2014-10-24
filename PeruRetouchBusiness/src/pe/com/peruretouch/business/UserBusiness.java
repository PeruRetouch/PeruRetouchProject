/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.com.peruretouch.business;

import java.util.List;
import pe.com.peruretouch.business.base.BaseBusiness;
import pe.com.peruretouch.business.base.BusinessException;
import pe.com.peruretouch.business.base.OperacionEnum;
import pe.com.peruretouch.dao.dao.UserDao;
import pe.com.peruretouch.dao.util.CoreException;
import pe.com.peruretouch.entity.User;

/**
 *
 * @author Roy Taza Rojas
 */
public final class UserBusiness implements BaseBusiness<User> {

    private final static UserDao USER_DAO = UserDao.obtenerInstancia();
    private final static UserBusiness USER_BUSINESS = new UserBusiness();

    private UserBusiness() {
    }

    public static UserBusiness obtenerEntidad() {
        return USER_BUSINESS;
    }

    @Override
    public User ejecutar(OperacionEnum operacionEnum, User user) throws BusinessException {
        try {
            if (operacionEnum == OperacionEnum.GUARDAR) {
                if (user.getIdUser() == null || user.getIdUser() <= 0) {
                    USER_DAO.insertar(user);
                } else {
                    USER_DAO.actualizar(user);
                }
            } else if (operacionEnum == OperacionEnum.ELIMINAR) {
                USER_DAO.eliminar(user);
            } else if (operacionEnum == OperacionEnum.OBTENER) {
                user = USER_DAO.obtener(user);
            } else if (operacionEnum == OperacionEnum.ACTUALIZAR) {
                USER_DAO.actualizar(user);
            }
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
        return user;
    }

    @Override
    public List<User> listar() throws BusinessException {
        try {
            return USER_DAO.listar();
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }

    public User userAuthentication(String userLogin, String password) throws BusinessException {
        try {
            return USER_DAO.userAuthentication(userLogin, password);
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }

    public User getUserIfExist(String userName) throws BusinessException {
        try {
            return USER_DAO.getUserIfExist(userName);
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }

    public List<User> listarByEmail(String eMail) throws BusinessException {
        try {
            return USER_DAO.listarByEmail(eMail);
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }
}
