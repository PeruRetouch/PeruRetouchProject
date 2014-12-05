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
public class UserXOpcion {

    private Integer idUser;
    private Integer idOpcion;
    private Integer value;

    public UserXOpcion() {
    }

    public UserXOpcion(Integer idUser, Integer idOpcion, Integer value) {
        this.idUser = idUser;
        this.idOpcion = idOpcion;
        this.value = value;
    }

    public Integer getIdUser() {
        return idUser;
    }

    public void setIdUser(Integer idUser) {
        this.idUser = idUser;
    }

    public Integer getIdOpcion() {
        return idOpcion;
    }

    public void setIdOpcion(Integer idOpcion) {
        this.idOpcion = idOpcion;
    }

    public Integer getValue() {
        return value;
    }

    public void setValue(Integer value) {
        this.value = value;
    }
}
