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
import pe.com.peruretouch.entity.Status;

/**
 *
 * @author Roy Taza Rojas
 */
public final class StatusDao extends BaseDao<Status> {

    private final static StatusDao STATUS_DAO = new StatusDao();

    private StatusDao() {
    }

    public static StatusDao obtenerInstancia() {
        return STATUS_DAO;
    }

    @Override
    public void insertar(Status e) throws CoreException {
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spI_Status(?,?,?)}");
            cl.setString(1, e.getName());
            cl.setString(2, e.getDescription());
            cl.setString(3, e.getState());
            cl.executeUpdate();
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public void actualizar(Status e) throws CoreException {
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spU_Status(?,?,?,?)}");
            cl.setInt(1, e.getIdStatus());
            cl.setString(2, e.getName());
            cl.setString(3, e.getDescription());
            cl.setString(4, e.getState());
            cl.executeUpdate();
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public void eliminar(Status e) throws CoreException {
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spD_Status(?)}");
            cl.setInt(1, e.getIdStatus());
            cl.executeUpdate();
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public Status obtener(Status e) throws CoreException {
        Status status = null;
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_Status(?)}");
            cl.setInt(1, e.getIdStatus());
            rs = cl.executeQuery();
            while(rs.next()){
                status = new Status();
                status.setIdStatus(rs.getInt("idStatus"));
                status.setName(rs.getString("name"));
                status.setDescription(rs.getString("description"));
                status.setState(rs.getString("state"));
            }
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return status;
    }

    @Override
    public List<Status> listar() throws CoreException {
        List<Status> lista = new ArrayList<>();
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_Status_all()}");
            rs = cl.executeQuery();
            while(rs.next()){
                Status status = new Status();
                status.setIdStatus(rs.getInt("idStatus"));
                status.setName(rs.getString("name"));
                status.setDescription(rs.getString("description"));
                status.setState(rs.getString("state"));
                lista.add(status);
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
