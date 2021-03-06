<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>防伪码信息管理</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/drug.css">
	<link rel="shortcut icon" href="images/logo.png" type="image/x-icon"/>
</head>
<body>
	<div class="mengban"></div>
	<!-- 添加弹框 -->
	<div class='result' style="height: 250px;">
		<p><span>防伪码：</span><input type="text" placeholder='输入防伪码' id="treatmentPlan"  maxlength="64"></p>
		<p class='baocun' onclick="save()"><em>保存</em></p>
		<p class='baocun' onclick="hide()"><em>取消</em></p>
	</div>
	<!-- 退出 -->
	<%@include file="../include/header.jsp"%>
	<!-- 删除 -->
	<div class="quitCon2">
		<p>是否删除此防伪码？</p>
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
				<p class='top'><span>基础信息管理</span><em>></em><span class="qiDetail">防伪码信息管理</span></p>
				<div class='mainList'>
					<div class='divs'>
						<p class='conLeft'  onclick="location.reload()">全部信息</p>
						<ul class="conRight">
							<li><em class="require addyp">新增防伪码</em></li>
							<li><input type="file" id="upload" name="files" value="导入防伪码" maxlength="64"></li>
							<li><input type="text" id="code"></li>
							<li><em class="require" onclick="init(0)">查询</em></li>
						</ul>
					</div>
					<div class="tab">
						<table>
							<thead>
								<tr>
									<th>防伪码</th>
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
            params.code = $.trim($("#code").val());
            $.ajax({
                url:"${basePath}/security-code.json",
                type:"post",
                data:params,
                success:function(json){
                    if(json.result.code==0){
                        var html = "";
                        for(var i=0;i<json.data.totalList.length;i++){
                            var item = json.data.totalList[i];
                            html += '<tr>';
                            html += '<td>'+item.securityCode+'</td>';
							html += '<td>'+getLocalTime(item.createTime)+'</td>';
                            html += '<td><em class="modify remove2" onclick="remove2(\''+item.id+'\')">删除</em></td>';
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
            params.securityCode = $.trim($("#treatmentPlan").val());
            if(params.securityCode==""){
                alert("请输入防伪码！");
                return;
            }
            i_id = "0";
            $.ajax({
                url:"${basePath}/securityadd-code.json",
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
                url:"${basePath}/securitydel-code.json",
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
//        function getLocalTime(nS) {
//            return new Date(parseInt(nS)).toLocaleString().substr(0,17);
//        }
        function getLocalTime (strTime) {
            var date = new Date(strTime);
            return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
        }
        function addyp(id,treatmentPlan){
            i_id=id;
            $("#treatmentPlan").val(treatmentPlan);
            $(".mengban ,.result").show();
        }
        function remove2(id){
            i_id=id;
            $(".mengban, .quitCon2").show();
        }

        var info = new Array();
        $(function(){
            //文件上传地址
            var url = '${basePath}/security-upload.json';
            //初始化，主要是设置上传参数，以及事件处理方法(回调函数)
            $('#upload').fileupload({
                autoUpload: true,//是否自动上传
                url: url,//上传地址
                dataType: 'json',
                done: function (e, data) {//设置文件上传完毕事件的回调函数
//                alert(data);
                    if(data.result.result.code=='0'){
                        alert("导入防伪码成功！")
                        init(0);
                    }else{
                        alert(data.result.result.msg+" "+data.result.data);
                        init(0);
                    }
                }
            });
            $("#service").addClass("active");

        });
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