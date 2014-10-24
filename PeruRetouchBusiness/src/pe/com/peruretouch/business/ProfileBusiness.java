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
import pe.com.peruretouch.dao.dao.ProfileDao;
import pe.com.peruretouch.dao.util.CoreException;
import pe.com.peruretouch.entity.Profile;

/**
 *
 * @author Roy Taza Rojas
 */
public final class ProfileBusiness implements BaseBusiness<Profile> {

    private final static ProfileDao PROFILE_DAO = ProfileDao.obtenerInstancia();
    private final static ProfileBusiness PROFILE_BUSINESS = new ProfileBusiness();

    private ProfileBusiness() {
    }

    public static ProfileBusiness obtenerEntidad() {
        return PROFILE_BUSINESS;
    }

    @Override
    public Profile ejecutar(OperacionEnum operacionEnum, Profile profile) throws BusinessException {
        try {
            if (operacionEnum == OperacionEnum.GUARDAR) {
                if (profile.getIdProfile() == null || profile.getIdProfile() <= 0) {
                    PROFILE_DAO.insertar(profile);
                } else {
                    PROFILE_DAO.actualizar(profile);
                }
            } else if (operacionEnum == OperacionEnum.ELIMINAR) {
                PROFILE_DAO.eliminar(profile);
            } else if (operacionEnum == OperacionEnum.OBTENER) {
                profile = PROFILE_DAO.obtener(profile);
            } else if (operacionEnum == OperacionEnum.ACTUALIZAR) {
                PROFILE_DAO.actualizar(profile);
            }
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
        return profile;
    }

    @Override
    public List<Profile> listar() throws BusinessException {
        try {
            return PROFILE_DAO.listar();
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }
}
