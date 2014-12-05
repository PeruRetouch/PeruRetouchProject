/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.com.peruretouch.web.util;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import net.lingala.zip4j.model.ZipParameters;
import net.lingala.zip4j.util.Zip4jConstants;
import pe.com.peruretouch.business.RetouchXStatusBusiness;
import pe.com.peruretouch.business.base.BusinessException;
import pe.com.peruretouch.entity.Retouch;
import pe.com.peruretouch.entity.RetouchXStatus;

/**
 *
 * @author Roy Taza Rojas
 */
public final class UtilZip {

    private UtilZip() {
    }

    public static final String generateZipClient(HttpSession sesion, List<Retouch> listRetouchs, String pathRetouched, String pathZip, String fileName) {
        try {
            ZipFile zipFile = new ZipFile(pathZip + "/" + fileName);
            ZipParameters parameters = new ZipParameters();
            parameters.setCompressionMethod(Zip4jConstants.COMP_DEFLATE); // set compression method to deflate compression
            parameters.setCompressionLevel(Zip4jConstants.DEFLATE_LEVEL_NORMAL);

            ArrayList filesToAdd = new ArrayList();
            boolean guardar;
            for (Retouch retouch : listRetouchs) {
                //Comprobar si la foto tiene retoque
                guardar = false;
                List<RetouchXStatus> listRetouchXStatuses = RetouchXStatusBusiness.obtenerEntidad().listarByRetouch(retouch.getIdRetouch());
                for (RetouchXStatus rxs : listRetouchXStatuses) {
                    if (rxs.getIdStatus() == ConstantesWeb.ID_STATUS_APPROVED
                            || rxs.getIdStatus() == ConstantesWeb.ID_STATUS_REWORKED
                            || rxs.getIdStatus() == ConstantesWeb.ID_STATUS_WAITING_ANSWER) {
                        guardar = true;
                        break;
                    }
                }
                if (guardar) {
                    parameters.setFileNameInZip(retouch.getFileNombre().substring(String.valueOf(retouch.getIdRetouch()).length() + 3));
                    parameters.setSourceExternalStream(true);
                    zipFile.addFile(new File(pathRetouched + "/" + retouch.getFileNombre()), parameters);
                }
            }

            //zipFile.addFiles(filesToAdd, parameters);
            if (zipFile.getFileHeaders().isEmpty()) {
                return "invalid";
            } else {
                return pathZip + "/" + fileName;
            }
        } catch (ZipException e) {
            e.printStackTrace();
        } catch (BusinessException ex) {
            ex.printStackTrace();
        }
        /*
         try {
         ZipFile zipFile = new ZipFile(pathZip + "/" + fileName);

         ArrayList filesToAdd = new ArrayList();
         boolean guardar;
         for (Retouch retouch : listRetouchs) {
         //Comprobar si la foto tiene retoque
         guardar = false;
         List<RetouchXStatus> listRetouchXStatuses = RetouchXStatusBusiness.obtenerEntidad().listarByRetouch(retouch.getIdRetouch());
         for (RetouchXStatus rxs : listRetouchXStatuses) {
         if (rxs.getIdStatus() == ConstantesWeb.ID_STATUS_APPROVED
         || rxs.getIdStatus() == ConstantesWeb.ID_STATUS_REWORKED
         || rxs.getIdStatus() == ConstantesWeb.ID_STATUS_WAITING_ANSWER) {
         guardar = true;
         break;
         }
         }
         if (guardar) {
         filesToAdd.add(new File(pathRetouched + "/" + retouch.getFileNombre()));
         }
         }

         ZipParameters parameters = new ZipParameters();
         parameters.setCompressionMethod(Zip4jConstants.COMP_DEFLATE); // set compression method to deflate compression

         parameters.setCompressionLevel(Zip4jConstants.DEFLATE_LEVEL_NORMAL);

         zipFile.addFiles(filesToAdd, parameters);
         return pathZip + "/" + fileName;
         } catch (ZipException e) {
         e.printStackTrace();
         } catch (BusinessException ex) {
         ex.printStackTrace();
         }
         */
        return "invalid";
    }

    public static final String generateZipArtist(HttpSession sesion, List<Retouch> listRetouchs, String pathRetouched, String pathZip, String fileName) {
        try {
            ZipFile zipFile = new ZipFile(pathZip + "/" + fileName);

            ArrayList filesToAdd = new ArrayList();
            for (Retouch retouch : listRetouchs) {
                filesToAdd.add(new File(pathRetouched + "/" + retouch.getFileNombre()));
            }

            ZipParameters parameters = new ZipParameters();
            parameters.setCompressionMethod(Zip4jConstants.COMP_DEFLATE); // set compression method to deflate compression

            parameters.setCompressionLevel(Zip4jConstants.DEFLATE_LEVEL_NORMAL);

            zipFile.addFiles(filesToAdd, parameters);
            return pathZip + "/" + fileName;
        } catch (ZipException e) {
            e.printStackTrace();
        }
        return "invalid";
    }
}
