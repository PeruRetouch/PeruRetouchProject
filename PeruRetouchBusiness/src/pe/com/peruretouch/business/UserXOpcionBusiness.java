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
import pe.com.peruretouch.dao.dao.UserXOpcionDao;
import pe.com.peruretouch.dao.util.CoreException;
import pe.com.peruretouch.entity.UserXOpcion;

/**
 *
 * @author Roy Taza Rojas
 */
public final class UserXOpcionBusiness implements BaseBusiness<UserXOpcion> {

    private final static UserXOpcionDao USER_XOPCION_DAO = UserXOpcionDao.obtenerInstancia();
    private final static UserXOpcionBusiness USER_XOPCION_BUSINESS = new UserXOpcionBusiness();

    private UserXOpcionBusiness() {
    }

    public static UserXOpcionBusiness obtenerEntidad() {
        return USER_XOPCION_BUSINESS;
    }

    @Override
    public UserXOpcion ejecutar(OperacionEnum operacionEnum, UserXOpcion userXOpcion) throws BusinessException {
        try {
            if (operacionEnum == OperacionEnum.GUARDAR) {
                USER_XOPCION_DAO.insertar(userXOpcion);
            } else if (operacionEnum == OperacionEnum.ELIMINAR) {
                USER_XOPCION_DAO.eliminar(userXOpcion);
            } else if (operacionEnum == OperacionEnum.OBTENER) {
                userXOpcion = USER_XOPCION_DAO.obtener(userXOpcion);
            } else if (operacionEnum == operacionEnum.ACTUALIZAR) {
                USER_XOPCION_DAO.actualizar(userXOpcion);
            }
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
        return userXOpcion;
    }

    @Override
    public List<UserXOpcion> listar() throws BusinessException {
        try {
            return USER_XOPCION_DAO.listar();
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }

}
