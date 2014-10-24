/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.com.peruretouch.dao.util;

import java.util.ResourceBundle;

/**
 *
 * @author Roy Taza Rojas
 */
public final class UtilCore {

    private UtilCore() {
    }

    public static String obtenerPropiedad(String clave) {
        ResourceBundle rb = ResourceBundle.getBundle("propiedades");
        return rb.getString(clave);
    }
}
