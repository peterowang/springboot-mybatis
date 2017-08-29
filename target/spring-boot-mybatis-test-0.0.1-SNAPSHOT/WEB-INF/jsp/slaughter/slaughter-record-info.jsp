<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>屠宰记录详情</title>
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
				<p class='top'><span>屠宰管理<em>></em></span><span class="qiDetail">屠宰记录详情</span></p>
				<div class='mainList'>
					<div class='divs'>
						<ul class="conRight">
							<shiro:hasRole name="admin">

							<li><span>单据编号：</span>${info.documentNumber}</li>
							<li><span>屠宰时间：</span><fmt:formatDate value="${info.slaughterTime}" pattern="yyyy-MM-dd"/></li>
							<li><span>企业：</span>${info.enterpriseName}</li>
							</shiro:hasRole>
							<li><span>操作人员：</span>${info.slaughterPersonnelName}</li>
						</ul>
					</div>
					<div class="tab" id="centerlist">
						<table>
							<thead>
								<th>耳标编号</th>
								<th>追溯二维码</th>
								<th>是否排酸</th>
								<th width="300px">分割部位</th>
								<th>重量</th>
								<th>阿訇信息</th>
							</thead>
							<tbody>
								<c:forEach var="item" items="${list}">
									<tr>
										<td><a href="${basePath}/livestock-${item.livestockId}.html">${item.equipmentNumber}</a></td>
										<td>${item.erCode}</td>
										<td>${item.isAcidDischarge}</td>
										<td>${item.segName}</td>
										<td>${item.carcassWeight}公斤</td>
										<td><a href="${basePath}/person-${item.slaughterPersonnelId}.html">${item.slaughterPersonnelName}</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					 <%--<%@include file="../include/page.jsp"%>--%>
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
	<%@include file="../include/footer.jsp"%>

</body>
</html>