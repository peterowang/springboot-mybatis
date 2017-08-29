<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>新建企业</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/commercial.css">
    <link rel="shortcut icon" href="images/logo.png" type="image/x-icon"/>
    <script src="js/jquery-1.8.0.min.js"></script>
    <script src="js/common.js"></script>
    <script src="js/jquery.ui.widget.js"></script>
    <script src="js/jquery.fileupload.js"></script>

</head>
<body>
<div class="mengban"></div>
<!-- 退出 -->
<%@include file="../include/header.jsp"%>

<div class="wrap">
    <!-- 头部 -->
    <%@include file="../include/nav.jsp"%>
    <!-- 内容 -->
    <div class="maincon">
        <!-- 左侧 -->
        <%@include file="../include/left.jsp"%>
        <div class="mainRight">
            <p class='top'><span>企业名称<em>></em></span><span class="qiDetail">新建企业</span></p>
            <div class="mainList">
                <ol class="firm">
                    <li class="bg">商户企业表单</li>
                    <li>屠宰企业表单</li>
                    <li>养殖企业表单</li>
                </ol>
                <div class="indexcon">
                    <%@include file="include/create-shanghu.jsp"%>
                    <%@include file="include/create-tuzai.jsp"%>
                    <%@include file="include/create-yangzhi.jsp"%>
                </div>

            </div>

        </div>
    </div>
</div>

<script>
    $(".firm li").click(function(){
        $(this).addClass("bg").siblings(".bg").removeClass("bg")
        var index =$(this).index();
        $(".indexcon ul").eq(index).show().siblings("ul").hide();
    })
</script>
<%@include file="../include/footer.jsp"%>

</body>
</html>