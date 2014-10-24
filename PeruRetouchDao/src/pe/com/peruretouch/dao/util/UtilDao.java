/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package pe.com.peruretouch.dao.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Roy Taza Rojas
 */
public final class UtilDao {
    
    private UtilDao(){
        
    }
    
    public static final String convertirDate(Date fecha) throws Exception{
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(fecha);
    }
    
    public static final String convertirDate(Date fecha, String formato){
        SimpleDateFormat sdf=new SimpleDateFormat(formato);
        return sdf.format(fecha);
    }
    
    public static final Date convertirString(String fecha, String formato){
        SimpleDateFormat formatter = new SimpleDateFormat(formato);
        Date fechaConvertida = new Date();
	try {
            fechaConvertida = formatter.parse(fecha);
	} catch (Exception e) {
            e.printStackTrace();
	}
        return fechaConvertida;
    }
    
    public static final java.sql.Date convertirDateUtil(Date fecha) {
        return new java.sql.Date(fecha.getTime());
    }
    
}