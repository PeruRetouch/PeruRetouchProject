/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package pe.com.peruretouch.dao.dao;

import java.util.ArrayList;
import java.util.List;
import pe.com.peruretouch.dao.base.BaseDao;
import pe.com.peruretouch.dao.util.CoreException;
import pe.com.peruretouch.entity.OrderXStatus;

/**
 *
 * @author Roy Taza Rojas
 */
public final class OrderXStatusDao extends BaseDao<OrderXStatus> {
    
    private final static OrderXStatusDao ORDER_XSTATUS_DAO = new OrderXStatusDao();

    private OrderXStatusDao() {
    }
    
    public static OrderXStatusDao obtenerInstancia(){
        return ORDER_XSTATUS_DAO;
    }

    @Override
    public void insertar(OrderXStatus e) throws CoreException {
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spI_OrderXStatus(?,?)}");
            cl.setInt(1, e.getIdOrder());
            cl.setInt(2, e.getIdStatus());
            cl.executeUpdate();
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public void actualizar(OrderXStatus e) throws CoreException {
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spU_OrderXStatus(?,?)}");
            cl.setInt(1, e.getIdOrder());
            cl.setInt(2, e.getIdStatus());
            cl.executeUpdate();
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public void eliminar(OrderXStatus e) throws CoreException {
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spD_OrderXStatus(?,?)}");
            cl.setInt(1, e.getIdOrder());
            cl.setInt(2, e.getIdStatus());
            cl.executeUpdate();
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public OrderXStatus obtener(OrderXStatus e) throws CoreException {
        OrderXStatus orderXStatus = null;
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_OrderXStatus(?,?)}");
            cl.setInt(1, e.getIdOrder());
            cl.setInt(2, e.getIdStatus());
            rs = cl.executeQuery();
            while(rs.next()){
                orderXStatus = new OrderXStatus();
                orderXStatus.setIdOrder(rs.getInt("idOrder"));
                orderXStatus.setIdStatus(rs.getInt("idStatus"));
            }
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return orderXStatus;
    }

    @Override
    public List<OrderXStatus> listar() throws CoreException {
        List<OrderXStatus> lista = new ArrayList<>();
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_OrderXStatus_all()}");
            rs = cl.executeQuery();
            while(rs.next()){
                OrderXStatus orderXStatus = new OrderXStatus();
                orderXStatus.setIdOrder(rs.getInt("idOrder"));
                orderXStatus.setIdStatus(rs.getInt("idStatus"));
                lista.add(orderXStatus);
            }
        }catch(Exception e){
            throw new CoreException(e);
        }finally{
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return lista;
    }
    
    public List<OrderXStatus> listByOrder(int idOrder) throws CoreException {
        List<OrderXStatus> lista = new ArrayList<>();
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_OrderXStatusByOrder(?)}");
            cl.setInt(1, idOrder);
            rs = cl.executeQuery();
            while(rs.next()){
                OrderXStatus orderXStatus = new OrderXStatus();
                orderXStatus.setIdOrder(rs.getInt("idOrder"));
                orderXStatus.setIdStatus(rs.getInt("idStatus"));
                lista.add(orderXStatus);
            }
        }catch(Exception e){
            throw new CoreException(e);
        }finally{
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return lista;
    }
}
