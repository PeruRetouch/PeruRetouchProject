/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.com.peruretouch.business;

import java.util.List;
import pe.com.peruretouch.business.base.BaseBusiness;
import pe.com.peruretouch.business.base.BusinessException;
import pe.com.peruretouch.business.base.OperacionEnum;
import pe.com.peruretouch.dao.dao.RetouchDao;
import pe.com.peruretouch.dao.util.CoreException;
import pe.com.peruretouch.entity.Retouch;

/**
 *
 * @author Roy Taza Rojas
 */
public final class RetouchBusiness implements BaseBusiness<Retouch> {

    private final static RetouchDao RETOUCH_DAO = RetouchDao.obtenerInstancia();
    private final static RetouchBusiness RETOUCH_BUSINESS = new RetouchBusiness();

    private RetouchBusiness() {
    }

    public static RetouchBusiness obtenerEntidad() {
        return RETOUCH_BUSINESS;
    }

    @Override
    public Retouch ejecutar(OperacionEnum operacionEnum, Retouch retouch) throws BusinessException {
        try {
            if (operacionEnum == OperacionEnum.GUARDAR) {
                if (retouch.getIdRetouch() == null || retouch.getIdRetouch() <= 0) {
                    RETOUCH_DAO.insertar(retouch);
                } else {
                    RETOUCH_DAO.actualizar(retouch);
                }
            } else if (operacionEnum == OperacionEnum.ELIMINAR) {
                RETOUCH_DAO.eliminar(retouch);
            } else if (operacionEnum == OperacionEnum.OBTENER) {
                retouch = RETOUCH_DAO.obtener(retouch);
            } else if (operacionEnum == OperacionEnum.ACTUALIZAR) {
                RETOUCH_DAO.actualizar(retouch);
            }
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
        return retouch;
    }

    @Override
    public List<Retouch> listar() throws BusinessException {
        try {
            return RETOUCH_DAO.listar();
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }

    public int insertOrderAndReturnId(Retouch retouch) throws BusinessException {
        try {
            return RETOUCH_DAO.insertarAndReturnId(retouch);
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }

    public List<Retouch> listarByOrder(int idOrder) throws BusinessException {
        try {
            return RETOUCH_DAO.listarByOrder(idOrder);
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }

    public List<Retouch> listarByArtist(int idArtist) throws BusinessException {
        try {
            return RETOUCH_DAO.listarByArtist(idArtist);
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }

    public Retouch obtenerByFileNombre(String fileNombre) throws CoreException {
        try {
            return RETOUCH_DAO.obtenerByFileNombre(fileNombre);
        } catch (CoreException ex) {
            throw new CoreException(ex);
        }
    }

    public Retouch obtenerRetouchPendienteByFileNombreAndArtist(String fileNombre, int idArtist) throws CoreException {
        try {
            return RETOUCH_DAO.obtenerRetouchPendienteByFileNombreAndArtist(fileNombre, idArtist);
        } catch (CoreException ex) {
            throw new CoreException(ex);
        }
    }

    public List<Retouch> obtenerRetouchByOrderAndClient(int idOrder, int idClient) throws CoreException {
        try {
            return RETOUCH_DAO.obtenerRetouchByOrderAndClient(idOrder, idClient);
        } catch (CoreException ex) {
            throw new CoreException(ex);
        }
    }

    public List<Retouch> obtenerRetouchPendienteByOrder(int idArtist, int idOrder) throws CoreException {
        try {
            return RETOUCH_DAO.obtenerRetouchPendienteByOrder(idArtist, idOrder);
        } catch (CoreException ex) {
            throw new CoreException(ex);
        }
    }

    public List<Retouch> listarReworkByArtist(int idArtist) throws CoreException {
        try {
            return RETOUCH_DAO.listarReworkByArtist(idArtist);
        } catch (CoreException ex) {
            throw new CoreException(ex);
        }
    }
}
