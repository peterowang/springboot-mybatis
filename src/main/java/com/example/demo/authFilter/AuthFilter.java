package com.example.demo.authFilter;

import com.alibaba.fastjson.JSONObject;
import com.example.demo.util.ResultPageInfoJsonUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by BFD-593 on 2017/8/31.
 */
@Component
public class AuthFilter implements Filter {
    private static final Log log = LogFactory.getLog(AuthFilter.class);
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        log.info("AuthFilter init OK...");
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        log.info("AuthFilter dofilter loading...");
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        request.setCharacterEncoding("UTF-8");
        //1.获取用户登录信息,没有登录 去登录页面request.getRequestDispatcher("/login").forward(request, response);
        //2.获取用户访问资源，如果是登录和springlogo的请求,则放行
        String requestURI = request.getRequestURI();
        if(requestURI.equals("/login")||requestURI.equals("/favicon.ico")){
            log.info("this is a login request or spring.logo,not filter");
            setCrosHeader(response);
            filterChain.doFilter(request, response);
            return;
        }
        log.info("user request uri is "+requestURI);

        //3.获取该uri所需的权限,如果该url不需要权限，则过滤结束
        String auth = null;
        if(StringUtils.isEmpty(auth)){
            log.info("url auth is null");
            setCrosHeader(response);
            filterChain.doFilter(request, response);
            return;
        }
        //4.判断该用户是否拥有权限,如果没有
        //request.setAttribute("message", "对不起，您没有权限，请联系管理员！！！");
        //request.getRequestDispatcher("/message").forward(request, response);
        //return;
        //或使用:
        //returnNone(response,"000000", "没有访问权限或请求失败");
        //5.如果有权限，则放行
        //filterChain.doFilter(request, response);
    }
    @Override
    public void destroy() {
        log.info("AuthFilter destory Ok...");
    }




    //设置响应头放行的
    private void setCrosHeader(HttpServletResponse response){
        response.setHeader("Access-Control-Allow-Credentials", "true");
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods",
                "POST, GET, OPTIONS, DELETE");
        response.setHeader("Access-Control-Max-Age", "3600");
        response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
        response.setCharacterEncoding("utf-8");
    }
    //设置过滤后的响应头
    private void returnNone(HttpServletResponse response, String code,
                            String msg) throws IOException {

        setCrosHeader(response);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        PrintWriter writer = response.getWriter();
        writer.write(JSONObject.toJSONString(ResultPageInfoJsonUtils.getFailedJson(code,msg)));
        writer.flush();
        writer.close();
        return;
    }
}
