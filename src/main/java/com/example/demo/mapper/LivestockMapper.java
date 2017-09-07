package com.example.demo.mapper;

import com.example.demo.domain.LivestockModel;
import com.example.demo.mybatis.ApiBaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by BFD-593 on 2017/8/29.
 */
@Repository
public interface LivestockMapper extends ApiBaseMapper<LivestockModel>{
     /**
      * 分面查询
      * @param pageNo
      * @param pageSize
      * @return
      */
     List<LivestockModel> info(@Param("pageNo") Integer pageNo,@Param("pageSize") Integer pageSize);
     Integer count();
     /**
      * 条件查询
      */
     List<LivestockModel> findFilter(@Param("enterpriseId") Long enterpriseId,@Param("number")String number,
                                     @Param("state")String state,@Param("beginTime")String beginTime,
                                     @Param("endTime")String endTime);
}
