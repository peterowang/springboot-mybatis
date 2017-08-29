<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>屠宰记录</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/cultivation.css">
	<link rel="shortcut icon" href="images/logo.png" type="image/x-icon"/>
</head>
<body>
	<div class="mengban"></div>
		<!-- 退出 -->
<%@include file="../include/header.jsp"%>
	<!-- 查看 -->
	<div class="looks">
		<p><img src="images/pica.png" alt=""></p>
		<span class="lookSave">保存</span>
	</div>

<div class="wrap">
    <!-- 头部 -->
    <%@include file="../include/nav.jsp"%>
		<!-- 内容 -->
		<div class="maincon">
			<!-- 左侧 -->
			  <%@include file="../include/left.jsp"%>
			<!-- 右侧 -->
			<div class="mainRight">
				<p class='top'><span>屠宰管理<em>></em></span><span class="qiDetail">屠宰记录</span></p>
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
							<li><span>耳标编号：</span><input type="text" id="input1"></li>
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
	<script type="text/javascript">;;
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
    function init(pageNo) {
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

	   params.number = $("#input1").get(0).value;
	   params.startTime = $("#input2").get(0).value;
	   params.endTime = $("#input3").get(0).value;
        $.ajax({
            url:"${basePath}/slaughter-record.json",
            type:"post",
            data:params,
            success:function(json){
                if(json.result.code==0){
                    var html = "<tbody>";
                    for(var i=0;i<json.data.totalList.length;i++){
                        var item = json.data.totalList[i];
                        html += '<tr><td>'+item.equipmentNumber+'</a></td><td>'+item.erCode+'</td><td>'+item.processTime+'</td><td><a href="${basePath}/person-'+item.slaughterPersonnelId+'.html">'+item.slaughterPersonnelName+'</a></td><td>'+item.quarantinePersonnelName+'</td><td><a href="${basePath}/enterprise-'+item.enterpriseId+'.html">'+item.enterpriseName+'</a></td><td>'+item.quarantineResult+'</td></tr>';
                    }
                    html = '<table><thead><tr><th>耳标编号</th><th>二维码编号</th><th>时间</th><th>屠宰人员</th><th>检疫人员</th><th width="300px">屠宰企业</th><th>检疫结果</th></thead>' + html + '</tbody></table>';
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