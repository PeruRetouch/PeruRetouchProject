package pe.com.peruretouch.web.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public final class UtilWeb {

    private UtilWeb() {

    }

    public static final String convertirDate(Date fecha, String formato) {
        SimpleDateFormat sdf = new SimpleDateFormat(formato);
        return sdf.format(fecha);
    }

    public static Date convertirString(String fecha, String formato) {
        SimpleDateFormat formatter = new SimpleDateFormat(formato);
        Date fechaConvertida = new Date();
        try {
            fechaConvertida = formatter.parse(fecha);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fechaConvertida;
    }

    public static String formatName(String name) {
        String formatedName = "";
        int ext = 25;
        if (name.length() > ext) {
            String fileType = name.substring(name.length() - 4, name.length());
            formatedName = name.substring(0, ext - 10) + "..." + fileType;
        } else {
            formatedName = name;
        }
        return formatedName;
    }

    public static String formatName(String name, int aux) {
        String formatedName = "";
        /*
         int ext = 30;
         if (name.length() > ext) {
         String fileType = name.substring(name.length() - 4, name.length());
         formatedName = name.substring(aux + 3, ext - 10) + "..." + fileType;
         } else {
         formatedName = name.substring(aux + 3);
         }
         */
        if (name.length() >= 30) {
            formatedName = name.substring(String.valueOf(aux).length() + 3);
            formatedName = formatedName.substring(0, 30) + "\n" + formatedName.substring(30);
        } else {
            formatedName = name.substring(String.valueOf(aux).length() + 3);
        }
        return formatedName;
    }

    public static boolean renameFile(String fileSavePath, String fileName, String newFileName) {
        // Renombra el archivo
        String pathFileA = fileSavePath + "/" + fileName;
        String pathFileB = fileSavePath + "/" + newFileName;
        File aaa = new File(pathFileA);
        File bbb = new File(pathFileB);
        return aaa.renameTo(bbb);
    }

    public static String newRandomString(Random rng, String characters, int length) {
        char[] text = new char[length];
        for (int i = 0; i < length; i++) {
            text[i] = characters.charAt(rng.nextInt(characters.length()));
        }
        return new String(text);
    }
}
