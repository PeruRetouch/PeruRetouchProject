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
public class Retouch {
    private Integer idRetouch;
    private Integer idOrder;
    private Integer idProduct;
    private Integer idArtist;
    private Integer idSupervisor;
    private Date dateTimeArtistRequest;
    private Date dateTimeUploadRetouch;
    private String fileNombre;
    private Integer photoId;

    public Retouch() {
    }

    public Retouch(Integer idRetouch, Integer idOrder, Integer idProduct, Integer idArtist, Integer idSupervisor, Date dateTimeArtistRequest, Date dateTimeUploadRetouch, String fileNombre, Integer photoId) {
        this.idRetouch = idRetouch;
        this.idOrder = idOrder;
        this.idProduct = idProduct;
        this.idArtist = idArtist;
        this.idSupervisor = idSupervisor;
        this.dateTimeArtistRequest = dateTimeArtistRequest;
        this.dateTimeUploadRetouch = dateTimeUploadRetouch;
        this.fileNombre = fileNombre;
        this.photoId = photoId;
    }

    public Integer getIdRetouch() {
        return idRetouch;
    }

    public void setIdRetouch(Integer idRetouch) {
        this.idRetouch = idRetouch;
    }

    public Integer getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(Integer idOrder) {
        this.idOrder = idOrder;
    }

    public Integer getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(Integer idProduct) {
        this.idProduct = idProduct;
    }

    public Integer getIdArtist() {
        return idArtist;
    }

    public void setIdArtist(Integer idArtist) {
        this.idArtist = idArtist;
    }

    public Integer getIdSupervisor() {
        return idSupervisor;
    }

    public void setIdSupervisor(Integer idSupervisor) {
        this.idSupervisor = idSupervisor;
    }

    public Date getDateTimeArtistRequest() {
        return dateTimeArtistRequest;
    }

    public void setDateTimeArtistRequest(Date dateTimeArtistRequest) {
        this.dateTimeArtistRequest = dateTimeArtistRequest;
    }

    public Date getDateTimeUploadRetouch() {
        return dateTimeUploadRetouch;
    }

    public void setDateTimeUploadRetouch(Date dateTimeUploadRetouch) {
        this.dateTimeUploadRetouch = dateTimeUploadRetouch;
    }

    public String getFileNombre() {
        return fileNombre;
    }

    public void setFileNombre(String fileNombre) {
        this.fileNombre = fileNombre;
    }

    public Integer getPhotoId() {
        return photoId;
    }

    public void setPhotoId(Integer photoId) {
        this.photoId = photoId;
    }
}
