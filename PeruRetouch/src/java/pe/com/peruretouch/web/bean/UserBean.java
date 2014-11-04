/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package pe.com.peruretouch.web.bean;

import java.io.Serializable;

/**
 *
 * @author Roy Taza Rojas
 */
public class UserBean implements Serializable{
    private Integer idUser;
    private String name;
    private String lastName;
    private Integer idProfile;
    private String privilege;
    private String userName;
    private String email;

    public UserBean() {
    }

    public UserBean(Integer idUser, String name, String lastName, Integer idProfile, String privilege, String userName, String email) {
        this.idUser = idUser;
        this.name = name;
        this.lastName = lastName;
        this.idProfile = idProfile;
        this.privilege = privilege;
        this.userName = userName;
        this.email = email;
    }

    public Integer getIdUser() {
        return idUser;
    }

    public void setIdUser(Integer idUser) {
        this.idUser = idUser;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Integer getIdProfile() {
        return idProfile;
    }

    public void setIdProfile(Integer idProfile) {
        this.idProfile = idProfile;
    }

    public String getPrivilege() {
        return privilege;
    }

    public void setPrivilege(String privilege) {
        this.privilege = privilege;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
