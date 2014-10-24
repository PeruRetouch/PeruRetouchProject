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
import pe.com.peruretouch.dao.dao.RetouchXSpecificationDao;
import pe.com.peruretouch.dao.util.CoreException;
import pe.com.peruretouch.entity.RetouchXSpecification;

/**
 *
 * @author Roy Taza Rojas
 */
public final class RetouchXSpecificationBusiness implements BaseBusiness<RetouchXSpecification> {

    private final static RetouchXSpecificationDao RETOUCH_XSPECIFICATION_DAO = RetouchXSpecificationDao.obtenerInstancia();
    private final static RetouchXSpecificationBusiness RETOUCH_XSPECIFICATION_BUSINESS = new RetouchXSpecificationBusiness();

    private RetouchXSpecificationBusiness() {
    }

    public static RetouchXSpecificationBusiness obtenerEntidad() {
        return RETOUCH_XSPECIFICATION_BUSINESS;
    }

    @Override
    public RetouchXSpecification ejecutar(OperacionEnum operacionEnum, RetouchXSpecification retouchXSpecification) throws BusinessException {
        try {
            if (operacionEnum == OperacionEnum.GUARDAR) {
                if (retouchXSpecification.getIdRetouchXSpecification() == null
                        || retouchXSpecification.getIdRetouchXSpecification() <= 0) {
                    RETOUCH_XSPECIFICATION_DAO.insertar(retouchXSpecification);
                } else {
                    RETOUCH_XSPECIFICATION_DAO.actualizar(retouchXSpecification);
                }
            } else if (operacionEnum == OperacionEnum.ELIMINAR) {
                RETOUCH_XSPECIFICATION_DAO.eliminar(retouchXSpecification);
            } else if (operacionEnum == OperacionEnum.OBTENER) {
                retouchXSpecification = RETOUCH_XSPECIFICATION_DAO.obtener(retouchXSpecification);
            } else if (operacionEnum == OperacionEnum.ACTUALIZAR) {
                RETOUCH_XSPECIFICATION_DAO.actualizar(retouchXSpecification);
            }
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
        return retouchXSpecification;
    }

    @Override
    public List<RetouchXSpecification> listar() throws BusinessException {
        try {
            return RETOUCH_XSPECIFICATION_DAO.listar();
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }
    
    public List<RetouchXSpecification> obtenerByAutor(int idRetouch, int idAutor) throws BusinessException {
        try {
            return RETOUCH_XSPECIFICATION_DAO.obtenerByAutor(idRetouch, idAutor);
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }
    
    public List<RetouchXSpecification> obtenerByRetouch(int idRetouch) throws BusinessException {
        try {
            return RETOUCH_XSPECIFICATION_DAO.obtenerByRetouch(idRetouch);
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }
}
