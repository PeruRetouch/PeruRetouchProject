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
import pe.com.peruretouch.entity.RetouchXStatus;

/**
 *
 * @author Roy Taza Rojas
 */
public final class RetouchXStatusDao extends BaseDao<RetouchXStatus> {

    private final static RetouchXStatusDao RETOUCH_XSTATUS_DAO = new RetouchXStatusDao();

    private RetouchXStatusDao() {
    }

    public static RetouchXStatusDao obtenerInstancia() {
        return RETOUCH_XSTATUS_DAO;
    }

    @Override
    public int insertar(RetouchXStatus e) throws CoreException {
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spI_RetouchXStatus(?,?)}");
            cl.setInt(1, e.getIdRetouch());
            cl.setInt(2, e.getIdStatus());
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
    public void actualizar(RetouchXStatus e) throws CoreException {
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spU_RetouchXStatus(?,?)}");
            cl.setInt(1, e.getIdRetouch());
            cl.setInt(2, e.getIdStatus());
            cl.executeUpdate();
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public void eliminar(RetouchXStatus e) throws CoreException {
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spD_RetouchXStatus(?,?)}");
            cl.setInt(1, e.getIdRetouch());
            cl.setInt(2, e.getIdStatus());
            cl.executeUpdate();
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public RetouchXStatus obtener(RetouchXStatus e) throws CoreException {
        RetouchXStatus retouchXStatus = null;
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_RetouchXStatus(?,?)}");
            cl.setInt(1, e.getIdRetouch());
            cl.setInt(2, e.getIdStatus());
            rs = cl.executeQuery();
            while (rs.next()) {
                retouchXStatus = new RetouchXStatus();
                retouchXStatus.setIdRetouch(rs.getInt("idRetouch"));
                retouchXStatus.setIdStatus(rs.getInt("idStatus"));
            }
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return retouchXStatus;
    }

    @Override
    public List<RetouchXStatus> listar() throws CoreException {
        List<RetouchXStatus> lista = new ArrayList<>();
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_RetouchXStatus_all()}");
            rs = cl.executeQuery();
            while (rs.next()) {
                RetouchXStatus retouchXStatus = new RetouchXStatus();
                retouchXStatus.setIdRetouch(rs.getInt("idRetouch"));
                retouchXStatus.setIdStatus(rs.getInt("idStatus"));
                lista.add(retouchXStatus);
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

    public List<RetouchXStatus> listarByRetouch(int idRetouch) throws CoreException {
        List<RetouchXStatus> lista = new ArrayList<>();
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_RetouchXStatusByRetouch(?)}");
            cl.setInt(1, idRetouch);
            rs = cl.executeQuery();
            while (rs.next()) {
                RetouchXStatus retouchXStatus = new RetouchXStatus();
                retouchXStatus.setIdRetouch(rs.getInt("idRetouch"));
                retouchXStatus.setIdStatus(rs.getInt("idStatus"));
                lista.add(retouchXStatus);
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
