package com.example.demo.service;

import com.example.demo.domain.LivestockModel;
import com.example.demo.mapper.LivestockMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by BFD-593 on 2017/8/29.
 */
@Service
public class LivestockService {
    @Autowired
    LivestockMapper livestockMapper;

    public List<LivestockModel> listInfo(Integer pageNo,Integer pageSize){
        return livestockMapper.info(pageNo,pageSize);
    }
    public Integer count(){
        return livestockMapper.count();
    }
}
