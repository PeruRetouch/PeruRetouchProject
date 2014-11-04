/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.com.peruretouch.web.bean;

import java.io.File;
import java.io.Serializable;
import java.util.LinkedHashSet;
import javax.servlet.http.HttpSession;
import pe.com.peruretouch.web.util.ConstantesWeb;

/**
 *
 * @author Roy Taza Rojas
 */
public class PhotosBean implements Serializable {

    private LinkedHashSet<String> list_photos;

    public PhotosBean() {
    }

    public LinkedHashSet<String> getListPhotos(HttpSession sesion) {
        this.list_photos = (LinkedHashSet<String>) sesion.getAttribute(ConstantesWeb.PHOTO_LIST);
        return list_photos;
    }

    public boolean addPhotoToList(HttpSession sesion, String fileName) {
        // Obtener la lista actual de la sesion
        this.list_photos = (LinkedHashSet<String>) sesion.getAttribute(ConstantesWeb.PHOTO_LIST);
        if (list_photos == null) {
            // Si NO existe se crea la lista
            list_photos = new LinkedHashSet<>();
        } else {
            // Si SI existe se obtiene la lista
            list_photos = (LinkedHashSet<String>) sesion.getAttribute(ConstantesWeb.PHOTO_LIST);
        }
        // Guardar el nombre del archivo
        boolean wasSaved = list_photos.add(fileName);
        if (wasSaved) {
            // Actualizar la lista de la sesion
            sesion.setAttribute(ConstantesWeb.PHOTO_LIST, list_photos);
            return true;
        } else {
            return false;
        }
    }

    public void removeAllPhotosFromTheList(HttpSession sesion, String fileSavePath) {
        this.list_photos = (LinkedHashSet<String>) sesion.getAttribute(ConstantesWeb.PHOTO_LIST);
        if (list_photos != null) {
            if (!list_photos.isEmpty()) {
                for (String s : list_photos) {
                    File file = new File(fileSavePath + "/" + s);
                    file.delete();
                }
                list_photos.clear();
                sesion.setAttribute(ConstantesWeb.PHOTO_LIST, list_photos);
            }
        }
    }

    public void cleartList2(HttpSession sesion) {
        this.list_photos = (LinkedHashSet<String>) sesion.getAttribute(ConstantesWeb.PHOTO_LIST);
        if (list_photos != null) {
            list_photos = (LinkedHashSet<String>) sesion.getAttribute(ConstantesWeb.PHOTO_LIST);
            list_photos.clear();
            sesion.setAttribute(ConstantesWeb.PHOTO_LIST, list_photos);
        }
    }
}
