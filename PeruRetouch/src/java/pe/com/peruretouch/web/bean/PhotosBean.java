/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.com.peruretouch.web.bean;

import java.io.File;
import java.util.LinkedHashSet;
import javax.servlet.http.HttpSession;
import pe.com.peruretouch.web.util.ConstantesWeb;

/**
 *
 * @author Roy Taza Rojas
 */
public final class PhotosBean {

    private final static ProductBean PRODUCT_BEAN = new ProductBean();
    //private final static List<String> LIST_PHOTOS_UPLOADED = new ArrayList<String>();
    //private final static LinkedHashSet<String> LIST_PHOTOS_UPLOADED = new LinkedHashSet<String>();

    private PhotosBean() {
    }

    public static ProductBean getInstancia() {
        return PRODUCT_BEAN;
    }
    /*
     public static LinkedHashSet<String> getListPhotos() {
     return LIST_PHOTOS_UPLOADED;
     }

     public static boolean addPhotoToList(String fileName) {
     return LIST_PHOTOS_UPLOADED.add(fileName);
     }

     public static void removeAllPhotosFromTheList(String fileSavePath) {
     if (!LIST_PHOTOS_UPLOADED.isEmpty()) {
     for (String s : LIST_PHOTOS_UPLOADED) {
     File file = new File(fileSavePath + "/" + s);
     file.delete();
     }
     LIST_PHOTOS_UPLOADED.clear();
     }
     }
     */

    // CON SESION
    public static LinkedHashSet<String> getListPhotos(HttpSession sesion) {
        return (LinkedHashSet<String>) sesion.getAttribute(ConstantesWeb.PHOTO_LIST);
    }

    public static boolean addPhotoToList(HttpSession sesion, String fileName) {
        // Obtener la lista actual de la sesion
        LinkedHashSet<String> list_photos;
        if (sesion.getAttribute(ConstantesWeb.PHOTO_LIST) == null) {
            // Si NO existe se crea la lista
            list_photos = new LinkedHashSet<String>();
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

    public static void removeAllPhotosFromTheList(HttpSession sesion, String fileSavePath) {
        LinkedHashSet<String> list_photos = (LinkedHashSet<String>) sesion.getAttribute(ConstantesWeb.PHOTO_LIST);
        if (list_photos != null) {
            if (!list_photos.isEmpty()) {
                for (String s : list_photos) {
                    File file = new File(fileSavePath + "/" + s);
                    file.delete();
                }
                list_photos.clear();
            }
        }
    }
}
