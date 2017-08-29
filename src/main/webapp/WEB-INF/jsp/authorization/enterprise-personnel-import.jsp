<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>人员架构</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/device.css">
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
				<p class='top'><span>企业列表<em>></em></span><span class="qiDetail">新建企业</span></p>
				<div class="mainList">
					<ul class="indexList">
						<li>
							<img src="images/pic5.png" alt="" class="pic1">
							<img src="images/biaoti.png" alt="" class="pic2">
							<img src="images/pic7.png" alt="" class="pic3">
							<img src="images/pic4.png" alt="" class="pic4">
						</li>
					</ul>
					<div class='divcenter'>
						<p class='namelist' >
							<a href="download/template.xlsx">下载模板</a>
							<input type="file" id="upload" name="files" value="导入人员名单">
							<a href="${basePath}/enterprise-create-person-${enterpriseId}.html"><input type="button" value="手动添加人员"></a>
						</p>
						<div class='equipment' >
						</div>
						<div class='tab'>
							<table>

								<thead>
								<tr>
									<th>姓名</th>
									<th>手机号</th>
									<th>性别</th>
									<th>生日</th>
									<th>职位</th>
								</tr>
								</thead>
								<tbody id="plist">

								</tbody>
							</table>
						</div>
						<div class="next">
							<a href="${basePath}/enterprise-app-auth-${enterpriseId}.html"><span>上一步</span></a>
							<a href="javascript:;" onclick="infoImport()"><span>保存并下一步</span></a>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
   <script src="js/jquery-1.8.0.min.js"></script>
   <script src="js/common.js"></script>
	<script src="js/jquery.ui.widget.js"></script>
	<script src="js/jquery.fileupload.js"></script>
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
<script type="text/javascript">
	var info = new Array();
    $(function(){
        //文件上传地址
        var url = '${basePath}/enterprise-upload.json';
        //初始化，主要是设置上传参数，以及事件处理方法(回调函数)
        $('#upload').fileupload({
            autoUpload: true,//是否自动上传
            url: url,//上传地址
            dataType: 'json',
            done: function (e, data) {//设置文件上传完毕事件的回调函数
//                alert(data);
                if(data.result.result.code=='0'){
                    var html = '';
                    info = new Array();
                    for(var i=0;i<data.result.data.length;i++){
                        var item = data.result.data[i];
                        item.enterpriseId = '${enterpriseId}';
                        info.push(item);
                        html+='<tr>';
                        html+='<td>'+item.name+'</td>';
                        html+='<td>'+item.phoneNumber+'</td>';
                        html+='<td>'+item.sex+'</td>';
                        html+='<td>'+item.dateOfBirth+'</td>';
                        html+='<td>'+item.positionName+'</td>';
                        html+='</tr>';
					}
					$("#plist").html(html);
                }else{
                 	alert(data.result.msg);
                }
            }
        });
        $("#service").addClass("active");

    });
    function removeInfo(phoneNumber){
        var b = new Array();
        for(var i=0;i<apps.length;i++){
            if(apps[i].phoneNumber==phoneNumber){
                continue;
            }
            b.push(apps[i]);
        }
        info = b;

    }
    function infoImport(){
        var params={};
        params.personnels = JSON.stringify(info);;

        $.ajax({
            url:"${basePath}/enterprise-import.json",
            type:"post",
            data:params,
            success:function(json){
                if(json.result.code==0){
                    window.location.href="${basePath}/enterprise-complete-${enterpriseId}.html";
                }else if(json.result.code==2){
                    alert(json.result.msg);
                }else if(json.result.code==3){
                    alert(json.result.msg+" "+json.data);
                    window.location.href="${basePath}/enterprise-complete-${enterpriseId}.html";
                }else {
                    alert(json.result.msg+" "+json.data);
                }
            }
        });
	}
</script>
	<%@include file="../include/footer.jsp"%>
</body>
</html>