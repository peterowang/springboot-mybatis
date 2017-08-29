<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>药品数据管理</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/drug.css">
	<link rel="shortcut icon" href="images/logo.png" type="image/x-icon"/>
</head>
<body>
	<div class="mengban"></div>
	<!-- 添加弹框 -->
	<div class="Bombox">
		<p><span>药品名称：</span><input type="text" placeholder='输入药品名称' id="name" maxlength="64"></p>
		<p><span>药品类型：</span><select name="" id="drugType"><option value="1">免疫</option>
			<option value="2">消毒</option>
			<option value="3">诊疗</option></select></p>
		<p class='baocun' onclick="save()"><em>保存</em></p>
		<p class='baocun' onclick="hide()"><em>取消</em></p>

	</div>
	<!-- 退出 -->
	<%@include file="../include/header.jsp"%>
	<!-- 删除 -->
	<div class="quitCon2">
		<p>是否删除该药品数据？</p>
		<div class="btns">
			<span>取消</span>
			<span class="off" onclick="del()">确定</span>
		</div>
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
				<p class='top'><span>基础信息管理</span><em>></em><span class="qiDetail">药品信息管理</span></p>
				<div class='mainList'>
					<div class='divs'>
						<p class='conLeft' onclick="location.reload()">全部信息</p>
						<ul class="conRight">

							<li><span>种类：</span><select name="" id="stype"><option value="0">不限</option>
										<option value="1">免疫</option>
										<option value="2">消毒</option>
										<option value="3">诊疗</option>
							</select></li>
							<li><em class="require" onclick="init(1)">查询</em></li>
							<li><em class="require addyp">新增药品</em></li>
						</ul>
					</div>
					<div class="tab">
						<table>
							<thead>
								<tr>
									<th>药品名称</th>
									<th>类型</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody id="cdruglist" class="cdruglist">

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
            $("#stype").val(0);
			init(1);
        }
        function init(pageNo) {
            var params={};
            params.pageNo = pageNo;
            params.pageSize = pageSize;
            params.enterpriseId = 0;
            params.drugType = $("#stype").val();
            $.ajax({
                url:"${basePath}/drug-manage.json",
                type:"post",
                data:params,
                success:function(json){

                    if(json.result.code==0){
                        var html = "";
                        for(var i=0;i<json.data.totalList.length;i++){
                            var item = json.data.totalList[i];
                            html += '<tr>';
                            html += '<td>'+item.drugName+'</td>';
                            if(item.drugType==1){
                                html += '<td>免疫</td>';
                            }else if(item.drugType==2){
                                html += '<td>消毒</td>';
                            }else if(item.drugType==3){
                                html += '<td>诊疗</td>';
                            }else{
                                html += '<td>'+item.drugType+'</td>';
                            }
                            html += '<td><em class="modify addyp" onclick="addyp(\''+item.id+'\',\''+item.drugName+'\',\''+item.drugType+'\')">修改</em>/<em class="modify remove2" onclick="remove2(\''+item.id+'\')">删除</em></td>';
                            html += '</tr>';
                        }

                        $("#cdruglist").html(html);
                        topage(json.data);
                    }
                }

            });
        }

        var i_id="0";

        function save(){
            var params={};
            params.id = i_id;
            params.drugType = $("#drugType").val();
            params.drugName = $.trim($("#name").val());
            params.enterpriseId = '${enterpriseId}';
            if(params.drugName==""){
                alert("请输药品名称！");
                return;
            }
            i_id = "0";
            $.ajax({
                url:"${basePath}/drugadd-manage.json",
                type:"post",
                data:params,
                success:function(json){

                    if(json.result.code==0){
						alert("保存成功！");
                    }else{
                        alert(json.result.msg);
                    }
                    init(1);

                }
            });
		}
        function del(){
            var params={};
            params.id = i_id;

            $.ajax({
                url:"${basePath}/drugupdate-manage.json",
                type:"post",
                data:params,
                success:function(json){

                    if(json.result.code==0){
                        alert("删除成功！");
                    }else{
                        alert(json.result.msg);
                    }
                    init(1);

                }
            });
        }

        function addyp(id,name,drugType){
            i_id=id;
            $("#name").val(name);
            $("#drugType").val(drugType);
            $(".mengban ,.Bombox").show();
		}
		function remove2(id){
            i_id=id;
            $(".mengban ,.quitCon2").show();
		}
		function hide() {
            $(".mengban ,.Bombox").hide();
        }
	</script>
	<script>
	    // 新增和修改
		$(".addyp").click(function(){
			$(".mengban ,.Bombox").show();
		})
		$(".baocun em").click(function(){
			$(".mengban ,.Bombox").hide();
		})

		// 删除
		$(".remove2").click(function(){
			$(".mengban ,.quitCon2").show();
		})
	</script>
	<%@include file="../include/footer.jsp"%>

</body>
</html>