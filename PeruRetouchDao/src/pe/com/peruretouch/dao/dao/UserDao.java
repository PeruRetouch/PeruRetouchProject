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
import pe.com.peruretouch.entity.User;

/**
 *
 * @author Roy Taza Rojas
 */
public final class UserDao extends BaseDao<User> {

    private final static UserDao USER_DAO = new UserDao();

    private UserDao() {
    }

    public static UserDao obtenerInstancia() {
        return USER_DAO;
    }

    @Override
    public void insertar(User e) throws CoreException {
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spI_User(?,?,?,?,?,?,?,?,?,?,?,?)}");
            cl.setString(1, e.getUserLogin());
            cl.setString(2, e.getPassword());
            cl.setInt(3, e.getIdProfile());
            cl.setString(4, e.getName());
            cl.setString(5, e.getLastName());
            cl.setString(6, e.getAddress());
            cl.setString(7, e.getCountry());
            cl.setDate(8, new Date(e.getBirthDay().getTime()));
            cl.setString(9, e.getTelephone());
            cl.setString(10, e.getCellphone());
            cl.setString(11, e.getEmail());
            cl.setString(12, e.getState());
            cl.executeUpdate();
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public void actualizar(User e) throws CoreException {
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spU_User(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            cl.setInt(1, e.getIdUser());
            cl.setString(2, e.getUserLogin());
            cl.setString(3, e.getPassword());
            cl.setInt(4, e.getIdProfile());
            cl.setString(5, e.getName());
            cl.setString(6, e.getLastName());
            cl.setString(7, e.getAddress());
            cl.setString(8, e.getCountry());
            cl.setDate(9, new Date(e.getBirthDay().getTime()));
            cl.setString(10, e.getTelephone());
            cl.setString(11, e.getCellphone());
            cl.setString(12, e.getEmail());
            cl.setString(13, e.getState());
            cl.executeUpdate();
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public void eliminar(User e) throws CoreException {
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spD_User(?)}");
            cl.setInt(1, e.getIdUser());
            cl.executeUpdate();
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public User obtener(User e) throws CoreException {
        User user = null;
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_User(?)}");
            cl.setInt(1, e.getIdUser());
            rs = cl.executeQuery();
            while (rs.next()) {
                user = new User();
                user.setIdUser(rs.getInt("idUser"));
                user.setUserLogin(rs.getString("userLogin"));
                user.setPassword(rs.getString("password"));
                user.setIdProfile(rs.getInt("idProfile"));
                user.setName(rs.getString("name"));
                user.setLastName(rs.getString("lastName"));
                user.setAddress(rs.getString("address"));
                user.setCountry(rs.getString("country"));
                user.setBirthDay(new java.util.Date(rs.getDate("birthDay").getTime()));
                user.setTelephone(rs.getString("telephone"));
                user.setCellphone(rs.getString("cellphone"));
                user.setEmail(rs.getString("email"));
                user.setState(rs.getString("state"));
            }
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return user;
    }

    @Override
    public List<User> listar() throws CoreException {
        List<User> lista = new ArrayList<>();
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_User_all()}");
            rs = cl.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setIdUser(rs.getInt("idUser"));
                user.setUserLogin(rs.getString("userLogin"));
                user.setPassword(rs.getString("password"));
                user.setIdProfile(rs.getInt("idProfile"));
                user.setName(rs.getString("name"));
                user.setLastName(rs.getString("lastName"));
                user.setAddress(rs.getString("address"));
                user.setCountry(rs.getString("country"));
                user.setBirthDay(new java.util.Date(rs.getDate("birthDay").getTime()));
                user.setTelephone(rs.getString("telephone"));
                user.setCellphone(rs.getString("cellphone"));
                user.setEmail(rs.getString("email"));
                user.setState(rs.getString("state"));
                lista.add(user);
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
    
    public User userAuthentication(String userLogin, String password) throws CoreException{
        User user = null;
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_UsuarioAutenticar(?, ?)}");
            cl.setString(1, userLogin);
            cl.setString(2, password);
            rs = cl.executeQuery();
            while (rs.next()) {
                user = new User();
                user.setIdUser(rs.getInt("idUser"));
                user.setUserLogin(rs.getString("userLogin"));
                user.setPassword(rs.getString("password"));
                user.setIdProfile(rs.getInt("idProfile"));
                user.setName(rs.getString("name"));
                user.setLastName(rs.getString("lastName"));
                user.setAddress(rs.getString("address"));
                user.setCountry(rs.getString("country"));
                user.setBirthDay(new java.util.Date(rs.getDate("birthDay").getTime()));
                user.setTelephone(rs.getString("telephone"));
                user.setCellphone(rs.getString("cellphone"));
                user.setEmail(rs.getString("email"));
                user.setState(rs.getString("state"));
            }
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return user;
    }
    
    public User getUserIfExist(String username) throws CoreException {
        User user = null;
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_UserGet(?)}");
            cl.setString(1, username);
            rs = cl.executeQuery();
            while (rs.next()) {
                user = new User();
                user.setIdUser(rs.getInt("idUser"));
                user.setUserLogin(rs.getString("userLogin"));
                user.setPassword(rs.getString("password"));
                user.setIdProfile(rs.getInt("idProfile"));
                user.setName(rs.getString("name"));
                user.setLastName(rs.getString("lastName"));
                user.setAddress(rs.getString("address"));
                user.setCountry(rs.getString("country"));
                user.setBirthDay(new java.util.Date(rs.getDate("birthDay").getTime()));
                user.setTelephone(rs.getString("telephone"));
                user.setCellphone(rs.getString("cellphone"));
                user.setEmail(rs.getString("email"));
                user.setState(rs.getString("state"));
            }
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return user;
    }
    
    public List<User> listarByEmail(String eMail) throws CoreException {
        List<User> lista = new ArrayList<>();
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_UserByEmail(?)}");
            cl.setString(1, eMail);
            rs = cl.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setIdUser(rs.getInt("idUser"));
                user.setUserLogin(rs.getString("userLogin"));
                user.setPassword(rs.getString("password"));
                user.setIdProfile(rs.getInt("idProfile"));
                user.setName(rs.getString("name"));
                user.setLastName(rs.getString("lastName"));
                user.setAddress(rs.getString("address"));
                user.setCountry(rs.getString("country"));
                user.setBirthDay(new java.util.Date(rs.getDate("birthDay").getTime()));
                user.setTelephone(rs.getString("telephone"));
                user.setCellphone(rs.getString("cellphone"));
                user.setEmail(rs.getString("email"));
                user.setState(rs.getString("state"));
                lista.add(user);
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
