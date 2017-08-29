<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>企业消毒记录</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/cultivation.css">
	<link rel="shortcut icon" href="images/logo.png" type="image/x-icon"/>
	<script src="js/laydate/laydate.js"></script>
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
				<p class='top'><span class="qiDetail">企业消毒记录</span></p>
				<div class='mainList'>
					<div class='divs'>
						<p class='conLeft' onclick="flush();">全部记录</p>
						<ul class="conRight">
							<shiro:hasRole name="admin">
							<li><span>企业：</span><select name="" id="select1">
								<option value="">不限</option>
								<c:forEach items="${list}" var="item">
									<option value="${item.id}">${item.enterpriseName}</option>

								</c:forEach>
							</select></li>
							</shiro:hasRole>
							<li><span>时间：</span><input type="text" placeholder='请选择' id="input1" onclick="laydate()"><em>至</em><input type="text" placeholder='请选择' id="input2" onclick="laydate()"></li>
							<li><span>消毒方法：</span>
								<select name="" id="select2">
									<option value="">不限</option>
									<option value="熏蒸">熏蒸</option>
									<option value="喷洒">喷洒</option>
									<option value="浸泡">浸泡</option>
								</select>
							</li>
							<li><em class="require" onclick="init(1);">查询</em></li>
						</ul>
					</div>
					<div class="tab">
						<table>
							<thead>
								<tr>
									<th>单据编号</th>
									<th>时间</th>
									<th>消毒名称</th>
									<th>消毒方法</th>
									<th>消毒企业</th>
									<th>消毒人员</th>
								</tr>
							</thead>
							<tbody id="cdisinfectionlist" class="cdisinfectionlist">

							</tbody>
						</table>
					</div>
					  <%@include file="../include/page.jsp"%>
				</div>
			</div>
		</div>
	</div>
	<script src="js/jquery-1.8.0.min.js"></script>
	<script src="js/common.js"></script>
	<script type="text/javascript">
        $(function(){
            init(1);
        });
        function flush(){
            location.reload();
        }
        function init(pageNo) {
            var params={};
            params.pageNo = pageNo;
            params.pageSize = pageSize;
            <shiro:hasRole name="admin">
            params.enterpriseId = $("#select1").val();
            </shiro:hasRole>
            <shiro:lacksRole name="admin">
            params.enterpriseId = '${enterpriseId}';
            </shiro:lacksRole>
            params.method = $("#select2").get(0).value;
            params.startTime = $("#input1").get(0).value;
            params.endTime = $("#input2").get(0).value;
            $.ajax({
                url:"${basePath}/enterprise-disinfection.json",
                type:"post",
                data:params,
                success:function(json){

                    if(json.result.code==0){
                        var html = "";
                        for(var i=0;i<json.data.totalList.length;i++){
                            var item = json.data.totalList[i];
                            html += '<tr>';
                            html += '<td>'+item.documentNumber+'</td>';
                            html += '<td>'+item.disinfectionTime+'</td>';
                            html += '<td>'+item.disinfectantName+'</td>';
                            html += '<td>'+item.disinfectionMethod+'</td>';
                            html += '<td><a href="${basePath}/enterprise-'+item.enterpriseId+'.html">'+item.enterpriseName+'</a></td>';
                            html += '<td><a href="${basePath}/person-'+item.personnelId+'.html">'+item.disinfectionPersonnelName+'</a></td>';
                            html += '</tr>';
                        }

                        $("#cdisinfectionlist").html(html);
                        topage(json.data);
                    }
                }

            });
        }
	</script>
	<%@include file="../include/footer.jsp"%>

</body>
</html>