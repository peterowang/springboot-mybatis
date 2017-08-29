<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>追溯标签信息管理</title>
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
			<li><span>生产许可证号:</span><input type="text" placeholder='生产商生产许可证号' id="productionLicenseNumber" maxlength="64"></li>
			<li><span>保质期:</span><input type="text" placeholder='产品保质期，如：24个月' id="shelfLife" maxlength="64"></li>
			<li><span>执行标准:</span><input type="text" placeholder='执行标准号' id="executionStandard" maxlength="64"></li>
			<li><span>电话:</span><input type="text" placeholder='生产商电话号码' id="phone" maxlength="64"></li>
			<%--<li><span>防伪码:</span><input type="text" placeholder='标签图层挂开后显示的防伪号' id="securityCode" maxlength="64"></li>--%>
			<li><span>生产商:</span><input type="text" placeholder='生产商名称' id="producers" maxlength="64"></li>
			<li><span>网址:</span><input type="text" placeholder='生产商网址' id="url" maxlength="64"></li>
			<li><span>产地:</span><input type="text" placeholder='产地' id="origin" maxlength="64"></li>
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
				<p class='top'><span>基础信息管理</span><em>></em><span class="qiDetail">追溯标签信息管理</span></p>
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
                url:"${basePath}/tag-manage.json",
                type:"post",
                data:params,
                success:function(json){

                    if(json.result.code==0){
                        var html = "";
                        for(var i=0;i<json.data.totalList.length;i++){
                            var item = json.data.totalList[i];
                            html += '<tr>';
                            html += '<td>'+item.enterpriseName+'</td>';
                            html += '<td>'+item.status+'</td>';
                            html += '<td><span class="look" onclick="look(\''+item.id+'\',\''+item.enterpriseId+'\')">查看</span></td>';
                            html += '</tr>';
                        }

                        $("#centerlist").html(html);
                        topage(json.data);
                    }
                }

            });
        }
        var i_id="0";
        function save(enterpriseId) {
            var params={};
            params.id = i_id;
            params.productionLicenseNumber = $.trim($("#productionLicenseNumber").val());
            params.shelfLife =$.trim($("#shelfLife").val());
            params.executionStandard =  $.trim($("#executionStandard").val());

            params.phone =  $.trim($("#phone").val());
            params.producers =  $.trim($("#producers").val());
//            params.securityCode = $.trim($("#securityCode").val());
            params.url =  $.trim($("#url").val());
            params.origin =  $.trim($("#origin").val());
            params.enterpriseId =  enterpriseId;
            if(params.productionLicenseNumber==""){
                alert("请输入生产许可证号！");
                return;
			}
            if(params.shelfLife==""){
                alert("请输入保质期！");
                return;
            }
            if(params.executionStandard==""){
                alert("请输入执行标准！");
                return;
            }
            if(params.phone==""){
                alert("请输入电话！");
                return;
            }
            if(params.producers==""){
                alert("请输入生产商！");
                return;
            }
//            if(params.securityCode==""){
//                alert("请输入防伪码！");
//                return;
//            }
            if(params.url==""){
                alert("请输入网址！");
                return;
            }
            if(params.origin==""){
                alert("请输入产地！");
                return;
            }
            $.ajax({
                url:"${basePath}/tagupdate-manage.json",
                type:"post",
                data:params,
                success:function(json){

                    if(json.result.code==0){
                       alert("保存成功");
						init(1);
                    }else{
                        alert(json.result.msg);
                    }
                }

            });
        }
        function look(id,enterpriseId){
            $(".mengban ,.trace").show();
            i_id = id;
            var params={};
            params.id = id;
            params.enterpriseId = enterpriseId;
            $.ajax({
                url:"${basePath}/tag-info.json",
                type:"post",
                data:params,
                success:function(json){

                    if(json.result.code==0){
                        var item = json.data;
                        $("#productionLicenseNumber").val(item.productionLicenseNumber);
                        $("#shelfLife").val(item.shelfLife);
                        $("#executionStandard").val(item.executionStandard);
                        $("#phone").val(item.phone);
                        $("#securityCode").val(item.securityCode);
                        $("#url").val(item.url);
                        $("#enterpriseName").text(item.enterpriseName);
                        $("#producers").val(item.producers);
                        $("#origin").val(item.origin);
						$("#save").attr("onclick","save('"+item.enterpriseId+"')");
						init(1);
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