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
import pe.com.peruretouch.entity.Retouch;

/**
 *
 * @author Roy Taza Rojas
 */
public final class RetouchDao extends BaseDao<Retouch> {

    private final static RetouchDao RETOUCH_DAO = new RetouchDao();

    private RetouchDao() {
    }

    public static RetouchDao obtenerInstancia() {
        return RETOUCH_DAO;
    }

    @Override
    public void insertar(Retouch e) throws CoreException {
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spI_Retouch(?,?,?,?,?,?,?,?)}");
            cl.setInt(1, e.getIdOrder());
            cl.setInt(2, e.getIdProduct());
            cl.setInt(3, e.getIdArtist());
            cl.setInt(4, e.getIdSupervisor());
            cl.setDate(5, new Date(e.getDateTimeArtistRequest().getTime()));
            cl.setDate(6, new Date(e.getDateTimeUploadRetouch().getTime()));
            cl.setString(7, e.getFileNombre());
            cl.setInt(8, e.getPhotoId());
            cl.executeUpdate();
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public void actualizar(Retouch e) throws CoreException {
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spU_Retouch(?,?,?,?,?,?,?,?,?)}");
            cl.setInt(1, e.getIdRetouch());
            cl.setInt(2, e.getIdOrder());
            cl.setInt(3, e.getIdProduct());
            cl.setInt(4, e.getIdArtist());
            cl.setInt(5, e.getIdSupervisor());
            cl.setDate(6, new Date(e.getDateTimeArtistRequest().getTime()));
            cl.setDate(7, new Date(e.getDateTimeUploadRetouch().getTime()));
            cl.setString(8, e.getFileNombre());
            cl.setInt(9, e.getPhotoId());
            cl.executeUpdate();
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public void eliminar(Retouch e) throws CoreException {
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spD_Retouch(?)}");
            cl.setInt(1, e.getIdRetouch());
            cl.executeUpdate();
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public Retouch obtener(Retouch e) throws CoreException {
        Retouch retouch = null;
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_Retouch(?)}");
            cl.setInt(1, e.getIdRetouch());
            rs = cl.executeQuery();
            while (rs.next()) {
                retouch = new Retouch();
                retouch.setIdRetouch(rs.getInt("idRetouch"));
                retouch.setIdOrder(rs.getInt("idOrder"));
                retouch.setIdProduct(rs.getInt("idProduct"));
                retouch.setIdArtist(rs.getInt("idArtist"));
                retouch.setIdSupervisor(rs.getInt("idSupervisor"));
                retouch.setDateTimeArtistRequest(new java.util.Date(rs.getDate("dateTimeArtistRequest").getTime()));
                retouch.setDateTimeUploadRetouch(new java.util.Date(rs.getDate("dateTimeUploadRetouch").getTime()));
                retouch.setFileNombre(rs.getString("fileNombre"));
                retouch.setPhotoId(rs.getInt("photoId"));
            }
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return retouch;
    }

    @Override
    public List<Retouch> listar() throws CoreException {
        List<Retouch> lista = new ArrayList<>();
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_Retouch_all()}");
            rs = cl.executeQuery();
            while (rs.next()) {
                Retouch retouch = new Retouch();
                retouch.setIdOrder(rs.getInt("idRetouch"));
                retouch.setIdOrder(rs.getInt("idOrder"));
                retouch.setIdProduct(rs.getInt("idProduct"));
                retouch.setIdArtist(rs.getInt("idArtist"));
                retouch.setIdSupervisor(rs.getInt("idSupervisor"));
                retouch.setDateTimeArtistRequest(new java.util.Date(rs.getDate("dateTimeArtistRequest").getTime()));
                retouch.setDateTimeUploadRetouch(new java.util.Date(rs.getDate("dateTimeUploadRetouch").getTime()));
                retouch.setFileNombre(rs.getString("fileNombre"));
                retouch.setPhotoId(rs.getInt("photoId"));
                lista.add(retouch);
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

    public Integer insertarAndReturnId(Retouch e) throws CoreException {
        Integer idRetouch = 0;
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spI_Retouch_2(?,?,?,?,?,?,?,?,?)}");
            cl.registerOutParameter(1, java.sql.Types.INTEGER);
            cl.setInt(2, e.getIdOrder());
            cl.setInt(3, e.getIdProduct());
            cl.setInt(4, e.getIdArtist());
            cl.setInt(5, e.getIdSupervisor());
            cl.setDate(6, new Date(e.getDateTimeArtistRequest().getTime()));
            cl.setDate(7, new Date(e.getDateTimeUploadRetouch().getTime()));
            cl.setString(8, e.getFileNombre());
            cl.setInt(9, e.getPhotoId());
            cl.executeUpdate();
            idRetouch = cl.getInt(1);
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(cn);
        }
        return idRetouch;
    }

    public List<Retouch> listarByOrder(int idOrder) throws CoreException {
        List<Retouch> lista = new ArrayList<>();
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_RetouchByOrder(?)}");
            cl.setInt(1, idOrder);
            rs = cl.executeQuery();
            while (rs.next()) {
                Retouch retouch = new Retouch();
                retouch.setIdRetouch(rs.getInt("idRetouch"));
                retouch.setIdOrder(rs.getInt("idOrder"));
                retouch.setIdProduct(rs.getInt("idProduct"));
                retouch.setIdArtist(rs.getInt("idArtist"));
                retouch.setIdSupervisor(rs.getInt("idSupervisor"));
                retouch.setDateTimeArtistRequest(new java.util.Date(rs.getDate("dateTimeArtistRequest").getTime()));
                retouch.setDateTimeUploadRetouch(new java.util.Date(rs.getDate("dateTimeUploadRetouch").getTime()));
                retouch.setFileNombre(rs.getString("fileNombre"));
                retouch.setPhotoId(rs.getInt("photoId"));
                lista.add(retouch);
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

    public List<Retouch> listarByArtist(int idArtist) throws CoreException {
        List<Retouch> lista = new ArrayList<>();
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_RetouchByArtist(?)}");
            cl.setInt(1, idArtist);
            rs = cl.executeQuery();
            while (rs.next()) {
                Retouch retouch = new Retouch();
                retouch.setIdRetouch(rs.getInt("idRetouch"));
                retouch.setIdOrder(rs.getInt("idOrder"));
                retouch.setIdProduct(rs.getInt("idProduct"));
                retouch.setIdArtist(rs.getInt("idArtist"));
                retouch.setIdSupervisor(rs.getInt("idSupervisor"));
                retouch.setDateTimeArtistRequest(new java.util.Date(rs.getDate("dateTimeArtistRequest").getTime()));
                retouch.setDateTimeUploadRetouch(new java.util.Date(rs.getDate("dateTimeUploadRetouch").getTime()));
                retouch.setFileNombre(rs.getString("fileNombre"));
                retouch.setPhotoId(rs.getInt("photoId"));
                lista.add(retouch);
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

    public Retouch obtenerByFileNombre(String fileNombre) throws CoreException {
        Retouch retouch = null;
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_RetouchByFileNombre(?)}");
            cl.setString(1, fileNombre);
            rs = cl.executeQuery();
            while (rs.next()) {
                retouch = new Retouch();
                retouch.setIdRetouch(rs.getInt("idRetouch"));
                retouch.setIdOrder(rs.getInt("idOrder"));
                retouch.setIdProduct(rs.getInt("idProduct"));
                retouch.setIdArtist(rs.getInt("idArtist"));
                retouch.setIdSupervisor(rs.getInt("idSupervisor"));
                retouch.setDateTimeArtistRequest(new java.util.Date(rs.getDate("dateTimeArtistRequest").getTime()));
                retouch.setDateTimeUploadRetouch(new java.util.Date(rs.getDate("dateTimeUploadRetouch").getTime()));
                retouch.setFileNombre(rs.getString("fileNombre"));
                retouch.setPhotoId(rs.getInt("photoId"));
            }
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return retouch;
    }

    public Retouch obtenerRetouchPendienteByFileNombreAndArtist(String fileNombre, int idArtist) throws CoreException {
        Retouch retouch = null;
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_RetouchPendienteByFileNombreAndArtist(?,?)}");
            cl.setString(1, fileNombre);
            cl.setInt(2, idArtist);
            rs = cl.executeQuery();
            while (rs.next()) {
                retouch = new Retouch();
                retouch.setIdRetouch(rs.getInt("idRetouch"));
                retouch.setIdOrder(rs.getInt("idOrder"));
                retouch.setIdProduct(rs.getInt("idProduct"));
                retouch.setIdArtist(rs.getInt("idArtist"));
                retouch.setIdSupervisor(rs.getInt("idSupervisor"));
                retouch.setDateTimeArtistRequest(new java.util.Date(rs.getDate("dateTimeArtistRequest").getTime()));
                retouch.setDateTimeUploadRetouch(new java.util.Date(rs.getDate("dateTimeUploadRetouch").getTime()));
                retouch.setFileNombre(rs.getString("fileNombre"));
                retouch.setPhotoId(rs.getInt("photoId"));
            }
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return retouch;
    }

    public List<Retouch> obtenerRetouchByOrderAndClient(int idOrder, int idClient) throws CoreException {
        List<Retouch> lista = new ArrayList<>();
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_RetouchByOrderAndClient(?,?)}");
            cl.setInt(1, idOrder);
            cl.setInt(2, idClient);
            rs = cl.executeQuery();
            while (rs.next()) {
                Retouch retouch = new Retouch();
                retouch.setIdRetouch(rs.getInt("idRetouch"));
                retouch.setIdOrder(rs.getInt("idOrder"));
                retouch.setIdProduct(rs.getInt("idProduct"));
                retouch.setIdArtist(rs.getInt("idArtist"));
                retouch.setIdSupervisor(rs.getInt("idSupervisor"));
                retouch.setDateTimeArtistRequest(new java.util.Date(rs.getDate("dateTimeArtistRequest").getTime()));
                retouch.setDateTimeUploadRetouch(new java.util.Date(rs.getDate("dateTimeUploadRetouch").getTime()));
                retouch.setFileNombre(rs.getString("fileNombre"));
                retouch.setPhotoId(rs.getInt("photoId"));
                lista.add(retouch);
            }
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return lista;
    }
    
    public List<Retouch> obtenerRetouchPendienteByOrder(int idArtist, int idOrder) throws CoreException {
        List<Retouch> lista = new ArrayList<>();
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_RetouchPendienteByOrder(?,?)}");
            cl.setInt(1, idArtist);
            cl.setInt(2, idOrder);
            rs = cl.executeQuery();
            while (rs.next()) {
                Retouch retouch = new Retouch();
                retouch.setIdRetouch(rs.getInt("idRetouch"));
                retouch.setIdOrder(rs.getInt("idOrder"));
                retouch.setIdProduct(rs.getInt("idProduct"));
                retouch.setIdArtist(rs.getInt("idArtist"));
                retouch.setIdSupervisor(rs.getInt("idSupervisor"));
                retouch.setDateTimeArtistRequest(new java.util.Date(rs.getDate("dateTimeArtistRequest").getTime()));
                retouch.setDateTimeUploadRetouch(new java.util.Date(rs.getDate("dateTimeUploadRetouch").getTime()));
                retouch.setFileNombre(rs.getString("fileNombre"));
                retouch.setPhotoId(rs.getInt("photoId"));
                lista.add(retouch);
            }
        } catch (Exception ex) {
            throw new CoreException(ex);
        } finally {
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return lista;
    }
    
    public List<Retouch> listarReworkByArtist(int idArtist) throws CoreException {
        List<Retouch> lista = new ArrayList<>();
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_RetouchReworkByArtist(?)}");
            cl.setInt(1, idArtist);
            rs = cl.executeQuery();
            while (rs.next()) {
                Retouch retouch = new Retouch();
                retouch.setIdRetouch(rs.getInt("idRetouch"));
                retouch.setIdOrder(rs.getInt("idOrder"));
                retouch.setIdProduct(rs.getInt("idProduct"));
                retouch.setIdArtist(rs.getInt("idArtist"));
                retouch.setIdSupervisor(rs.getInt("idSupervisor"));
                retouch.setDateTimeArtistRequest(new java.util.Date(rs.getDate("dateTimeArtistRequest").getTime()));
                retouch.setDateTimeUploadRetouch(new java.util.Date(rs.getDate("dateTimeUploadRetouch").getTime()));
                retouch.setFileNombre(rs.getString("fileNombre"));
                retouch.setPhotoId(rs.getInt("photoId"));
                lista.add(retouch);
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
    
    public List<Retouch> listarReferencesOfApprovedOrders(int idArtist) throws CoreException {
        List<Retouch> lista = new ArrayList<>();
        try {
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_ArtistPhotoReferencesOfApprovedOrders(?)}");
            cl.setInt(1, idArtist);
            rs = cl.executeQuery();
            while (rs.next()) {
                Retouch retouch = new Retouch();
                retouch.setIdRetouch(rs.getInt("idRetouch"));
                retouch.setIdOrder(rs.getInt("idOrder"));
                retouch.setIdProduct(rs.getInt("idProduct"));
                retouch.setIdArtist(rs.getInt("idArtist"));
                retouch.setIdSupervisor(rs.getInt("idSupervisor"));
                retouch.setDateTimeArtistRequest(new java.util.Date(rs.getDate("dateTimeArtistRequest").getTime()));
                retouch.setDateTimeUploadRetouch(new java.util.Date(rs.getDate("dateTimeUploadRetouch").getTime()));
                retouch.setFileNombre(rs.getString("fileNombre"));
                retouch.setPhotoId(rs.getInt("photoId"));
                lista.add(retouch);
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
