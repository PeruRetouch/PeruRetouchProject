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
import pe.com.peruretouch.dao.dao.ProductDao;
import pe.com.peruretouch.dao.util.CoreException;
import pe.com.peruretouch.entity.Product;

/**
 *
 * @author Roy Taza Rojas
 */
public final class ProductBusiness implements BaseBusiness<Product> {

    private final static ProductDao PRODUCT_DAO = ProductDao.obtenerInstancia();
    private final static ProductBusiness PRODUCT_BUSINESS = new ProductBusiness();

    private ProductBusiness() {
    }

    public static ProductBusiness obtenerEntidad() {
        return PRODUCT_BUSINESS;
    }

    @Override
    public Product ejecutar(OperacionEnum operacionEnum, Product product) throws BusinessException {
        try {
            if (operacionEnum == OperacionEnum.GUARDAR) {
                if (product.getIdProduct() == null || product.getIdProduct() <= 0) {
                    PRODUCT_DAO.insertar(product);
                } else {
                    PRODUCT_DAO.actualizar(product);
                }
            } else if (operacionEnum == OperacionEnum.ELIMINAR) {
                PRODUCT_DAO.eliminar(product);
            } else if (operacionEnum == OperacionEnum.OBTENER) {
                product = PRODUCT_DAO.obtener(product);
            } else if (operacionEnum == OperacionEnum.ACTUALIZAR) {
                PRODUCT_DAO.actualizar(product);
            }
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
        return product;
    }

    @Override
    public List<Product> listar() throws BusinessException {
        try {
            return PRODUCT_DAO.listar();
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }
    
    public List<Product> listarProducts() throws BusinessException {
        try {
            return PRODUCT_DAO.listarProducts();
        } catch (CoreException ex) {
            throw new BusinessException(ex);
        }
    }
}
