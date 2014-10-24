package pe.com.peruretouch.web.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
//@author  Henry Joe Wong Urquiza

public class ManejadorFechas {

    public static String formatoFecha = "yyyy-MM-dd";
    public static String formatoHora = "hh:mm:ss";
    public static String formatoFechaHora = "yyyy-MM-dd hh:mm:ss";

    //Metodo usado para obtener la fecha actual
    //@return Retorna un <b>STRING</b> con la fecha actual formato "dd-MM-yyyy"
    public static String getFechaActual() {
        Date ahora = new Date();
        SimpleDateFormat formateador = new SimpleDateFormat(formatoFecha);
        return formateador.format(ahora);
    }

    //Metodo usado para obtener la hora actual del sistema
    //@return Retorna un <b>STRING</b> con la hora actual formato "hh:mm:ss"
    public static String getHoraActual() {
        /*
         Date ahora = new Date();
         SimpleDateFormat formateador = new SimpleDateFormat(formatoHora);
         return formateador.format(ahora);*/
        //Calendar calendario = Calendar.getInstance();
        Calendar calendario = new GregorianCalendar();
        int hora, minutos, segundos;
        hora = calendario.get(Calendar.HOUR_OF_DAY);
        minutos = calendario.get(Calendar.MINUTE);
        segundos = calendario.get(Calendar.SECOND);
        return hora + ":" + minutos + ":" + segundos;
    }

    //Sumarle dias a una fecha determinada
    //@param fch La fecha para sumarle los dias
    //@param dias Numero de dias a agregar
    //@return La fecha agregando los dias
    public static java.sql.Date sumarFechasDias(java.sql.Date fch, int dias) {
        Calendar cal = new GregorianCalendar();
        cal.setTimeInMillis(fch.getTime());
        cal.add(Calendar.DATE, dias);
        return new java.sql.Date(cal.getTimeInMillis());
    }

    //Restarle dias a una fecha determinada
    //@param fch La fecha
    //@param dias Dias a restar
    //@return La fecha restando los dias
    public static synchronized java.sql.Date restarFechasDias(java.sql.Date fch, int dias) {
        Calendar cal = new GregorianCalendar();
        cal.setTimeInMillis(fch.getTime());
        cal.add(Calendar.DATE, -dias);
        return new java.sql.Date(cal.getTimeInMillis());
    }

    //Diferencias entre dos fechas
    //@param fechaInicial La fecha de inicio
    //@param fechaFinal  La fecha de fin
    //@return Retorna el numero de dias entre dos fechas
    public static synchronized int diferenciasDeFechas(Date fechaInicial, Date fechaFinal) {

        DateFormat df = DateFormat.getDateInstance(DateFormat.MEDIUM);
        String fechaInicioString = df.format(fechaInicial);
        try {
            fechaInicial = df.parse(fechaInicioString);
        } catch (ParseException ex) {
        }

        String fechaFinalString = df.format(fechaFinal);
        try {
            fechaFinal = df.parse(fechaFinalString);
        } catch (ParseException ex) {
        }

        long fechaInicialMs = fechaInicial.getTime();
        long fechaFinalMs = fechaFinal.getTime();
        long diferencia = fechaFinalMs - fechaInicialMs;
        double dias = Math.floor(diferencia / (1000 * 60 * 60 * 24));
        return ((int) dias);
    }

    //Devuele un java.util.Date desde un String en formato dd-MM-yyyy
    //@param La fecha a convertir a formato date
    //@return Retorna la fecha en formato Date
    public static synchronized java.util.Date deStringToDateTime(String fecha) {
        SimpleDateFormat formatoDelTexto = new SimpleDateFormat(formatoFechaHora);
        Date fechaEnviar = null;
        try {
            fechaEnviar = formatoDelTexto.parse(fecha);
            return fechaEnviar;
        } catch (ParseException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public static synchronized java.sql.Date deUtilDateToSqlDate(Date utilDate) {
        java.util.Calendar cal = Calendar.getInstance();
        cal.setTime(utilDate);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        java.sql.Date sqlDate = new java.sql.Date(cal.getTime().getTime()); // your sql date
        
        return sqlDate;

        /*
         SimpleDateFormat formatoDelTexto = new SimpleDateFormat(formatoFechaHora);
         Date fechaEnviar = null;
         try {
         fechaEnviar = formatoDelTexto.parse(fecha);
         return fechaEnviar;
         } catch (ParseException ex) {
         ex.printStackTrace();
         return null;
         }
                
         */
    }

    public static synchronized java.util.Date getFechaEdadMinima18Anios() {
        Date ahora = new Date();
        SimpleDateFormat formateador = new SimpleDateFormat(formatoFecha);

        Calendar cal = new GregorianCalendar();
        cal.setTimeInMillis(ahora.getTime());

        cal.add(Calendar.YEAR, -18);

        return new java.sql.Date(cal.getTimeInMillis());
    }

    public static synchronized String deFechaToStringSoloFecha(Date fch) {
        String fechaString = "";
        Calendar cal = new GregorianCalendar();
        cal.setTimeInMillis(fch.getTime());
        fechaString += cal.get(Calendar.YEAR);
        fechaString += "-";
        fechaString += cal.get(Calendar.MONTH);
        fechaString += "-";
        fechaString += cal.get(Calendar.DAY_OF_MONTH);
        return fechaString;
    }
}
