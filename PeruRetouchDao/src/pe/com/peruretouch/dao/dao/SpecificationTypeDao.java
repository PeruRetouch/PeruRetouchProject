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
import pe.com.peruretouch.entity.SpecificationType;

/**
 *
 * @author Roy Taza Rojas
 */
public final class SpecificationTypeDao extends BaseDao<SpecificationType> {

    private final static SpecificationTypeDao SPECIFICATION_TYPE_DAO = new SpecificationTypeDao();

    private SpecificationTypeDao() {
    }
    
    public static SpecificationTypeDao obtenerInstancia() {
        return SPECIFICATION_TYPE_DAO;
    }

    @Override
    public void insertar(SpecificationType e) throws CoreException {
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spI_SpecificationType(?,?,?)}");
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
    public void actualizar(SpecificationType e) throws CoreException {
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spU_SpecificationType(?,?,?,?)}");
            cl.setInt(1, e.getIdSpecificationType());
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
    public void eliminar(SpecificationType e) throws CoreException {
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spD_SpecificationType(?)}");
            cl.setInt(1, e.getIdSpecificationType());
            cl.executeUpdate();
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public SpecificationType obtener(SpecificationType e) throws CoreException {
        SpecificationType specificationType = null;
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_SpecificationType(?)}");
            cl.setInt(1, e.getIdSpecificationType());
            rs = cl.executeQuery();
            while(rs.next()){
                specificationType = new SpecificationType();
                specificationType.setIdSpecificationType(rs.getInt("idSpecificationType"));
                specificationType.setName(rs.getString("name"));
                specificationType.setDescription(rs.getString("description"));
                specificationType.setState(rs.getString("state"));
            }
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return specificationType;
    }

    @Override
    public List<SpecificationType> listar() throws CoreException {
        List<SpecificationType> lista = new ArrayList<>();
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_SpecificationType_all()}");
            rs = cl.executeQuery();
            while(rs.next()){
                SpecificationType specificationType = new SpecificationType();
                specificationType.setIdSpecificationType(rs.getInt("idSpecificationType"));
                specificationType.setName(rs.getString("name"));
                specificationType.setDescription(rs.getString("description"));
                specificationType.setState(rs.getString("state"));
                lista.add(specificationType);
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
