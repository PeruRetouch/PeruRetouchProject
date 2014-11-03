/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package pe.com.peruretouch.entity;

import java.util.Date;

/**
 *
 * @author Roy Taza Rojas
 */
public class Orden {
    private Integer idOrder;
    private Integer idClient;
    private String orderName;
    private Date dateTimeClientRequest;
    private String specifications;
    private Double total;
    private String state;

    public Orden() {
    }

    public Orden(Integer idOrder, Integer idClient, String orderName, Date dateTimeClientRequest, String specifications, Double total, String state) {
        this.idOrder = idOrder;
        this.idClient = idClient;
        this.orderName = orderName;
        this.dateTimeClientRequest = dateTimeClientRequest;
        this.specifications = specifications;
        this.total = total;
        this.state = state;
    }

    public Integer getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(Integer idOrder) {
        this.idOrder = idOrder;
    }

    public Integer getIdClient() {
        return idClient;
    }

    public void setIdClient(Integer idClient) {
        this.idClient = idClient;
    }

    public String getOrderName() {
        return orderName;
    }

    public void setOrderName(String orderName) {
        this.orderName = orderName;
    }

    public Date getDateTimeClientRequest() {
        return dateTimeClientRequest;
    }

    public void setDateTimeClientRequest(Date dateTimeClientRequest) {
        this.dateTimeClientRequest = dateTimeClientRequest;
    }

    public String getSpecifications() {
        return specifications;
    }

    public void setSpecifications(String specifications) {
        this.specifications = specifications;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
