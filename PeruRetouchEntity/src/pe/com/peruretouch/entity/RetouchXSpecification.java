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
public class RetouchXSpecification {
    private Integer idRetouchXSpecification;
    private Integer idRetouch;
    private Integer idSpecificationType;
    private Integer idAutor;
    private Date dateTimeSpecification;
    private String specification;

    public RetouchXSpecification() {
    }

    public RetouchXSpecification(Integer idRetouchXSpecification, Integer idRetouch, Integer idSpecificationType, Integer idAutor, Date dateTimeSpecification, String specification) {
        this.idRetouchXSpecification = idRetouchXSpecification;
        this.idRetouch = idRetouch;
        this.idSpecificationType = idSpecificationType;
        this.idAutor = idAutor;
        this.dateTimeSpecification = dateTimeSpecification;
        this.specification = specification;
    }

    public Integer getIdRetouchXSpecification() {
        return idRetouchXSpecification;
    }

    public void setIdRetouchXSpecification(Integer idRetouchXSpecification) {
        this.idRetouchXSpecification = idRetouchXSpecification;
    }

    public Integer getIdRetouch() {
        return idRetouch;
    }

    public void setIdRetouch(Integer idRetouch) {
        this.idRetouch = idRetouch;
    }

    public Integer getIdSpecificationType() {
        return idSpecificationType;
    }

    public void setIdSpecificationType(Integer idSpecificationType) {
        this.idSpecificationType = idSpecificationType;
    }

    public Integer getIdAutor() {
        return idAutor;
    }

    public void setIdAutor(Integer idAutor) {
        this.idAutor = idAutor;
    }

    public Date getDateTimeSpecification() {
        return dateTimeSpecification;
    }

    public void setDateTimeSpecification(Date dateTimeSpecification) {
        this.dateTimeSpecification = dateTimeSpecification;
    }

    public String getSpecification() {
        return specification;
    }

    public void setSpecification(String specification) {
        this.specification = specification;
    }

    
}
