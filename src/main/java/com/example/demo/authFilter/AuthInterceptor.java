package com.example.demo.authFilter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Enumeration;

/**
 * Created by BFD-593 on 2017/8/31.
 */
public class AuthInterceptor extends HandlerInterceptorAdapter {
    private static final Log log = LogFactory.getLog(AuthInterceptor.class);
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        log.info("ip:" + request.getRemoteAddr());
        log.info("url:" + request.getRequestURL());
        log.info("servletpath:" + request.getServletPath());
        log.info("scheme:" + request.getScheme());
        log.info("protocol:" + request.getProtocol());
        if (request.getParameterMap().containsKey("hello")) {
            return true;
        }
        return false;
    }
}
