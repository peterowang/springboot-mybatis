<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>企业数据详情</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/cultivation.css">
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
			<!-- 右侧 -->
			<div class="mainRight">
				<p class='top'><span>养殖管理<em>></em></span><span class="qiDetail">养殖环境监测</span></p>
				<div class='mainList'>
					<div class='divs'>
						<p class='conLeft' onclick="flush();">全部记录</p>
						<ul class="conRight">
							<shiro:hasRole name="admin">
							<li><span>企业：</span><select name="" id="select1">
							<option value="">不限</option>
							<c:forEach items="${list }" var="item">
								<option value="${item.id }">${item.enterpriseName }</option>
							</c:forEach>
							</select></li>
							</shiro:hasRole>
							<li><span>记录人员：</span><select name="" id="select2">
							<option value="">不限</option>
							<c:forEach items="${personnelList }" var="item">
								<option value="${item.id }">${item.name }</option>
							</c:forEach>
							</select></li>
							<li><span>时间：</span><input type="text" placeholder='请选择' id="input1" onclick="laydate()"><em>至</em><input type="text" placeholder='请选择' id="input2" onclick="laydate()"></li>
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
    function flush(){
        location.reload();
    }
    function updateType(a){
        type = a;
    }
    $(function(){
       init(1);
    });
    function init(pageNo,flag) {
        var params={};
        params.pageNo = pageNo;
        params.pageSize = pageSize;
		params.type = type;
		params.createTime = createTime;
        <shiro:hasRole name="admin">
        params.enterpriseId = $("#select1").get(0).value;
        </shiro:hasRole>
        <shiro:lacksRole name="admin">
        params.enterpriseId = '${enterpriseId}';
        </shiro:lacksRole>
		params.personnelId = $("#select2").get(0).value;
		params.startTime = $("#input1").get(0).value;
		params.endTime = $("#input2").get(0).value;

        $.ajax({
            url:"${basePath}/environmentmonitoring-list.json",
            type:"post",
            data:params,
            success:function(json){
                if(json.result.code==0){
                    var html = "<tbody>";
                    for(var i=0;i<json.data.totalList.length;i++){
                        var item = json.data.totalList[i];
                        html += '<tr><td><a href="${basePath}/enterprise-'+item.enterpriseId+'.html">'+item.enterpriseName+'</td><td>'+item.ch4+'%</td><td>'+item.nh3+'%</td><td>'+item.h2s+'%</td><td>'+item.so2+'%</td><td>'+item.humidity+'%rh</td><td>'+item.temperature+'℃</td><td>'+item.beam+' lx</td><td>'+item.updateTime+'</td></tr>';
                    }
                    html = '<table><thead><tr><th>企业名称</th><th>甲烷浓度LEL</th><th>NH3浓度ppm</th><th>H2S浓度ppm</th><th>SO2浓度ppm</th><th>湿度RH</th><th>温度℃</th><th>光照Lux</th><th>更新时间</th></tr></thead>' + html + '</tbody></table>';
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