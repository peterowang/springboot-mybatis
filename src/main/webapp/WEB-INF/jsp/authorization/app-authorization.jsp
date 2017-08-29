<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>应用授权</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/device.css">
    <link rel="shortcut icon" href="images/logo.png" type="image/x-icon"/>
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
            <p class='top'><span>企业列表<em>></em></span><span class="qiDetail">新建企业</span></p>
            <div class="mainList">
                <ul class="indexList">
                    <li>
                        <img src="images/pic5.png" alt="" class="pic1">
                        <img src="images/pic6.png" alt="" class="pic2">
                        <img src="images/pic3.png" alt="" class="pic3">
                        <img src="images/pic4.png" alt="" class="pic4">
                    </li>
                </ul>
                <div class="applyName" style="display: block;">
                    <c:forEach items="${list}" var="item">
                        <dl class="applydl applydl2">
                            <dt>
                                <img src="images/user.png" alt="">
                            </dt>
                            <dd>
                                <h3>${item.name}</h3>
                                <p>${item.desc}</p>
                                <c:if test="${item.auth==1}">
                                    <span onclick="removeApp('${item.no}',this)">禁用</span>
                                </c:if>
                                <c:if test="${item.auth==0}">
                                    <span onclick="addApp('${item.no}',this)">启用</span>
                                </c:if>
                            </dd>
                        </dl>
                    </c:forEach>

                </div>
                <div class="next">
                    <a href="${basePath}/enterprise-create.html"><span>上一步</span></a>
                    <a href="javascript:;" onclick="create()"><span>保存并提交</span></a>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="js/jquery-1.8.0.min.js"></script>
<script src="js/common.js"></script>
<script type="text/javascript">
    var enterpriseId = '${enterpriseId}';
    var apps = new Array();
    $(function(){
        <c:forEach items="${list}" var="item">
            <c:if test="${item.auth==1}">
             apps.push('${item.no}');
            </c:if>
        </c:forEach>
    });
    function addApp(app,obj){
        var has = false;
        for(var i=0;i<apps.length;i++){
            if(apps[i]==app){
                has = true;
                return;
            }
        }
        apps.push(app);
        $(obj).attr("onclick",'removeApp("'+app+'",this)');
        $(obj).text("禁用");

    }
    function removeApp(app,obj){
        var b = new Array();
        for(var i=0;i<apps.length;i++){
            if(apps[i]==app){
               continue;
            }
            b.push(apps[i]);
        }
        apps = b;
        $(obj).attr("onclick",'addApp("'+app+'",this)');
        $(obj).text("启用");
    }
    function create() {
        var appString = "";
        for(var i=0;i<apps.length;i++){
            appString +=apps[i];
            if(i!=(apps.length-1)){
                appString +=",";
            }
        }
        var params={};
        params.enterpriseId = enterpriseId;
        params.appString = appString;

        $.ajax({
            url:"${basePath}/enterprise-app-auth.json",
            type:"post",
            data:params,
            success:function(json){
                if(json.result.code==0){
                    window.location.href="${basePath}/enterprise-import-${enterpriseId}.html";
                }else {
                    alert(json.result.msg);
                }
            }
        });
    }
</script>
<%@include file="../include/footer.jsp"%>
</body>
</html>