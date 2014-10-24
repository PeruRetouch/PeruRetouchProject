/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package pe.com.peruretouch.entity;

/**
 *
 * @author Roy Taza Rojas
 */
public class Profile {
    private Integer idProfile;
    private String name;
    private String description;
    private String state;

    public Profile() {
    }

    public Profile(Integer idProfile, String name, String description, String state) {
        this.idProfile = idProfile;
        this.name = name;
        this.description = description;
        this.state = state;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
