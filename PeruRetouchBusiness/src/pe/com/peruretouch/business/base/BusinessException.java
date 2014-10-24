/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package pe.com.peruretouch.business.base;

/**
 *
 * @author Roy Taza Rojas
 */
public class BusinessException extends Exception {
    
    public BusinessException() {
    }
    
    public BusinessException(String msg) {
        super(msg);
    }
    
    public BusinessException(Throwable cause) {
        super(cause);
    }
    
    public BusinessException(String message, Throwable cause) {
        super(message, cause);
    }
}
