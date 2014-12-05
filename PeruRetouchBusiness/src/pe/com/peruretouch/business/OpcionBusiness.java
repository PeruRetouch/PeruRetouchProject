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
import pe.com.peruretouch.dao.dao.OpcionDao;
import pe.com.peruretouch.dao.util.CoreException;
import pe.com.peruretouch.entity.Opcion;

/**
 *
 * @author Roy Taza Rojas
 */
public final class OpcionBusiness implements BaseBusiness<Opcion> {

    private final static OpcionDao OPCION_DAO = OpcionDao.obtenerInstancia();
    private final static OpcionBusiness OPCION_BUSINESS = new OpcionBusiness();

    private OpcionBusiness() {
    }

    public static OpcionBusiness obtenerEntidad() {
        return OPCION_BUSINESS;
    }

    @Override
    public Opcion ejecutar(OperacionEnum operacionEnum, Opcion opcion) throws BusinessException {
        try {
            if (operacionEnum == OperacionEnum.GUARDAR) {
                if (opcion.getIdOpcion() == null || opcion.getIdOpcion() <= 0) {
                    opcion.setIdOpcion(OPCION_DAO.insertar(opcion));
                } else {
                    OPCION_DAO.actualizar(opcion);
                }
            } else if (operacionEnum == OperacionEnum.ELIMINAR) {
                OPCION_DAO.eliminar(opcion);
            } else if (operacionEnum == OperacionEnum.OBTENER) {
                opcion = OPCION_DAO.obtener(opcion);
            } else if (operacionEnum == OperacionEnum.ACTUALIZAR) {
                OPCION_DAO.actualizar(opcion);
            }
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
        return opcion;
    }

    @Override
    public List<Opcion> listar() throws BusinessException {
        try {
            return OPCION_DAO.listar();
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }

}
