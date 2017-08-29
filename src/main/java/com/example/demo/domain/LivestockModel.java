package com.example.demo.domain;

import javax.persistence.Table;
import java.util.Date;

/**
 * Created by BFD-593 on 2017/8/29.
 */
@Table(name="livestock")
public class LivestockModel {
    private Long id;
    private Long equipmentId;
    private String number;
    private Long enterpriseId;
    private String enterpriseName;

    public String getEnterpriseName() {
        return enterpriseName;
    }

    public void setEnterpriseName(String enterpriseName) {
        this.enterpriseName = enterpriseName;
    }
    /*    private Long livestockMasterId;
    private String type;
    private String state;
    private String initialWeight;
    private Date initialTime;*/

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getEquipmentId() {
        return equipmentId;
    }

    public void setEquipmentId(Long equipmentId) {
        this.equipmentId = equipmentId;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public Long getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(Long enterpriseId) {
        this.enterpriseId = enterpriseId;
    }
}
