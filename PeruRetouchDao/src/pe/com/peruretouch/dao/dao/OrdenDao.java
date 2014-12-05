/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.com.peruretouch.dao.dao;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import pe.com.peruretouch.dao.base.BaseDao;
import pe.com.peruretouch.dao.util.CoreException;
import pe.com.peruretouch.entity.Orden;

/**
 *
 * @author Roy Taza Rojas
 */
public final class OrdenDao extends BaseDao<Orden> {

    private final static OrdenDao ORDEN_DAO = new OrdenDao();

    private OrdenDao() {
    }

    public static OrdenDao obtenerInstancia() {
        return ORDEN_DAO;
    }

    @Override
    public int insertar(Orden e) throws CoreException {
        Integer idOrder = 0;
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spI_Order_2(?,?,?,?,?,?,?)}");
            cl.registerOutParameter(1, java.sql.Types.INTEGER);
            cl.setInt(2, e.getIdClient());
            cl.setString(3, e.getOrderName());
            cl.setTimestamp(4, new Timestamp(e.getDateTimeClientRequest().getTime()));
            cl.setString(5, e.getSpecifications());
            cl.setDouble(6, e.getTotal());
            cl.setString(7, e.getState());
            cl.executeUpdate();
            idOrder = cl.getInt(1);
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(cn);
        }
        return idOrder;
    }

    @Override
    public void actualizar(Orden e) throws CoreException {
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spU_Order(?,?,?,?,?,?,?)}");
            cl.setInt(1, e.getIdOrder());
            cl.setInt(2, e.getIdClient());
            cl.setString(3, e.getOrderName());
            cl.setTimestamp(4, new Timestamp(e.getDateTimeClientRequest().getTime()));
            cl.setString(5, e.getSpecifications());
            cl.setDouble(6, e.getTotal());
            cl.setString(7, e.getState());
            cl.executeUpdate();
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public void eliminar(Orden e) throws CoreException {
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spD_Order(?)}");
            cl.setInt(1, e.getIdOrder());
            cl.executeUpdate();
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public Orden obtener(Orden e) throws CoreException {
        Orden order = null;
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_Order(?)}");
            cl.setInt(1, e.getIdOrder());
            rs = cl.executeQuery();
            while (rs.next()) {
                order = new Orden();
                order.setIdOrder(rs.getInt("idOrder"));
                order.setIdClient(rs.getInt("idClient"));
                order.setOrderName(rs.getString("orderName"));
                order.setDateTimeClientRequest(new java.util.Date(rs.getTimestamp("dateTimeClientRequest").getTime()));
                order.setSpecifications(rs.getString("specifications"));
                order.setTotal(rs.getDouble("total"));
                order.setState(rs.getString("state"));
            }
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return order;
    }

    @Override
    public List<Orden> listar() throws CoreException {
        List<Orden> lista = new ArrayList<>();
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_Order_all()}");
            rs = cl.executeQuery();
            while (rs.next()) {
                Orden order = new Orden();
                order.setIdOrder(rs.getInt("idOrder"));
                order.setIdClient(rs.getInt("idClient"));
                order.setOrderName(rs.getString("orderName"));
                order.setDateTimeClientRequest(new java.util.Date(rs.getTimestamp("dateTimeClientRequest").getTime()));
                order.setSpecifications(rs.getString("specifications"));
                order.setTotal(rs.getDouble("total"));
                order.setState(rs.getString("state"));
                lista.add(order);
            }
        } catch (Exception e) {
            throw new CoreException(e);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return lista;
    }

    public List<Orden> listOrdersByClient(int idCliente) throws CoreException {
        List<Orden> lista = new ArrayList<>();
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_OrdersByClient(?)}");
            cl.setInt(1, idCliente);
            rs = cl.executeQuery();
            while (rs.next()) {
                Orden order = new Orden();
                order.setIdOrder(rs.getInt("idOrder"));
                order.setIdClient(rs.getInt("idClient"));
                order.setOrderName(rs.getString("orderName"));
                order.setDateTimeClientRequest(new java.util.Date(rs.getTimestamp("dateTimeClientRequest").getTime()));
                order.setSpecifications(rs.getString("specifications"));
                order.setTotal(rs.getDouble("total"));
                order.setState(rs.getString("state"));
                lista.add(order);
            }
        } catch (Exception e) {
            throw new CoreException(e);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return lista;
    }

    public int insertarAndReturnId(Orden e) throws CoreException {
        Integer idOrder = 0;
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spI_Order_2(?,?,?,?,?,?,?)}");
            cl.registerOutParameter(1, java.sql.Types.INTEGER);
            cl.setInt(2, e.getIdClient());
            cl.setString(3, e.getOrderName());
            cl.setTimestamp(4, new Timestamp(e.getDateTimeClientRequest().getTime()));
            cl.setString(5, e.getSpecifications());
            cl.setDouble(6, e.getTotal());
            cl.setString(7, e.getState());
            cl.executeUpdate();
            idOrder = cl.getInt(1);
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(cn);
        }
        return idOrder;
    }

    public List<Orden> listOrdersNoAssigned() throws CoreException {
        List<Orden> lista = new ArrayList<>();
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_OrdersNoAssigned()}");
            rs = cl.executeQuery();
            while (rs.next()) {
                Orden order = new Orden();
                order.setIdOrder(rs.getInt("idOrder"));
                order.setIdClient(rs.getInt("idClient"));
                order.setOrderName(rs.getString("orderName"));
                order.setDateTimeClientRequest(new java.util.Date(rs.getTimestamp("dateTimeClientRequest").getTime()));
                order.setSpecifications(rs.getString("specifications"));
                order.setTotal(rs.getDouble("total"));
                order.setState(rs.getString("state"));
                lista.add(order);
            }
        } catch (Exception e) {
            throw new CoreException(e);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return lista;
    }

    public int orderNumberOfPhotos(int idOrder) throws CoreException {
        int numberOfPhotos = 0;
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_OrderNumberOfPhotos(?)}");
            cl.setInt(1, idOrder);
            rs = cl.executeQuery();
            while (rs.next()) {
                numberOfPhotos = rs.getInt("NumberOfPhotos");
            }
        } catch (Exception e) {
            throw new CoreException(e);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return numberOfPhotos;
    }

    public int orderNumberOfReferences(int idOrder) throws CoreException {
        int numberOfPhotos = 0;
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_OrderNumberOfReferences(?)}");
            cl.setInt(1, idOrder);
            rs = cl.executeQuery();
            while (rs.next()) {
                numberOfPhotos = rs.getInt("NumberOfReferences");
            }
        } catch (Exception e) {
            throw new CoreException(e);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return numberOfPhotos;
    }

    public int orderProductType(int idOrder) throws CoreException {
        int idProduct = 1;
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_OrderProductType(?)}");
            cl.setInt(1, idOrder);
            rs = cl.executeQuery();
            while (rs.next()) {
                idProduct = rs.getInt("OrderProductType");
            }
        } catch (Exception e) {
            throw new CoreException(e);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return idProduct;
    }

    public List<Orden> listOrdersNoPayed() throws CoreException {
        List<Orden> lista = new ArrayList<>();
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_OrdersNoPayed()}");
            rs = cl.executeQuery();
            while (rs.next()) {
                Orden order = new Orden();
                order.setIdOrder(rs.getInt("idOrder"));
                order.setIdClient(rs.getInt("idClient"));
                order.setOrderName(rs.getString("orderName"));
                order.setDateTimeClientRequest(new java.util.Date(rs.getTimestamp("dateTimeClientRequest").getTime()));
                order.setSpecifications(rs.getString("specifications"));
                order.setTotal(rs.getDouble("total"));
                order.setState(rs.getString("state"));
                lista.add(order);
            }
        } catch (Exception e) {
            throw new CoreException(e);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return lista;
    }

    public List<Orden> listOrdersBetweenDates(int idUser, java.util.Date dateFrom, java.util.Date dateTo) throws CoreException {
        List<Orden> lista = new ArrayList<>();
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_OrdersBetweenDates(?,?,?)}");
            cl.setInt(1, idUser);
            cl.setDate(2, new Date(dateFrom.getTime()));
            cl.setDate(3, new Date(dateTo.getTime()));
            rs = cl.executeQuery();
            while (rs.next()) {
                Orden order = new Orden();
                order.setIdOrder(rs.getInt("idOrder"));
                order.setIdClient(rs.getInt("idClient"));
                order.setOrderName(rs.getString("orderName"));
                order.setDateTimeClientRequest(new java.util.Date(rs.getTimestamp("dateTimeClientRequest").getTime()));
                order.setSpecifications(rs.getString("specifications"));
                order.setTotal(rs.getDouble("total"));
                order.setState(rs.getString("state"));
                lista.add(order);
            }
        } catch (Exception e) {
            throw new CoreException(e);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return lista;
    }
}
