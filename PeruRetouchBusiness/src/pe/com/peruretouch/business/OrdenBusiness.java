/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.com.peruretouch.business;

import java.sql.Date;
import java.util.List;
import pe.com.peruretouch.business.base.BaseBusiness;
import pe.com.peruretouch.business.base.BusinessException;
import pe.com.peruretouch.business.base.OperacionEnum;
import pe.com.peruretouch.dao.dao.OrdenDao;
import pe.com.peruretouch.dao.util.CoreException;
import pe.com.peruretouch.entity.Orden;

/**
 *
 * @author Roy Taza Rojas
 */
public final class OrdenBusiness implements BaseBusiness<Orden> {

    private final static OrdenDao ORDEN_DAO = OrdenDao.obtenerInstancia();
    private final static OrdenBusiness ORDEN_BUSINESS = new OrdenBusiness();

    private OrdenBusiness() {
    }

    public static OrdenBusiness obtenerEntidad() {
        return ORDEN_BUSINESS;
    }

    @Override
    public Orden ejecutar(OperacionEnum operacionEnum, Orden orden) throws BusinessException {
        try {
            if (operacionEnum == OperacionEnum.GUARDAR) {
                if (orden.getIdOrder() == null || orden.getIdOrder() <= 0) {
                    ORDEN_DAO.insertar(orden);
                } else {
                    ORDEN_DAO.actualizar(orden);
                }
            } else if (operacionEnum == OperacionEnum.ELIMINAR) {
                ORDEN_DAO.eliminar(orden);
            } else if (operacionEnum == OperacionEnum.OBTENER) {
                orden = ORDEN_DAO.obtener(orden);
            } else if (operacionEnum == OperacionEnum.ACTUALIZAR) {
                ORDEN_DAO.actualizar(orden);
            }
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
        return orden;
    }

    @Override
    public List<Orden> listar() throws BusinessException {
        try {
            return ORDEN_DAO.listar();
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }

    public List<Orden> listOrdersByClient(int idCliente) throws BusinessException {
        try {
            return ORDEN_DAO.listOrdersByClient(idCliente);
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }

    public int insertOrderAndReturnId(Orden orden) throws BusinessException {
        try {
            return ORDEN_DAO.insertarAndReturnId(orden);
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }

    public List<Orden> listOrdersNoAssigned() throws BusinessException {
        try {
            return ORDEN_DAO.listOrdersNoAssigned();
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }

    public int orderNumberOfPhotos(int idOrder) throws BusinessException {
        try {
            return ORDEN_DAO.orderNumberOfPhotos(idOrder);
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }

    public int orderNumberOfReferences(int idOrder) throws BusinessException {
        try {
            return ORDEN_DAO.orderNumberOfReferences(idOrder);
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }

    public int orderProductType(int idOrder) throws BusinessException {
        try {
            return ORDEN_DAO.orderProductType(idOrder);
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }

    public List<Orden> listOrdersNoPayed() throws BusinessException {
        try {
            return ORDEN_DAO.listOrdersNoPayed();
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }

    public List<Orden> listOrdersBetweenDates(int idUser, Date dateFrom, Date dateTo) throws BusinessException {
        try {
            return ORDEN_DAO.listOrdersBetweenDates(idUser, dateFrom, dateTo);
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }
}