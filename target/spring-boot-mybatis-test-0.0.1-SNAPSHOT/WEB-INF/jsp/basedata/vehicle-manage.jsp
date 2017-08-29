<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>车辆信息管理</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/drug.css">
	<link rel="shortcut icon" href="images/logo.png" type="image/x-icon"/>
</head>
<body>
	<div class="mengban"></div>
	<!-- 添加弹框 -->
	<div class='trace'>
		<ul>
			<li><span>企业名称:</span><span id="enterpriseName" style="width: 200px;text-align: left;margin-left: 20px;"></span></li>
			<li><span>生产许可证号:</span><input type="text" placeholder='生产商生产许可证号' id="productionLicenseNumber"></li>
			<li><span>保质期:</span><input type="text" placeholder='产品保质期，如：24个月' id="shelfLife"></li>
			<li><span>执行标准:</span><input type="text" placeholder='执行标准号' id="executionStandard"></li>
			<li><span>电话:</span><input type="text" placeholder='生产商电话号码' id="phone"></li>
			<li><span>防伪码:</span><input type="text" placeholder='标签图层挂开后显示的防伪号' id="securityCode"></li>
			<li><span>生产商:</span><input type="text" placeholder='生产商名称' id="producers"></li>
			<li><span>网址:</span><input type="text" placeholder='生产商网址' id="url"></li>
			<li><span>产地:</span><input type="text" placeholder='产地' id="origin"></li>
			<li class='baocun deposit' >
				<p class='baocun' id="save" ><em>保存</em></p>
				<p class='baocun' onclick="hide()" style="margin-top: 10px;"><em>取消</em></p>
			</li>
		</ul>
	</div>
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
				<p class='top'><span>基础信息管理</span><em>></em><span class="qiDetail">车辆信息管理</span></p>
				<div class='mainList'>
					<div class='divs'>
						<p class='conLeft' onclick="location.reload()">全部信息</p>
						<ul class="conRight">
							<li><span>企业：</span><select name="" id="senterprise">
								<option value="0">不限</option>

								<c:forEach items="${list}" var="item">
									<option value="${item.id}">${item.enterpriseName}</option>

								</c:forEach>

							</select></li>
							<li><span>状态：</span><select name="" id="state">
								<option value="0">不限</option>
								<option value="1">已填</option>
								<option value="2">未填</option>

							</select></li>
							<li><em class="require" onclick="init(0)">查询</em></li>
						</ul>
					</div>
					<div class="tab">
						<table>
							<thead>
								<tr>
									<th>企业</th>
									<th>状态</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody id="centerlist" class="centerlist">

							</tbody>
						</table>
					</div>
					<!-- 翻页 -->
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
        function all() {
            $("#senterprise").val(0);
            $("#state").val(0);
            init(1);
        }
        function init(pageNo) {
            var params={};
            params.pageNo = pageNo;
            params.pageSize = pageSize;
            params.enterpriseId = $("#senterprise").val();
            params.type = $("#state").val();
            $.ajax({
                url:"${basePath}/vehicle-manage.json",
                type:"post",
                data:params,
                success:function(json){

                    if(json.result.code==0){
                        var html = "";
                        for(var i=0;i<json.data.totalList.length;i++){
                            var item = json.data.totalList[i];
                            html += '<tr>';
                            html += '<td>'+item.enterpriseName+'</td>';
                            html += '<td>'+item.type+'</td>';
                            html += '<td><a href="${basePath}/vehicle-info-'+item.enterpriseId+'.html">查看</a></td>';
                            html += '</tr>';
                        }

                        $("#centerlist").html(html);
                        topage(json.data);
                    }
                }

            });
        }


	</script>
	<script>
	    // 新增和修改
		$(".look").click(function(){
			$(".mengban ,.trace").show();
		})
		$(".baocun em").click(function(){
			$(".mengban ,.trace").hide();
		})
        function hide() {
            $(".mengban ,.trace").hide();
        }
	</script>
	<%@include file="../include/footer.jsp"%>

</body>
</html>