/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.com.peruretouch.dao.base;

import java.util.List;
import pe.com.peruretouch.dao.util.CoreException;

/**
 *
 * @author Roy Taza Rojas
 * @param <E>
 */
interface EntityDao<E> {

    int insertar(E e) throws CoreException;

    void actualizar(E e) throws CoreException;

    void eliminar(E e) throws CoreException;

    E obtener(E e) throws CoreException;

    List<E> listar() throws CoreException;

}
