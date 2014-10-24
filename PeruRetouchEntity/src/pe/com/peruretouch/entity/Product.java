/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package pe.com.peruretouch.entity;

/**
 *
 * @author Roy Taza Rojas
 */
public class Product {
    private Integer idProduct;
    private String name;
    private String description;
    private String abreviation;
    private Double price;
    private String state;

    public Product() {
    }

    public Product(Integer idProduct, String name, String description, String abreviation, Double price, String state) {
        this.idProduct = idProduct;
        this.name = name;
        this.description = description;
        this.abreviation = abreviation;
        this.price = price;
        this.state = state;
    }

    public Integer getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(Integer idProduct) {
        this.idProduct = idProduct;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAbreviation() {
        return abreviation;
    }

    public void setAbreviation(String abreviation) {
        this.abreviation = abreviation;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
