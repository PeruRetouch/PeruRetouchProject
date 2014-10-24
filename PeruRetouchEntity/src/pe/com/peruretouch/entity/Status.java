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
public class Status {
    private Integer idStatus;
    private String name;
    private String description;
    private String state;

    public Status() {
    }

    public Status(Integer idStatus, String name, String description, String state) {
        this.idStatus = idStatus;
        this.name = name;
        this.description = description;
        this.state = state;
    }

    public Integer getIdStatus() {
        return idStatus;
    }

    public void setIdStatus(Integer idStatus) {
        this.idStatus = idStatus;
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

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
