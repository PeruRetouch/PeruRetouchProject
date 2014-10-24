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
import pe.com.peruretouch.entity.Product;

/**
 *
 * @author Roy Taza Rojas
 */
public final class ProductDao extends BaseDao<Product>{
    
    private final static ProductDao PRODUCT_DAO = new ProductDao();

    private ProductDao() {
    }

    public static ProductDao obtenerInstancia() {
        return PRODUCT_DAO;
    }

    @Override
    public void insertar(Product e) throws CoreException {
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spI_Product(?,?,?,?,?)}");
            cl.setString(1, e.getName());
            cl.setString(2, e.getDescription());
            cl.setString(3, e.getAbreviation());
            cl.setDouble(4, e.getPrice());
            cl.setString(5, e.getState());
            cl.executeUpdate();
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public void actualizar(Product e) throws CoreException {
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spU_Product(?,?,?,?,?,?)}");
            cl.setInt(1, e.getIdProduct());
            cl.setString(2, e.getName());
            cl.setString(3, e.getDescription());
            cl.setString(4, e.getAbreviation());
            cl.setDouble(5, e.getPrice());
            cl.setString(6, e.getState());
            cl.executeUpdate();
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public void eliminar(Product e) throws CoreException {
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spD_Product(?)}");
            cl.setInt(1, e.getIdProduct());
            cl.executeUpdate();
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(cn);
        }
    }

    @Override
    public Product obtener(Product e) throws CoreException {
        Product product = null;
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_Product(?)}");
            cl.setInt(1, e.getIdProduct());
            rs = cl.executeQuery();
            while(rs.next()){
                product = new Product();
                product.setIdProduct(rs.getInt("idProduct"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setAbreviation(rs.getString("abreviation"));
                product.setPrice(rs.getDouble("price"));
                product.setState(rs.getString("state"));
            }
        }catch(Exception ex){
            throw new CoreException(ex);
        }finally{
            cerrar(cl);
            cerrar(rs);
            cerrar(cn);
        }
        return product;
    }

    @Override
    public List<Product> listar() throws CoreException {
        List<Product> lista = new ArrayList<>();
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_Product_all()}");
            rs = cl.executeQuery();
            while(rs.next()){
                Product product = new Product();
                product.setIdProduct(rs.getInt("idProduct"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setAbreviation(rs.getString("abreviation"));
                product.setPrice(rs.getDouble("price"));
                product.setState(rs.getString("state"));
                lista.add(product);
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
    
    public List<Product> listarProducts() throws CoreException {
        List<Product> lista = new ArrayList<>();
        try{
            cn = obtenerConexion();
            cl = cn.prepareCall("{CALL spF_Product_all()}");
            rs = cl.executeQuery();
            rs.next();
            while(rs.next()){
                Product product = new Product();
                product.setIdProduct(rs.getInt("idProduct"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setAbreviation(rs.getString("abreviation"));
                product.setPrice(rs.getDouble("price"));
                product.setState(rs.getString("state"));
                lista.add(product);
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
