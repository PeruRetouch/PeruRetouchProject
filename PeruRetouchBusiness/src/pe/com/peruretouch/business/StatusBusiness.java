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
import pe.com.peruretouch.dao.dao.StatusDao;
import pe.com.peruretouch.dao.util.CoreException;
import pe.com.peruretouch.entity.Status;

/**
 *
 * @author Roy Taza Rojas
 */
public final class StatusBusiness implements BaseBusiness<Status> {

    private final static StatusDao STATUS_DAO = StatusDao.obtenerInstancia();
    private final static StatusBusiness STATUS_BUSINESS = new StatusBusiness();

    private StatusBusiness() {
    }

    public static StatusBusiness obtenerEntidad() {
        return STATUS_BUSINESS;
    }

    @Override
    public Status ejecutar(OperacionEnum operacionEnum, Status status) throws BusinessException {
        try {
            if (operacionEnum == OperacionEnum.GUARDAR) {
                if (status.getIdStatus() == null || status.getIdStatus() <= 0) {
                    STATUS_DAO.insertar(status);
                } else {
                    STATUS_DAO.actualizar(status);
                }
            } else if (operacionEnum == OperacionEnum.ELIMINAR) {
                STATUS_DAO.eliminar(status);
            } else if (operacionEnum == OperacionEnum.OBTENER) {
                status = STATUS_DAO.obtener(status);
            } else if (operacionEnum == OperacionEnum.ACTUALIZAR) {
                STATUS_DAO.actualizar(status);
            }
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
        return status;
    }

    @Override
    public List<Status> listar() throws BusinessException {
        try {
            return STATUS_DAO.listar();
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }

    }
}
