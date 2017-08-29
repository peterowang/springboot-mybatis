<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>排酸记录</title>
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
				<p class='top'><span>加工管理<em>></em></span><span class="qiDetail">排酸记录</span></p>
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
		<script>
		$(".looky").click(function(){
			$(".looks ,.mengban").show();
		})
		$(".lookSave").click(function(){
			$(".looks ,.mengban").hide();
		})
	</script>
	<script type="text/javascript">;
    var type = "";
    var createTime = "";
    function updateType(a){
        type = a;
    }
    function flush(){
        location.reload();
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
	   params.startTime = $("#input2").get(0).value;
	   params.endTime = $("#input3").get(0).value;
        $.ajax({
            url:"${basePath}/paisuan-record.json",
            type:"post",
            data:params,
            success:function(json){
                if(json.result.code==0){
                    var html = "<tbody>";
                    for(var i=0;i<json.data.totalList.length;i++){
                        var item = json.data.totalList[i];
                        html += '<tr><td>'+item.erCode+'</td><td>'+item.createTime+'</td><td>'+item.temperature+'</td><td>'+(item.humidity==null?"":item.humidity)+'</td><td><a href="${basePath}/enterprise-'+item.enterpriseId+'.html">'+item.enterpriseName+'</a></td><td><a href="${basePath}/person-'+item.personnelId+'.html">'+item.personnelName+'</a></td></tr>';
                    }
                    html = '<table><thead><tr><th>二维码</th><th>时间</th><th>温度℃</th><th>湿度%rh</th><th>企业</th><th>操作人员</th></tr></thead>' + html + '</tbody></table>';
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