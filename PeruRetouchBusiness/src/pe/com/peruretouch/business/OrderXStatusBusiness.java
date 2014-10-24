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
import pe.com.peruretouch.dao.dao.OrderXStatusDao;
import pe.com.peruretouch.dao.util.CoreException;
import pe.com.peruretouch.entity.OrderXStatus;

/**
 *
 * @author Roy Taza Rojas
 */
public final class OrderXStatusBusiness implements BaseBusiness<OrderXStatus> {

    private final static OrderXStatusDao ORDER_XSTATUS_DAO = OrderXStatusDao.obtenerInstancia();
    private final static OrderXStatusBusiness ORDER_XSTATUS_BUSINESS = new OrderXStatusBusiness();

    private OrderXStatusBusiness() {
    }

    public static OrderXStatusBusiness obtenerEntidad() {
        return ORDER_XSTATUS_BUSINESS;
    }

    @Override
    public OrderXStatus ejecutar(OperacionEnum operacionEnum, OrderXStatus orderXStatus) throws BusinessException {
        try {
            if (operacionEnum == OperacionEnum.GUARDAR) {
                ORDER_XSTATUS_DAO.insertar(orderXStatus);
            } else if (operacionEnum == OperacionEnum.ELIMINAR) {
                ORDER_XSTATUS_DAO.eliminar(orderXStatus);
            } else if (operacionEnum == OperacionEnum.OBTENER) {
                orderXStatus = ORDER_XSTATUS_DAO.obtener(orderXStatus);
            } else if (operacionEnum == operacionEnum.ACTUALIZAR) {
                ORDER_XSTATUS_DAO.actualizar(orderXStatus);
            }
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
        return orderXStatus;
    }

    @Override
    public List<OrderXStatus> listar() throws BusinessException {
        try {
            return ORDER_XSTATUS_DAO.listar();
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }
    
    public List<OrderXStatus> listByOrder(int idOrder) throws BusinessException {
        try {
            return ORDER_XSTATUS_DAO.listByOrder(idOrder);
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }
}
