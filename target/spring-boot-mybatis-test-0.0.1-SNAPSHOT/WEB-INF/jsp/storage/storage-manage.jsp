<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>库存管理</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="shortcut icon" href="images/logo.png" type="image/x-icon"/>
	<link rel="stylesheet" href="css/ku.css">
</head>
<body>
	<div class="mengban"></div>
	<div class="repes">
		<p class="addtitle">添加产品</p>
		<ul class="addlist addlist2">
			<li>
				<span>产品：</span>
				<input id="add-product" type="text">
			</li>
			<li>
				<span>数量：</span>
				<input id="add-num" type="text">
			</li>
		</ul>
		<div class="addbtn">
			<span>取消</span>
			<span class="save">保存</span>
		</div>
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
				<p class='top'><span class="qiDetail">库存管理</span></p>
				<div class='mainList'>
					<div class='kus'>
						<ul class="conhed">
							<li class='conLeft' onclick="location.reload()">全部信息</li>
							<shiro:hasRole name="admin">
							<li><span>企业：</span><select name="" id="select1">
								<option value="">不限</option>

								<c:forEach items="${list}" var="item">
									<option value="${item.id}">${item.enterpriseName}</option>

								</c:forEach>

							</select></li>
							</shiro:hasRole>
							<li><span> 产品名称：</span></li>
							<li><input id="productName" type="text" placeholder="为空则返回全部"></li>
							<li><em id="search">查询</em></li>
							<li><em class="require">新增</em></li>
						</ul>
					</div>
					<div class="tab">
						<table>
							<thead>
								<tr>
									<th>企业名称</th>
									<th>产品名称</th>
									<th>数量</th>
									<th>详情</th>	
								</tr>
							</thead>
							<tbody id="tbody">

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
        var productName = "";
        $(function(){
            init(1);
        });
        function init(pageNo) {
            var params = {};
            params.pageNo = pageNo;
            params.pageSize = pageSize;
            params.productName = productName;
			<shiro:hasRole name="admin">
            params.enterpriseId = $("#select1").val();
			</shiro:hasRole>
			<shiro:lacksRole name="admin">
            params.enterpriseId = '${enterpriseId}';
			</shiro:lacksRole>

            $.ajax({
                url: "${basePath}/product-list.json",
                type: "post",
                data: params,
                success: function (json) {

                    if (json.result.code == 0) {
                        var html = "";
                        for (var i = 0; i < json.data.totalList.length; i++) {
                            var item = json.data.totalList[i];
                            html += '<tr>';
                            html += '<td>'+item.text1+'</td>';
                            html += '<td>'+item.name+'</td>';
                            html += '<td>'+item.number+'</td>';
                            html += '<td>';
                            html += '<a  id="aaa" onclick="revise(this)" class="revise">修改</a>';
                            html += '<span onclick="remove(this)" class="remove">删除</span>';
                            html += '</td>';
                            html += '</tr>';
                        }
                        $("#tbody").html(html);
                        topage(json.data);
                    }
                }

            });
        }

        function revise(obj) {
            var pName = obj.parentNode.parentNode.firstChild.innerHTML;
            document.getElementById("add-product").value = pName;
            document.getElementById("add-num").value = "";
            $(".repes,.mengban").show();
        }

        function remove(obj) {
            var pName=obj.parentNode.parentNode.firstChild.innerHTML;
            var params = {};
            params.name = pName;
            $.ajax({
                url: "${basePath}/remove-product.json",
                type: "post",
                data: params,
                success: function (json) {
                    init(1);
                }
            });
        }
        $("#search").click(function () {
            productName = $("#productName").val();
            init(1);
        });
        $("#productName").bind('keypress', function (event) {
            if(event.keyCode=="13"){
                productName = $("#productName").val();
                init(1);
			}
        });
		$(".require").click(function(){
            document.getElementById("add-product").value = "";
            document.getElementById("add-num").value = "";
            $(".repes,.mengban").show();
        });
		$(".addbtn").click(function(){
			$(".repes,.mengban").hide();
		});
        $(".save").click(function () {
            var params = {};
            params.name = $("#add-product").val();
            params.num = $("#add-num").val();
            $.ajax({
                url: "${basePath}/add-product.json",
				type:"post",
				data:params,
				success:function (json) {
                    init(1);
                }
			});
        });
	</script>
	<%@include file="../include/footer.jsp"%>

</body>
</html>