<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>活畜履历详情</title>
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
			<p class='top'><span class="qiDetail">活畜履历<em></em></span></p>
			<div class='mainList'>
				<div class="listCon">
					<ul class='indexList'>
						<li><span>耳标号：</span><p>${info.equipmentNumber}</p></li>
						<li><span>品种：</span><p>${info.varietiesType}</p></li>
						<li><span>母体耳标：</span><p>${info.parentEquipmentId}</p></li>
						<li><span>性别：</span><p>${info.sex}</p></li>
						<li><span>受孕：</span><p>${info.isPregnancy}</p></li>
						<li><span>入栏重量：</span><p>${info.lairageWeight}kg</p></li>
						<li><span>入栏时间：</span><p>${info.lairageTime}</p></li>
						<li><span>出生重量：</span><p>${info.initialWeight}kg</p></li>
						<li><span>出生时间：</span><p>${info.initialTime}</p></li>
						<li><span>出生地：</span><p>${info.birthplace}</p></li>
						<li><span>牧场主：</span><p>${info.principalName}</p></li>
					</ul>
					<div class="charts">
						<img src="${info.picture}" alt="" >
					</div>

				</div>
				<div class="wylist">
					<span style="background: #26B99A;
							height: 35px;
							line-height: 35px;
							font-size: 14px;
							display: block;
							text-align: center;
							color: #fff;
							margin-left: 300px;
							margin-top: 30px;
							width: 230px;
							cursor: pointer;
							" onclick="history.back()">返回</span>
				</div>
				<%--<div class="wylist">--%>
					<%--<p class="wtitle">喂养饲料</p>--%>
					<%--<ul>--%>
						<%--<c:forEach items="${flist}" var="item">--%>
							<%--<li><span>饲料1、</span><span>${item.grass}</span></li>--%>
						<%--</c:forEach>--%>
					<%--</ul>--%>
				<%--</div>--%>
				<%--<div class="tab">--%>
					<%--<p class="wtitle">称重记录</p>--%>
					<%--<table>--%>
						<%--<thead>--%>
						<%--<tr>--%>
							<%--<th>称重时间</th>--%>
							<%--<th>重量</th>--%>
							<%--<th>称重人员</th>--%>
						<%--</tr>--%>
						<%--</thead>--%>
						<%--<tbody>--%>
						<%--<c:forEach items="${wlist}" var="item">--%>
							<%--<tr>--%>
								<%--<td><fmt:formatDate value="${item.weighTime}" pattern="yyyy-MM-dd" /></td>--%>
								<%--<td>${item.weight}公斤</td>--%>
								<%--<td>${item.weighName}</td>--%>
							<%--</tr>--%>
						<%--</c:forEach>--%>

						<%--</tbody>--%>
					<%--</table>--%>
				<%--</div>--%>
			</div>
		</div>
	</div>
</div>
<script src="js/jquery-1.8.0.min.js"></script>
<script src="js/common.js"></script>
<%@include file="../include/footer.jsp"%>
</body>


</html>