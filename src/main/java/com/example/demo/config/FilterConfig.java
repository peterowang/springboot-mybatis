package com.example.demo.config;

import com.example.demo.authFilter.AuthFilter;
import com.google.common.collect.Lists;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Arrays;
import java.util.List;

/**
 * Created by BFD-593 on 2017/8/31.
 */
@Configuration
public class FilterConfig{
    @Bean
    public FilterRegistrationBean filterRegistrationBean(AuthFilter authFilter){
        FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
        filterRegistrationBean.setFilter(authFilter);
        List<String> auths = Lists.newArrayList();
        auths.add("/*");
        filterRegistrationBean.setUrlPatterns(auths);
        return filterRegistrationBean;
    }
}
