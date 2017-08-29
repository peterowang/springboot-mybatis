<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>分割打印记录</title>
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
				<p class='top'><span><span>加工管理<em>></em></span><span class="qiDetail">分割打印记录</span></p>
				<div class='mainList'>
					<div class='divs'>
						<p class='conLeft' onclick="flush();">全部记录</p>
						<ul class="conRight">
							<shiro:hasRole name="admin">

							<li><span>企业：</span><select name="" id="select1">
							<option value="">不限</option>
								<c:forEach items="${list }" var="item">
								<option value="${ item.id }">${ item.enterpriseName }</option>
							</c:forEach>
							</select></li>
							</shiro:hasRole>
							<li><span>追溯二维码：</span><input type="text" id="input1"></li>
							<li><span>耳标编码：</span><input type="text" id="input4"></li>
							<li><span>时间：</span><input type="text" placeholder='请选择' id="input2" onclick="laydate()"><em>至</em><input type="text" placeholder='请选择' id="input3" onclick="laydate()"></li>
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
	<script type="text/javascript">;
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
        params.enterpriseId = $("#select1").val();
        </shiro:hasRole>
        <shiro:lacksRole name="admin">
        params.enterpriseId = '${enterpriseId}';
        </shiro:lacksRole>
	   params.erCode = $("#input1").get(0).value;
	   params.startTime = $("#input2").get(0).value;
	   params.endTime = $("#input3").get(0).value;
	   params.number = $("#input4").get(0).value;
        $.ajax({
            url:"${basePath}/splitprint-record.json",
            type:"post",
            data:params,
            success:function(json){
                if(json.result.code==0){
                    var html = "<tbody>";
                    for(var i=0;i<json.data.totalList.length;i++){
                        var item = json.data.totalList[i];
                        html += '<tr><td>'+item.code+'</td><td><a href="${basePath}/livestock-'+item.livestockId+'.html">'+item.equNumber+'</a></td><td>'+item.processingTime+'</td><td>'+item.productParts+'</td><td>'+item.weight+'</td><td><a href="${basePath}/enterprise-'+item.enterpriseId+'.html">'+item.enterpriseName+'</a></td><td><a href="${basePath}/person-'+item.processingPersonnelId+'.html">'+item.processingPersonnelName+'</a></td></tr>';
                    }
                    html = '<table><thead><tr><th>追溯二维码</th><th>耳标编码</th><th>时间</th><th>分割部位</th><th>重量</th><th>企业</th><th>操作人员</th></tr></thead>' + html + '</tbody></table>';
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