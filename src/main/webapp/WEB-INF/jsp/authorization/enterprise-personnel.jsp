<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>企业人员详情</title>
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
				<p class='top'><span>企业列表<em>></em></span><span >企业详情</span><em>></em></span><span class="qiDetail">人员详情</span></p>
				<div class="mainList">
					<ul class="indexList">
						<li><span><em>*</em>姓名：</span>${info.name}</li>
						<li><span><em>*</em>性别：</span>
							${info.sex}
						</li>
						<li><span><em>*</em>民族：</span>
							${info.national}
						</li>
						<li><span><em>*</em>出生年月日：</span>
							<fmt:formatDate value="${info.dateOfBirth}" pattern="yyyy-MM-dd"/>
						</li>
						<li><span>企业名称：</span>${enterpriseName}</li>
						<li><span>职位：</span>
							<c:if test="${info.position eq '1'}">管理人员</c:if>
							<c:if test="${info.position eq '2'}">普通人员</c:if>
							<c:if test="${info.position eq '3'}">屠宰人员</c:if>
							<c:if test="${info.position eq '4'}">检疫人员</c:if>
						</li>
						<li><span>婚姻状况：</span>
							<c:if test="${info.maritalStatus eq '1'}">未婚</c:if>
							<c:if test="${info.maritalStatus eq '2'}">已婚</c:if>
						</li>
						<li><span>联系电话：</span>${info.phoneNumber}</li>

						<li><span>证件号码：</span>${info.documentNumber}</li>
						<li><span><em>*</em>地址：</span>
							<p>
								${addr.province}
								<c:if test="${not empty addr.city}">/${addr.city}</c:if>
								<c:if test="${not empty addr.district}">/${addr.district}</c:if>
								<c:if test="${not empty addr.township}">/${addr.township}</c:if>
								<c:if test="${not empty addr.village}">/${addr.village}</c:if>
								<c:if test="${not empty addr.streetAddresses}">/${addr.streetAddresses}</c:if>
							</p>
						</li>
						<li>
							<a href="javascript:;" onclick="window.history.back()"><span class="save">返回</span></a>
						</li>
					</ul>
				</div>
				
				<!-- <div class="save">
					<span>保存</span>
				</div> -->
			</div>
		</div>
	</div>
   <script src="js/jquery-1.8.0.min.js"></script>
   <script src="js/common.js"></script>
   <script>
   		$(".selt").change(function(){
   			var val = $(this).val();
   			if(val == 1){
   				$(".uptype").hide();
   			}else{
   				$(".uptype").show();
   			}
   		})
   </script>
	<%@include file="../include/footer.jsp"%>

</body>
</html>