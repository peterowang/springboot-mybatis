<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>授权管理</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/authorization.css">
    <link rel="shortcut icon" href="images/logo.png" type="image/x-icon"/>

    <script src="js/laydate/laydate.js"></script>

    <style>
        select {
            outline: none;
            width: 115px;
            height: 30px;
            border: 1px solid #E6E9ED;
            color: #73879C;
        }
    </style>
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
            <h3 class="title">企业列表</h3>
            <div class="enterprise">
                <ul>
                    <li>企业类型：
                        <select name="" id="type" class="select" >
                            <option value="0">全部</option>
                            <option value="5">超管</option>
                            <option value="1">养殖</option>
                            <option value="2">屠宰</option>
                            <option value="3">加工</option>
                            <option value="4">商户</option>
                        </select></li>
                    <li>企业名称：
                        <input id="name" maxlength="64" type="text">
                    </li>
                    <li>创建时间：<span><img src="images/calendar.png" alt=""><input type="text" class="txt" id="time" onclick="laydate()"></span></li>
                </ul>
                <span class="require" onclick="init(1)">查询</span>
                <a href="enterprise-create.html"><span class="new">新建企业</span></a>
            </div>
            <div class='centerlist' id="centerlist">

            </div>
            <!-- 翻页 -->
            <%@include file="../include/page.jsp"%>
        </div>
    </div>

</div>
<script src="js/jquery-1.8.0.min.js"></script>
<script src="js/common.js"></script>
<script type="text/javascript">
    var type = "";
    var createTime = "";
    function updateType(a){
        type = a;
    }
    $(function(){
       init(1);
    });
    function init(pageNo) {
        var params={};
        params.pageNo = pageNo;
        params.pageSize = pageSize;
        params.type = $("#type").val();
        params.createTime = $("#time").val();
        params.name = $("#name").val();
        $.ajax({
            url:"${basePath}/enterprise-list.json",
            type:"post",
            data:params,
            success:function(json){

                if(json.result.code==0){
                    var html = "";
                    for(var i=0;i<json.data.totalList.length;i++){
                        var item = json.data.totalList[i];
                        html += '<div class="centerlist">';
                        html += '<div class="mainRight-list">';
                        html += '<dl>';
                        html += '<dt><img src="'+item.logo+'" alt=""></dt>';
                        html += '<dd>';
                        html += '<h2><a href="/enterprise-'+item.id+'.html" >'+item.enterpriseName+'</a></h2>';
                        html += '<p class="address">通讯地址(';
                        if(item.province!=null&&item.province!=""){
                          html +=  item.province;
                            if(item.city!=null&&item.city!=""){
                                html +='、';
                                html +=  item.city;
                                if(item.district!=null&&item.district!=""){
                                    html +='、';
                                    html +=  item.district;
                                    if(item.township!=null&&item.township!=""){
                                        html +='、';
                                        html +=  item.township;
                                    }
                                    if(item.village!=null&&item.village!=""){
                                        html +='、';
                                        html +=  item.village;
                                    }
                                    if(item.streetAddresses!=null&&item.streetAddresses!=""){
                                        html +='、';
                                        html +=  item.streetAddresses;
                                    }
                                }
                            }
                        }else{
                            html +='无';

                        }


                        html +=')</p>';
                        html += '<p class="tu">';
                        if(item.enterpriseType==2){
                            html+='<em style="border: 1px solid orange;color: orange;">屠</em>';
                        }
                        if(item.enterpriseType==1){
                            html+='<em style="border: 1px solid green;color: green;">养</em>';
                        }
                        if(item.enterpriseType==3){
                            html+='<em style="border: 1px solid firebrick;color: firebrick;">加</em>';
                        }
                        if(item.enterpriseType==4){
                            html+='<em style="border: 1px solid blue;color: blue;">商</em>';
                        }
                        if(item.enterpriseType==5){
                            html+='<em style="border: 1px solid red;color: red;">超</em>';
                        }
                        if(item.isMuslim=='是'){
                            html+='<em style="border: 1px solid lightgreen;color: lightgreen;">清</em>';
                        }
                        html += '</p>';
                        html += '</dd>';
                        html += '</dl>';
                        html += '<a href="/enterprise-'+item.id+'.html" class="see">查看详情</a>';
                        html += '</div>';
                        html += '</div>';
                    }

                    $("#centerlist").html(html);
                    topage(json.data);
                }
            }

        });
    }

</script>
<%@include file="../include/footer.jsp"%>

</body>
</html>
