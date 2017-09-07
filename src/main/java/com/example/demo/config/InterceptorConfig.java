package com.example.demo.config;

import com.example.demo.authFilter.AuthInterceptor;
import org.aopalliance.intercept.Interceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * Created by BFD-593 on 2017/8/31.
 */
@Component
public class InterceptorConfig extends WebMvcConfigurerAdapter {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 多个拦截器组成一个拦截器链
        // addPathPatterns 用于添加拦截规则
        // excludePathPatterns 用户排除拦截
        InterceptorRegistration interceptorRegistration = registry.addInterceptor(new AuthInterceptor());
        interceptorRegistration.addPathPatterns("/*");
        interceptorRegistration.excludePathPatterns("/livestock");
        super.addInterceptors(registry);
    }
}
