<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>诊疗结果管理</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/drug.css">
	<link rel="shortcut icon" href="images/logo.png" type="image/x-icon"/>
</head>
<body>
	<div class="mengban"></div>
	<!-- 添加弹框 -->
	<div class='result' style="height: 250px;">
		<p><span>诊断结果：</span><input type="text" placeholder='输入病症名称' id="diagnosisResult"  maxlength="64"></p>
		<p class='baocun' onclick="save()"><em>保存</em></p>
		<p class='baocun' onclick="hide()"><em>取消</em></p>

	</div>
	<!-- 退出 -->
	<%@include file="../include/header.jsp"%>
	<!-- 删除 -->
	<div class="quitCon2">
		<p>是否删除诊疗数据？</p>
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
				<p class='top'><span>基础信息管理</span><em>></em><span class="qiDetail">诊疗结果管理</span></p>
				<div class='mainList'>
					<div class='divs'>
						<p class='conLeft'  onclick="location.reload()">全部信息</p>
						<ul class="conRight">

							<li><em class="require addyp">新增诊疗结果</em></li>
						</ul>
					</div>
					<div class="tab">
						<table>
							<thead>
								<tr>
									<th>诊疗结果</th>
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
        function lis(){
            $('.pageNumList').show();
        }
        function indef(){
            var inde = $(this).text();
            $('.pagenum').text(inde);
            $('.pageNumList').hide();
        }
        function init(pageNo) {
            var params={};
            params.pageNo = pageNo;
            params.pageSize = pageSize;
            params.enterpriseId = 1;
            params.type = 1;
            $.ajax({
                url:"${basePath}/diagnosis-manage.json",
                type:"post",
                data:params,
                success:function(json){

                    if(json.result.code==0){
                        var html = "";
                        for(var i=0;i<json.data.totalList.length;i++){
                            var item = json.data.totalList[i];
                            html += '<tr>';
                            html += '<td>'+item.diagnosisResult+'</td>';
                            html += '<td><em class="modify addyp" onclick="addyp(\''+item.id+'\',\''+item.diagnosisResult+'\')">修改</em>/<em class="modify remove2" onclick="remove2(\''+item.id+'\')">删除</em></td>';
                            html += '</tr>';
                        }

                        $("#centerlist").html(html);
                        topage(json.data);
                    }
                }

            });
        }

        var i_id="0";

        function save(){
            var params={};
            params.id = i_id;
            params.diagnosisResult = $.trim($("#diagnosisResult").val());
            params.enterpriseId = '${enterpriseId}';
            if(params.diagnosisResult==""){
                alert("请输入诊断结果！");
                return;
            }
            i_id = "0";
            $.ajax({
                url:"${basePath}/diagnosisadd-manage.json",
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
                url:"${basePath}/diagnosisupdate-manage.json",
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


        function addyp(id,diagnosisResult){
            i_id=id;
            $("#diagnosisResult").val(diagnosisResult);
            $(".mengban ,.result").show();
        }
        function remove2(id){
            i_id=id;
            $(".mengban, .quitCon2").show();
        }
	</script>
	<script>
        function hide() {
            $(".mengban ,.Bombox").hide();
        }
	    // 新增和修改
		$(".addyp").click(function(){
			$(".mengban ,.result").show();
		})
		$(".baocun em").click(function(){
			$(".mengban ,.result").hide();
		})
		// 删除
		$(".remove2").click(function(){
			$(".mengban ,.quitCon2").show();
		})
	</script>
	<%@include file="../include/footer.jsp"%>

</body>
</html>