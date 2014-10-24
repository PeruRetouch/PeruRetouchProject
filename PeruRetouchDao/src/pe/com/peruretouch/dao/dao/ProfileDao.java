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
import pe.com.peruretouch.entity.Profile;

/**
 *
 * @author Roy Taza Rojas
 */
public final class ProfileDao extends BaseDao<Profile> {

    private final static ProfileDao PROFILE_DAO = new ProfileDao();

    private ProfileDao() {
    }

    public static ProfileDao obtenerInstancia() {
        return PROFILE_DAO;
    }

    @Override
    public void insertar(Profile e) throws CoreException {
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spI_Profile(?,?,?)}");
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
    public void actualizar(Profile e) throws CoreException {
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spU_Profile(?,?,?,?)}");
            cl.setInt(1, e.getIdProfile());
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
    public void eliminar(Profile e) throws CoreException {
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spD_Profile(?)}");
            cl.setInt(1, e.getIdProfile());
            cl.executeUpdate();
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public Profile obtener(Profile e) throws CoreException {
        Profile profile = null;
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_Profile(?)}");
            cl.setInt(1, e.getIdProfile());
            rs = cl.executeQuery();
            while(rs.next()){
                profile = new Profile();
                profile.setIdProfile(rs.getInt("idProfile"));
                profile.setName(rs.getString("name"));
                profile.setDescription(rs.getString("description"));
                profile.setState(rs.getString("state"));
            }
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return profile;
    }

    @Override
    public List<Profile> listar() throws CoreException {
        List<Profile> lista = new ArrayList<>();
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_Profile_all()}");
            rs = cl.executeQuery();
            while(rs.next()){
                Profile profile = new Profile();
                profile.setIdProfile(rs.getInt("idProfile"));
                profile.setName(rs.getString("name"));
                profile.setDescription(rs.getString("description"));
                profile.setState(rs.getString("state"));
                lista.add(profile);
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
