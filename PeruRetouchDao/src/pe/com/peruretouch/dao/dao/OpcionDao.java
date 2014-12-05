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
import pe.com.peruretouch.entity.Opcion;

/**
 *
 * @author Roy Taza Rojas
 */
public final class OpcionDao extends BaseDao<Opcion> {

    private final static OpcionDao OPCION_DAO = new OpcionDao();

    private OpcionDao() {
    }

    public static OpcionDao obtenerInstancia() {
        return OPCION_DAO;
    }

    @Override
    public int insertar(Opcion e) throws CoreException {
        Integer idOpcion = 0;
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spI_Opcion(?,?,?)}");
            cl.registerOutParameter(1, java.sql.Types.INTEGER);
            cl.setString(2, e.getName());
            cl.setString(3, e.getDescription());
            cl.executeUpdate();
            idOpcion = cl.getInt(1);
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(cn);
        }
        return idOpcion;
    }

    @Override
    public void actualizar(Opcion e) throws CoreException {
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spU_Opcion(?,?,?)}");
            cl.setInt(1, e.getIdOpcion());
            cl.setString(2, e.getName());
            cl.setString(3, e.getDescription());
            cl.executeUpdate();
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public void eliminar(Opcion e) throws CoreException {
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spD_Opcion(?)}");
            cl.setInt(1, e.getIdOpcion());
            cl.executeUpdate();
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public Opcion obtener(Opcion e) throws CoreException {
        Opcion opcion = null;
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_Opcion(?)}");
            cl.setInt(1, e.getIdOpcion());
            rs = cl.executeQuery();
            while (rs.next()) {
                opcion = new Opcion();
                opcion.setIdOpcion(rs.getInt("idOpcion"));
                opcion.setName(rs.getString("name"));
                opcion.setDescription(rs.getString("description"));
            }
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return opcion;
    }

    @Override
    public List<Opcion> listar() throws CoreException {
        List<Opcion> lista = new ArrayList<>();
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_Opcion_all()}");
            rs = cl.executeQuery();
            while (rs.next()) {
                Opcion opcion = new Opcion();
                opcion.setIdOpcion(rs.getInt("idOpcion"));
                opcion.setName(rs.getString("name"));
                opcion.setDescription(rs.getString("description"));
                lista.add(opcion);
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
