package com.example.demo.mybatis;

import org.springframework.context.annotation.Bean;


import org.springframework.context.annotation.Configuration;

import tk.mybatis.spring.mapper.MapperScannerConfigurer;

import java.util.Properties;

/**
 * MyBatis鎵弿鎺ュ彛锛屼娇鐢ㄧ殑tk.mybatis.spring.mapper.MapperScannerConfigurer
 */
@Configuration
public class MyBatisMapperScannerConfig {

    @Bean
    public MapperScannerConfigurer mapperScannerConfigurer() {
        MapperScannerConfigurer mapperScannerConfigurer = new MapperScannerConfigurer();
        mapperScannerConfigurer.setSqlSessionFactoryBeanName("sqlSessionFactory");
        mapperScannerConfigurer.setBasePackage("com.example.demo.mapper");
        Properties properties = new Properties();
        properties.setProperty("mappers", "com.example.demo.mybatis.ApiBaseMapper");
        properties.setProperty("notEmpty", "false");
        properties.setProperty("IDENTITY", "MYSQL");
        mapperScannerConfigurer.setProperties(properties);
        return mapperScannerConfigurer;
    }

}
