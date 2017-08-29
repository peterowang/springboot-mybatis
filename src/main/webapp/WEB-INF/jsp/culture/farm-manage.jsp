<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>养殖管理</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/cultivation.css">
	<link rel="shortcut icon" href="images/logo.png" type="image/x-icon"/>
</head>
<body>
	<div class="mengban"></div>
	<!-- 添加弹框 -->

	<!-- 退出 -->
	<%@include file="../include/header.jsp"%>
	<div class="wrap">
		<!-- 头部 -->
		<%@include file="../include/nav.jsp"%>
		<!-- 内容 -->
		<div class="maincon">
			<!-- 左侧 -->
			<%@include file="../include/left.jsp"%>
			<!-- 右侧 -->
			<div class="mainRight">
				<p class='top'><span>养殖管理<em>></em></span><span class="qiDetail">养殖管理</span></p>
				<div class='mainList'>
					<div class='divs'>
						<p class='conLeft' onclick="flush();">全部履历</p>
						<ul class="conRight">
							<shiro:hasRole name="admin">
							<li><span>企业：</span>
							<select name="enterpriseId" id="option1List">
								<option value="">不限</option>
								<c:forEach items="${list }" var="item">
									<option value="${item.id}">${item.enterpriseName }</option>
								</c:forEach>
							</select>
							</li>
							</shiro:hasRole>
							<li><span>耳标编号：</span><input id="tagnum" type="text" placeholder='不限'></li>
							<li><span>状态：</span><select name="state" id="option2List">
							<option value="">不限</option>
							<option value="00">饲养</option>
							<option value="01">屠宰</option>
							<option value="02">检疫不通过</option>
							<option value="03">线上销售</option>
							<option value="04">线下销售</option>
							<option value="05">死亡</option>
							</select></li>
							<li><span>入栏时间：</span><input type="text" placeholder='请选择' id="startTime" onclick="laydate()"></input><em>至</em><input type="text" placeholder='请选择' id="endTime" onclick="laydate()"></li>
							<li><em class="require" onclick="init(1);">查询</em></li>
						</ul>
					</div>
					<div class="tab" id="centerlist">
					</div>
					<%@include file="../include/page.jsp"%>
				</div>
			</div>
		</div>
	</div>
	<script src="js/jquery-1.8.0.min.js"></script>
	<script src="js/common.js"></script>
	<script src="js/laydate/laydate.js"></script>
	<script type="text/javascript">
    var type = "";
    var createTime = "";
    var enterpriseId = "";
    var number = "";
    var state = "";
    var startTime = "";
    var endTime = "";
    function flush(){
        location.reload();
    }
    function updateType(a){
        type = a;
    }
    function baseData(b){
    	var sex="公";
    	if(b==0){
    		sex="母";
    	}
    	return sex;
    }

    $(function(){
       init(1,1);
    });
    function init(pageNo,flag) {
        var params={};
        params.pageNo = pageNo;
        params.pageSize = pageSize;
	   params.type = type;
	   params.createTime = createTime;
        <shiro:hasRole name="admin">
        params.enterpriseId = $("#option1List").get(0).value;
        </shiro:hasRole>
        <shiro:lacksRole name="admin">
        params.enterpriseId = '${enterpriseId}';
        </shiro:lacksRole>
	   params.number = $("#tagnum").get(0).value;
	   params.state = $("#option2List").get(0).value;
	   params.startTime = $("#startTime").get(0).value;
	   params.endTime = $("#endTime").get(0).value;
        $.ajax({
            url:"${basePath}/farm-manage.json",
            type:"post",
            data:params,
            success:function(json){
                if(json.result.code==0){
                    var html = "<tbody>";
                    for(var i=0;i<json.data.totalList.length;i++){
                        var item = json.data.totalList[i];
//                        var sex = baseData(item.sex);
                        html += '<tr><td><a href="${basePath}/livestock-'+item.id+'.html">'+item.equiNumber+'</td><td>'+item.typeName+'</td><td>'+item.sex+'</td><td>'+item.lairageTime+'</td><td><a href="${basePath}/enterprise-'+item.enterpriseId+'.html">'+item.enterpriseName+'</td><td>'+item.state+'</td></tr>';
                    }
                    html = '<table><thead><tr><th>耳标编号</th><th>品种</th><th>性别</th><th>入栏时间</th><th>企业(牧场主)</th><th>状态</th></tr></thead>' + html + '</tbody></table>';
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