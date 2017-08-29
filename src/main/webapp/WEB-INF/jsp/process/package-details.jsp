<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>包装详情</title>
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
				<p class='top'><span>加工管理<em>></em></span><span class="qiDetail">包装详情</span></p>
				<div class='mainList'>
					<div class='divs'>
						<p class='conLeft' onclick="flush();">全部记录</p>
						<ul class="conRight">
							<li id="id1"></li>
							<li id="id2"></li>
							<li id="id3"></li>
							<li id="id5"></li>
						</ul>
					</div>
					<div class="tab">
						<table>
							<thead>
								<tr>
									<th>追溯二维码</th>
									<th>货品信息</th>
									<th>生产时间</th>
								</tr>
							</thead>
							<tbody id="cpackinglist" class="cpackinglist">

							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="js/jquery-1.8.0.min.js"></script>
	<script src="js/common.js"></script>
		<script type="text/javascript">
			var enterpriseName = "";
			var personnelName = "";
			var productName = "";
			var productParts = "";
			var productWeight = "";
            $(function(){
                init(1);
            });
            function flush(){
                location.reload();
            }
            function init(pageNo) {
                var params={};
                params.pageNo = 1;
                params.pageSize = 10;
                params.id = "${documentNumber}";
                $.ajax({
                    url:"${basePath}/package-details.json",
                    type:"post",
                    data:params,
                    success:function(json){

                        if(json.result.code==0){
                            var html = "";

                            for(var i=0;i<json.data.totalList.length;i++){

                                var item = json.data.totalList[i];
                                if(item.parentId!=null) {

                                    html += '<tr>';
                                    html += '<td>' + item.packingQrCode + '</td>';
                                    html += '<td>' + item.productParts + '</td>';
                                    html += '<td>' + item.createTime + '</td>';
                                    html += '</tr>';
                                }
                                if(item.parentId==null){
                                    enterpriseName = item.enterpriseName;
                                    personnelName = item.personnelName;
                                    productName = item.productName;
                                    productParts = item.productParts;
                                    productWeight = item.productWeight;
                                    $("#id1").html('<span >企业：'+enterpriseName+'</span>')
                                    $("#id2").html('<span >操作人员：'+personnelName+'</span>')
                                    $("#id3").html('<span >包装名称：'+productName+'</span>')
                                    $("#id5").html('<span >总重量：'+productWeight+'公斤</span>')
                                    $("#cpackinglist").html(html);
                                }
                            }

//                            topage(json.data);
                        }
                    }

                });
            }
		</script>
		<%@include file="../include/footer.jsp"%>

</body>
</html>