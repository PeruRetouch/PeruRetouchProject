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
import pe.com.peruretouch.entity.UserXOpcion;

/**
 *
 * @author Roy Taza Rojas
 */
public final class UserXOpcionDao extends BaseDao<UserXOpcion> {

    private final static UserXOpcionDao USER_XOPCION_DAO = new UserXOpcionDao();

    private UserXOpcionDao() {
    }

    public static UserXOpcionDao obtenerInstancia() {
        return USER_XOPCION_DAO;
    }

    @Override
    public int insertar(UserXOpcion e) throws CoreException {
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spI_UserXOpcion(?,?,?)}");
            cl.setInt(1, e.getIdUser());
            cl.setInt(2, e.getIdOpcion());
            cl.setInt(3, e.getValue());
            cl.executeUpdate();
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(cn);
        }
        return 1;
    }

    @Override
    public void actualizar(UserXOpcion e) throws CoreException {
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spU_UserXOpcion(?,?,?)}");
            cl.setInt(1, e.getIdUser());
            cl.setInt(2, e.getIdOpcion());
            cl.setInt(3, e.getValue());
            cl.executeUpdate();
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public void eliminar(UserXOpcion e) throws CoreException {
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spD_UserXOpcion(?,?)}");
            cl.setInt(1, e.getIdUser());
            cl.setInt(2, e.getIdOpcion());
            cl.executeUpdate();
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public UserXOpcion obtener(UserXOpcion e) throws CoreException {
        UserXOpcion userXOpcion = null;
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_UserXOpcion(?,?)}");
            cl.setInt(1, e.getIdUser());
            cl.setInt(2, e.getIdOpcion());
            rs = cl.executeQuery();
            while (rs.next()) {
                userXOpcion = new UserXOpcion();
                userXOpcion.setIdUser(rs.getInt("idUser"));
                userXOpcion.setIdOpcion(rs.getInt("idOpcion"));
                userXOpcion.setValue(rs.getInt("value"));
            }
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return userXOpcion;
    }

    @Override
    public List<UserXOpcion> listar() throws CoreException {
        List<UserXOpcion> lista = new ArrayList<>();
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_UserXOpcion_all()}");
            rs = cl.executeQuery();
            while (rs.next()) {
                UserXOpcion userXOpcion = new UserXOpcion();
                userXOpcion.setIdUser(rs.getInt("idUser"));
                userXOpcion.setIdOpcion(rs.getInt("idOpcion"));
                userXOpcion.setValue(rs.getInt("value"));
                lista.add(userXOpcion);
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
