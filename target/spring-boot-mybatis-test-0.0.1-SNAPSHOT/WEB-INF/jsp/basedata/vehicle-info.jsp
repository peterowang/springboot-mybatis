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
			<li><span>车牌号:</span><input type="text" placeholder='车牌号' id="licensePlateNumber" maxlength="64"></li>
			<li><span>企业名称:</span><span style="width: 200px;text-align: left;margin-left: 20px;">${enterprise.enterpriseName}</span></li>
			<li><span>责任人:</span>
				<select id="logisticsPrincipalId">
					<c:forEach items="${list}" var="item">
					<option value="${item.id}">${item.name}</option>
					</c:forEach>
			</select>
			</li>
			<li><span>联系电话:</span><input type="text" placeholder='联系电话' id="phoneNumber" maxlength="64"></li>
			<li class='baocun deposit' >
				<p class='baocun' id="save" onclick="save()"><em>保存</em></p>
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
						<p class='conLeft' onclick="init(0)">全部信息</p>
						&nbsp;
						<p class='conLeft' id="open"  style="margin-left: 10px;">添加</p>

					</div>
					<div class="tab">
						<table>
							<thead>
								<tr>
									<th>车牌号</th>
									<th>责任人</th>
									<th>联系电话</th>
									<th>创建时间</th>
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
            params.enterpriseId = '${enterprise.id}';
            $.ajax({
                url:"${basePath}/vehicle-info-manage.json",
                type:"post",
                data:params,
                success:function(json){

                    if(json.result.code==0){
                        var html = "";
                        for(var i=0;i<json.data.totalList.length;i++){
                            var item = json.data.totalList[i];
                            html += '<tr>';
                            html += '<td>'+item.licensePlateNumber+'</td>';
                            html += '<td>'+item.personnelName+'</td>';
                            html += '<td>'+item.phoneNumber+'</td>';
                            html += '<td>'+item.createTime+'</td>';
                            html += '<td><span class="look" onclick="look(\''+item.id+'\')">查看</span></td>';
                            html += '</tr>';
                        }

                        $("#centerlist").html(html);
                        topage(json.data);
                    }
                }

            });
        }
        var i_id = 0;
        function save() {

            var params={};
            params.id = i_id;
            params.licensePlateNumber = $.trim($("#licensePlateNumber").val());
            params.enterpriseId = ${enterprise.id};
            params.logisticsPrincipalId =  $("#logisticsPrincipalId").val();

            params.phoneNumber =  $.trim($("#phoneNumber").val());

            if(params.licensePlateNumber==""){
                alert("请输入车牌号！");
                return;
            }
            if(params.phoneNumber==""){
                alert('请输入有效的手机号码！');
                return;
            }
            var myreg = /^((1[0-9]{2})+\d{8})$/;
            if(!myreg.test(params.phoneNumber))
            {
                alert('请输入有效的手机号码！');
                return false;
            }
            $.ajax({
                url:"${basePath}/vehicle-save.json",
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

        function look(id){
            $(".mengban ,.trace").show();
            i_id = id;
            var params={};
            params.id = id;
            $.ajax({
                url:"${basePath}/vehicle-info.json",
                type:"post",
                data:params,
                success:function(json){

                    if(json.result.code==0){
                        var item = json.data;
                        $("#licensePlateNumber").val(item.licensePlateNumber);
                        $("#phoneNumber").val(item.phoneNumber);
                        $("#logisticsPrincipalId").val(item.logisticsPrincipalId);

                    }
                }

            });
        }

	</script>
	<script>
        $("#open").click(function(){
            i_id=0;
            $("#licensePlateNumber").val("");
            $("#phoneNumber").val("");
            $(".mengban ,.trace").show();
        })
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