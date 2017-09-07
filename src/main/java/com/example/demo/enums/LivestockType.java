package com.example.demo.enums;

/**
 * Created by BFD-593 on 2017/8/30.
 */
public enum LivestockType {
    Num_Live("00", "饲养"),
    Num_SLAUGHTERED("01", "屠宰"),
    Num_QUAR_NOT_APPROVED("02", "检疫不通过"),
    Num_ONLINE_SALE("03", "线上销售"),
    Num_OFFLINE_SALE("04", "线下销食品"),
    Num_DEAD("05","死亡");
    private String num;
    private String type;
    LivestockType(String num,String type){
        this.num=num;
        this.type=type;
    }

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
