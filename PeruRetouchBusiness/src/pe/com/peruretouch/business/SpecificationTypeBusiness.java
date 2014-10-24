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
import pe.com.peruretouch.dao.dao.SpecificationTypeDao;
import pe.com.peruretouch.dao.util.CoreException;
import pe.com.peruretouch.entity.SpecificationType;

/**
 *
 * @author Roy Taza Rojas
 */
public final class SpecificationTypeBusiness implements BaseBusiness<SpecificationType>{
    
    private final static SpecificationTypeDao SPECIFICATION_TYPE_DAO = SpecificationTypeDao.obtenerInstancia();
    private final static SpecificationTypeBusiness SPECIFICATION_TYPE_BUSINESS = new SpecificationTypeBusiness();

    private SpecificationTypeBusiness() {
    }

    public static SpecificationTypeBusiness obtenerEntidad() {
        return SPECIFICATION_TYPE_BUSINESS;
    }

    @Override
    public SpecificationType ejecutar(OperacionEnum operacionEnum, SpecificationType specificationType) throws BusinessException {
        try {
            if (operacionEnum == OperacionEnum.GUARDAR) {
                if (specificationType.getIdSpecificationType()== null || specificationType.getIdSpecificationType()<= 0) {
                    SPECIFICATION_TYPE_DAO.insertar(specificationType);
                } else {
                    SPECIFICATION_TYPE_DAO.actualizar(specificationType);
                }
            } else if (operacionEnum == OperacionEnum.ELIMINAR) {
                SPECIFICATION_TYPE_DAO.eliminar(specificationType);
            } else if (operacionEnum == OperacionEnum.OBTENER) {
                specificationType = SPECIFICATION_TYPE_DAO.obtener(specificationType);
            } else if (operacionEnum == OperacionEnum.ACTUALIZAR) {
                SPECIFICATION_TYPE_DAO.actualizar(specificationType);
            }
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
        return specificationType;
    }

    @Override
    public List<SpecificationType> listar() throws BusinessException {
        try {
            return SPECIFICATION_TYPE_DAO.listar();
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }
    
}
