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
import pe.com.peruretouch.dao.dao.RetouchXStatusDao;
import pe.com.peruretouch.dao.util.CoreException;
import pe.com.peruretouch.entity.RetouchXStatus;

/**
 *
 * @author Roy Taza Rojas
 */
public final class RetouchXStatusBusiness implements BaseBusiness<RetouchXStatus> {

    private final static RetouchXStatusDao RETOUCH_XSTATUS_DAO = RetouchXStatusDao.obtenerInstancia();
    private final static RetouchXStatusBusiness RETOUCH_XSTATUS_BUSINESS = new RetouchXStatusBusiness();

    private RetouchXStatusBusiness() {
    }

    public static RetouchXStatusBusiness obtenerEntidad() {
        return RETOUCH_XSTATUS_BUSINESS;
    }

    @Override
    public RetouchXStatus ejecutar(OperacionEnum operacionEnum, RetouchXStatus retouchXStatus) throws BusinessException {
        try {
            if (operacionEnum == OperacionEnum.GUARDAR) {
                RETOUCH_XSTATUS_DAO.insertar(retouchXStatus);
            } else if (operacionEnum == OperacionEnum.ELIMINAR) {
                RETOUCH_XSTATUS_DAO.eliminar(retouchXStatus);
            } else if (operacionEnum == OperacionEnum.OBTENER) {
                retouchXStatus = RETOUCH_XSTATUS_DAO.obtener(retouchXStatus);
            } else if (operacionEnum == OperacionEnum.ACTUALIZAR) {
                RETOUCH_XSTATUS_DAO.actualizar(retouchXStatus);
            }
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
        return retouchXStatus;
    }

    @Override
    public List<RetouchXStatus> listar() throws BusinessException {
        try {
            return RETOUCH_XSTATUS_DAO.listar();
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }

    public List<RetouchXStatus> listarByRetouch(int idRetouch) throws BusinessException {
        try {
            return RETOUCH_XSTATUS_DAO.listarByRetouch(idRetouch);
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }
}
