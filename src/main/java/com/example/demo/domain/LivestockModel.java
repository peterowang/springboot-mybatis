package com.example.demo.domain;


import com.example.demo.enums.LivestockType;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.StringUtils;

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
    private Long livestockMasterId;
    private String type;
    private String state;
    private String initialWeight;
    private Date initialTime;
    private String lairageWeight;
    private Date lairageTime;
    private String birthplace;
    private Long varietiesId;
    private String sex;
    private String isPregnancy;
    private String picture;
    private Date createTime;
    private Date updateTime;
    private Long parentId;
    private String enterpriseName;
    private String varietiesType;


    public String getEnterpriseName() {
        return enterpriseName;
    }

    public void setEnterpriseName(String enterpriseName) {
        this.enterpriseName = enterpriseName;
    }

    public String getVarietiesType() {
        return varietiesType;
    }

    public void setVarietiesType(String varietiesType) {
        this.varietiesType = varietiesType;
    }

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

    public Long getLivestockMasterId() {
        return livestockMasterId;
    }

    public void setLivestockMasterId(Long livestockMasterId) {
        this.livestockMasterId = livestockMasterId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getState() {
        if (LivestockType.Num_SLAUGHTERED.getNum().equals(state)) {
            return LivestockType.Num_SLAUGHTERED.getType();
        } else if (LivestockType.Num_Live.getNum().equals(state)) {
            return LivestockType.Num_Live.getType();
        } else if (LivestockType.Num_QUAR_NOT_APPROVED.getNum().equals(state)) {
            return LivestockType.Num_QUAR_NOT_APPROVED.getType();
        } else if (LivestockType.Num_ONLINE_SALE.getNum().equals(state)) {
            return LivestockType.Num_ONLINE_SALE.getType();
        } else if (LivestockType.Num_OFFLINE_SALE.getNum().equals(state)) {
            return LivestockType.Num_OFFLINE_SALE.getType();
        } else if (LivestockType.Num_DEAD.getNum().equals(state)) {
            return LivestockType.Num_DEAD.getType();
        }
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getInitialWeight() {
        return initialWeight;
    }

    public void setInitialWeight(String initialWeight) {
        this.initialWeight = initialWeight;
    }

    public Date getInitialTime() {
        return initialTime;
    }

    public void setInitialTime(Date initialTime) {
        this.initialTime = initialTime;
    }

    public String getLairageWeight() {
        return lairageWeight;
    }

    public void setLairageWeight(String lairageWeight) {
        this.lairageWeight = lairageWeight;
    }

    public Date getLairageTime() {
        return lairageTime;
    }

    public void setLairageTime(Date lairageTime) {
        this.lairageTime = lairageTime;
    }

    public String getBirthplace() {
        return birthplace;
    }

    public void setBirthplace(String birthplace) {
        this.birthplace = birthplace;
    }

    public Long getVarietiesId() {
        return varietiesId;
    }

    public void setVarietiesId(Long varietiesId) {
        this.varietiesId = varietiesId;
    }

    public String getSex() {
        if(StringUtils.isNotEmpty(sex)&&!sex.equals("2")){
            sex = sex.equals("0") ? "男" : "女";
        }
        if(sex.equals("2")){
                if(varietiesType.equals("1")){
                   sex = "犍牛";
                }else if(varietiesType.equals("2")){
                   sex = "羯羊";
                }
        }
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getIsPregnancy() {
        return isPregnancy;
    }

    public void setIsPregnancy(String isPregnancy) {
        this.isPregnancy = isPregnancy;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    @Override
    public String toString() {
        return "LivestockModel{" +
                "id=" + id +
                ", equipmentId=" + equipmentId +
                ", number='" + number + '\'' +
                ", enterpriseId=" + enterpriseId +
                ", livestockMasterId=" + livestockMasterId +
                ", type='" + type + '\'' +
                ", state='" + state + '\'' +
                ", initialWeight='" + initialWeight + '\'' +
                ", initialTime=" + initialTime +
                ", lairageWeight='" + lairageWeight + '\'' +
                ", lairageTime=" + lairageTime +
                ", birthplace='" + birthplace + '\'' +
                ", varietiesId=" + varietiesId +
                ", sex='" + sex + '\'' +
                ", isPregnancy='" + isPregnancy + '\'' +
                ", picture='" + picture + '\'' +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                ", parentId=" + parentId +
                ", enterpriseName='" + enterpriseName + '\'' +
                ", varietiesType='" + varietiesType + '\'' +
                '}';
    }
}
