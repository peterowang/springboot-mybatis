<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>饲料数据管理</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/drug.css">
	<link rel="shortcut icon" href="images/logo.png" type="image/x-icon"/>
</head>
<body>
	<div class="mengban"></div>
	<!-- 添加弹框 -->
	<div class="feedbox">
		<ul>
			<li><span>饲料名称:</span><input type="text" placeholder='输入饲料名称' id="name" maxlength="64"></li>
			<li><span>生产厂商:</span><input type="text" placeholder='输入生产厂商名称' id="manufacturer" maxlength="64"></li>
			<li><span class='licence'>生产许可证:</span>
				<div class="upload">
					<input type="file" name="files" class="file" id="imam-photo">
					<input type="hidden" id="imam-photo-val">
					<img src="images/upload.png" width="112px" id="imam-photo-up" alt="" >
				</div>
			</li>
			<li><span class='save' onclick="save()">保存</span></li>
			<li><span class='protect'>取消</span></li>
		</ul>
	</div>
	<div class="Bombox">
		<p><span>饲料名称：</span><input type="text" placeholder='输入饲料名称'></p>
		<p><span>种类：</span><select name="" id=""><option value="">牧草</option></select></p>
		<p class='baocun'><em>保存</em></p>
		<p class='protectbao'><em>保存</em></p>
	</div>
	<!-- 退出 -->
	<%@include file="../include/header.jsp"%>
	<!-- 删除 -->
	<div class="quitCon2">
		<p>是否删除饲料数据？</p>
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
				<p class='top'><span>基础信息管理</span><em>></em><span class="qiDetail">饲料数据管理</span></p>
				<div class='mainList'>
					<div class='divs'>
						<p class='conLeft'  onclick="location.reload()">全部信息</p>
						<ul class="conRight">

							<li><em class="require addyp">新增饲料</em></li>
						</ul>
					</div>
					<div class="tab">
						<table>
							<thead>
								<tr>
									<th>饲料名称</th>
									<th>厂商</th>
									<%--<th>企业</th>--%>
									<th>操作</th>
								</tr>
							</thead>
							<tbody id="cfeedlist" class="cfeedlist">

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
	<script src="js/jquery.ui.widget.js"></script>
	<script src="js/jquery.fileupload.js"></script>

	<script type="text/javascript">
        $(function(){
            init(1);
        });
        function init(pageNo) {
            var params={};
            params.pageNo = pageNo;
            params.pageSize = pageSize;
            $.ajax({
                url:"${basePath}/feed-manage.json",
                type:"post",
                data:params,
                success:function(json){

                    if(json.result.code==0){
                        var html = "";
                        for(var i=0;i<json.data.totalList.length;i++){
                            var item = json.data.totalList[i];
                            html += '<tr>';
                            html += '<td>'+item.name+'</td>';
                            html += '<td>'+item.manufacturer+'</td>';
//                            html += '<td>'+item.enterpriseName+'</td>';
                            html += '<td><em class="modify addyp" onclick="addyp(\''+item.id+'\',\''+item.name+'\',\''+item.manufacturer+'\',\''+item.picture+'\')">修改</em>/<em class="modify remove2" onclick="remove2(\''+item.id+'\')">删除</em></td>';
                            html += '</tr>';
                        }

                        $("#cfeedlist").html(html);
                        topage(json.data);
                    }
                }

            });
        }
        var i_id="0";
        function save(){
            var params={};
            params.id = i_id;
            params.name = $.trim($("#name").val());
            params.manufacturer = $.trim($("#manufacturer").val());
            params.picture = $("#imam-photo-val").val();
            params.enterpriseId = ${enterpriseId};
            params.picture =$("#imam-photo-val").val();
            if(params.name==""){
                alert("请输饲料名称！");
                return;
            }
            if(params.manufacturer==""){
                alert("请输入生产厂商！");
                return;
            }
//            if(params.picture==""){
//                alert("请输入厂商证照！");
//                return;
//            }
            i_id = "0";
            $.ajax({
                url:"${basePath}/feed-save.json",
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
                url:"${basePath}/feed-del.json",
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

        function addyp(id,name,manufacturer,picture){
            i_id = id;
            $("#name").val(name);
            $("#manufacturer").val(manufacturer);
            $("#imam-photo-val").val(picture);
            if(picture==""||picture==null){
                $("#imam-photo-up").attr("src","images/upload.png");
            }else{
                $("#imam-photo-up").attr("src","${pic_prex}"+picture);
            }
            $(".mengban ,.feedbox").show();
        }
        function remove2(id){
            i_id = id;
            $(".mengban, .quitCon2").show();
        }


        $(function(){
            //文件上传地址
            var url = '${basePath}/img-upload.json';
            //初始化，主要是设置上传参数，以及事件处理方法(回调函数)
            $('#imam-photo').fileupload({
                autoUpload: true,//是否自动上传
                url: url,//上传地址
                dataType: 'json',
                done: function (e, data) {//设置文件上传完毕事件的回调函数
                    if(data.result.result.code=='0'){
                        $("#imam-photo-up").attr("src",data.result.data["url"]);
                        $("#imam-photo-val").val(data.result.data["key"])
                    }else{
                        alert(data.result.result.msg);
                    }
                }
            });
            $("#service").addClass("active");
        });
	</script>
	<script>
	    // 新增和修改
		$(".addyp").click(function(){
			$(".mengban ,.feedbox").show();
		})
		$(".save,.protect").click(function(){
			$(".mengban ,.feedbox").hide();
		})
		// 删除
		$(".remove2").click(function(){
			$(".mengban ,.quitCon2").show();
		})
	</script>
	<%@include file="../include/footer.jsp"%>

</body>
</html>