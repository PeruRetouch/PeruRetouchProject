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
public class RetouchXStatus {
    private Integer idRetouch;
    private Integer idStatus;

    public RetouchXStatus() {
    }

    public RetouchXStatus(Integer idRetouch, Integer idStatus) {
        this.idRetouch = idRetouch;
        this.idStatus = idStatus;
    }

    public Integer getIdRetouch() {
        return idRetouch;
    }

    public void setIdRetouch(Integer idRetouch) {
        this.idRetouch = idRetouch;
    }

    public Integer getIdStatus() {
        return idStatus;
    }

    public void setIdStatus(Integer idStatus) {
        this.idStatus = idStatus;
    }
    

}