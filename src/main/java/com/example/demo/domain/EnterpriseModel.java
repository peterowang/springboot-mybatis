package com.example.demo.domain;

import javax.persistence.Table;

/**
 * Created by BFD-593 on 2017/8/29.
 */
@Table(name="enterprise")
public class EnterpriseModel {
    private Long id;
    private String enterpriseName;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEnterpriseName() {
        return enterpriseName;
    }

    public void setEnterpriseName(String enterpriseName) {
        this.enterpriseName = enterpriseName;
    }
}
