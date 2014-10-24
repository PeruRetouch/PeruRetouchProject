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
public class OrderXStatus {
    private Integer idOrder;
    private Integer idStatus;

    public OrderXStatus() {
    }

    public OrderXStatus(Integer idOrder, Integer idStatus) {
        this.idOrder = idOrder;
        this.idStatus = idStatus;
    }

    public Integer getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(Integer idOrder) {
        this.idOrder = idOrder;
    }

    public Integer getIdStatus() {
        return idStatus;
    }

    public void setIdStatus(Integer idStatus) {
        this.idStatus = idStatus;
    }

    
}
