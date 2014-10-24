/*
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package pe.com.peruretouch.entity;

import java.util.Date;

/**
 *
 * @author Roy Taza Rojas
 */
public class User {
    private Integer idUser;
    private String userLogin;
    private String password;
    private Integer idProfile;
    private String name;
    private String lastName;
    private String address;
    private String country;
    private Date birthDay;
    private String telephone;
    private String cellphone;
    private String email;
    private String state;

    public User() {
    }

    public User(Integer idUser, String userLogin, String password, Integer idProfile, String name, String lastName, String address, String country, Date birthDay, String telephone, String cellphone, String email, String state) {
        this.idUser = idUser;
        this.userLogin = userLogin;
        this.password = password;
        this.idProfile = idProfile;
        this.name = name;
        this.lastName = lastName;
        this.address = address;
        this.country = country;
        this.birthDay = birthDay;
        this.telephone = telephone;
        this.cellphone = cellphone;
        this.email = email;
        this.state = state;
    }

    public Integer getIdUser() {
        return idUser;
    }

    public void setIdUser(Integer idUser) {
        this.idUser = idUser;
    }

    public String getUserLogin() {
        return userLogin;
    }

    public void setUserLogin(String userLogin) {
        this.userLogin = userLogin;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getIdProfile() {
        return idProfile;
    }

    public void setIdProfile(Integer idProfile) {
        this.idProfile = idProfile;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public Date getBirthDay() {
        return birthDay;
    }

    public void setBirthDay(Date birthDay) {
        this.birthDay = birthDay;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getCellphone() {
        return cellphone;
    }

    public void setCellphone(String cellphone) {
        this.cellphone = cellphone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }    
}
