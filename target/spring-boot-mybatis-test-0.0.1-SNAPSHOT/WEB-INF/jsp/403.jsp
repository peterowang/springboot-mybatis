<%@ page language="java" pageEncoding="UTF-8"%>
<%
    response.setContentType("application/json;charset=utf-8");
    out.print("{\"result\":{\"code\":1,\"msg\":\"用户没有权限\"}}");
%>