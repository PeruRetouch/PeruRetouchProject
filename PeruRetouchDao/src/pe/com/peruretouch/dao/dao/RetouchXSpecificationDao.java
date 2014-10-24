/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package pe.com.peruretouch.dao.dao;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import pe.com.peruretouch.dao.base.BaseDao;
import pe.com.peruretouch.dao.util.CoreException;
import pe.com.peruretouch.entity.Product;
import pe.com.peruretouch.entity.RetouchXSpecification;

/**
 *
 * @author Roy Taza Rojas
 */
public final class RetouchXSpecificationDao extends BaseDao<RetouchXSpecification>{
    
    private final static RetouchXSpecificationDao RETOUCH_XSPECIFICATION_DAO = new RetouchXSpecificationDao();

    private RetouchXSpecificationDao() {
    }
    
    public static RetouchXSpecificationDao obtenerInstancia(){
        return RETOUCH_XSPECIFICATION_DAO;
    }

    @Override
    public void insertar(RetouchXSpecification e) throws CoreException {
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spI_RetouchXSpecification(?,?,?,?,?)}");
            cl.setInt(1, e.getIdRetouch());
            cl.setInt(2, e.getIdSpecificationType());
            cl.setInt(3, e.getIdAutor());
            cl.setDate(4, new Date(e.getDateTimeSpecification().getTime()));
            cl.setString(5, e.getSpecification());
            cl.executeUpdate();
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public void actualizar(RetouchXSpecification e) throws CoreException {
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spU_RetouchXSpecification(?,?,?,?,?,?)}");
            cl.setInt(1, e.getIdRetouchXSpecification());
            cl.setInt(2, e.getIdRetouch());
            cl.setInt(3, e.getIdSpecificationType());
            cl.setInt(4, e.getIdAutor());
            cl.setDate(5, new Date(e.getDateTimeSpecification().getTime()));
            cl.setString(6, e.getSpecification());
            cl.executeUpdate();
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public void eliminar(RetouchXSpecification e) throws CoreException {
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spD_RetouchXSpecification(?)}");
            cl.setInt(1, e.getIdRetouchXSpecification());
            cl.executeUpdate();
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public RetouchXSpecification obtener(RetouchXSpecification e) throws CoreException {
        RetouchXSpecification retouchXSpecification = null;
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_RetouchXSpecification(?)}");
            cl.setInt(1, e.getIdRetouchXSpecification());
            rs = cl.executeQuery();
            while(rs.next()){
                retouchXSpecification = new RetouchXSpecification();
                retouchXSpecification.setIdRetouchXSpecification(rs.getInt("idRetouchXSpecification"));
                retouchXSpecification.setIdRetouch(rs.getInt("idRetouch"));
                retouchXSpecification.setIdSpecificationType(rs.getInt("idSpecificationType"));
                retouchXSpecification.setIdAutor(rs.getInt("idAutor"));
                retouchXSpecification.setDateTimeSpecification(new java.util.Date(rs.getDate("dateTimeSpecification").getTime()));
                retouchXSpecification.setSpecification(rs.getString("specification"));
            }
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return retouchXSpecification;
    }

    @Override
    public List<RetouchXSpecification> listar() throws CoreException {
        List<RetouchXSpecification> lista = new ArrayList<>();
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_RetouchXSpecification_all()}");
            rs = cl.executeQuery();
            while(rs.next()){
                RetouchXSpecification retouchXSpecification = new RetouchXSpecification();
                retouchXSpecification.setIdRetouchXSpecification(rs.getInt("idRetouchXSpecification"));
                retouchXSpecification.setIdRetouch(rs.getInt("idRetouch"));
                retouchXSpecification.setIdSpecificationType(rs.getInt("idSpecificationType"));
                retouchXSpecification.setIdAutor(rs.getInt("idAutor"));
                retouchXSpecification.setDateTimeSpecification(new java.util.Date(rs.getDate("dateTimeSpecification").getTime()));
                retouchXSpecification.setSpecification(rs.getString("specification"));
                lista.add(retouchXSpecification);
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
    
    public List<RetouchXSpecification> obtenerByAutor(int idRetouch, int idAutor) throws CoreException {
        List<RetouchXSpecification> lista = new ArrayList<>();
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_RetouchXSpecificationByAutor(?,?)}");
            cl.setInt(1, idRetouch);
            cl.setInt(2, idAutor);
            rs = cl.executeQuery();
            while(rs.next()){
                RetouchXSpecification retouchXSpecification = new RetouchXSpecification();
                retouchXSpecification = new RetouchXSpecification();
                retouchXSpecification.setIdRetouchXSpecification(rs.getInt("idRetouchXSpecification"));
                retouchXSpecification.setIdRetouch(rs.getInt("idRetouch"));
                retouchXSpecification.setIdSpecificationType(rs.getInt("idSpecificationType"));
                retouchXSpecification.setIdAutor(rs.getInt("idAutor"));
                retouchXSpecification.setDateTimeSpecification(new java.util.Date(rs.getDate("dateTimeSpecification").getTime()));
                retouchXSpecification.setSpecification(rs.getString("specification"));
                lista.add(retouchXSpecification);
            }
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return lista;
    }
    
    public List<RetouchXSpecification> obtenerByRetouch(int idRetouch) throws CoreException {
        List<RetouchXSpecification> lista = new ArrayList<>();
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_RetouchXSpecificationByRetouch(?)}");
            cl.setInt(1, idRetouch);
            rs = cl.executeQuery();
            while(rs.next()){
                RetouchXSpecification retouchXSpecification = new RetouchXSpecification();
                retouchXSpecification = new RetouchXSpecification();
                retouchXSpecification.setIdRetouchXSpecification(rs.getInt("idRetouchXSpecification"));
                retouchXSpecification.setIdRetouch(rs.getInt("idRetouch"));
                retouchXSpecification.setIdSpecificationType(rs.getInt("idSpecificationType"));
                retouchXSpecification.setIdAutor(rs.getInt("idAutor"));
                retouchXSpecification.setDateTimeSpecification(new java.util.Date(rs.getDate("dateTimeSpecification").getTime()));
                retouchXSpecification.setSpecification(rs.getString("specification"));
                lista.add(retouchXSpecification);
            }
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return lista;
    } 
}
