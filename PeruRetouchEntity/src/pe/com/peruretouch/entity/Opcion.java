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
public class Opcion {

    private Integer idOpcion;
    private String name;
    private String description;

    public Opcion() {
    }

    public Opcion(Integer idOpcion, String name, String description) {
        this.idOpcion = idOpcion;
        this.name = name;
        this.description = description;
    }

    public Integer getIdOpcion() {
        return idOpcion;
    }

    public void setIdOpcion(Integer idOpcion) {
        this.idOpcion = idOpcion;
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
}
