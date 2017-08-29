<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>检疫详情</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/commercial.css">
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
			<p class='top'><span class="qiDetail">检疫详情<em></em></span></p>
			<div class='mainList'>
				<div class="listCon">
					<ul class='indexList'>
						<li><span>企业名：</span><p>${info.enterpriseName}</p></li>
						<li><span>检疫项目：</span><p>${info.quarantineType}</p></li>
						<li><span>检疫时间：</span><p>${info.createTime}</p></li>
						<li><span>检疫单据编号：</span><p>${info.documentNumber}</p></li>
						<li><span>检疫地点：</span><p>${info.quarantineAddress}</p></li>
						<li><span>检疫结果：</span><p>${info.quarantineResult}</p></li>
						<li><span>检疫人员：</span><p>${info.personName}</p></li>
						<li><span>检疫证照：</span><img src="${info.quarantinePicture}" alt="" width="200px" ><p></p></li>
					</ul>

				</div>
				<div class="wylist">
					<p class="wtitle">牲畜信息</p>
					<div class="tab" id="centerlist">
						<table>
							<thead>
							<tr><th>耳标编号</th><th>检疫结果</th><th>不合格原因</th></tr>
							</thead>
							<tbody>
							<c:forEach items="${list}" var="item">
							<tr>
								<td><a href="${basePath}/livestock-${item.livestockId}.html">${item.equipmentNumber}</a></td>
								<td>${item.quarantineResult}</td>
								<td>${item.unqualifiedReason}</td>
								<td></td>
							</tr>
							</c:forEach>

							</tbody></table></div>
				</div>

			</div>
		</div>
	</div>
</div>
<script src="js/jquery-1.8.0.min.js"></script>
<script src="js/common.js"></script>
<%@include file="../include/footer.jsp"%>
</body>

</html>