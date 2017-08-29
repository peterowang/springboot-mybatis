<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>企业人员详情</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/commercial.css">
	<link rel="shortcut icon" href="images/logo.png" type="image/x-icon"/>
	<script src="js/laydate/laydate.js"></script>

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
				<p class='top'><span>企业列表<em>></em></span><span >企业详情</span><em>></em></span><span class="qiDetail">人员详情</span></p>
				<div class="mainList">
					<ul class="indexList">
						<li><span><em>*</em>姓名：</span><input type="text" placeholder="人员名称" id="name" value="${info.name}" maxlength="64"></li>
						<li><span><em>*</em>性别：</span>
							<select name="" id="sex">
								<option value="男" <c:if test="${info.sex eq '男'}">selected</c:if>>男</option>
								<option value="女" <c:if test="${info.sex eq '女'}">selected</c:if>>女</option>
							</select>
						</li>
						<li><span><em>*</em>民族：</span>
							<input type="text" id="national" placeholder="民族" value="${info.national}" maxlength="64">
						</li>
						<li><span><em>*</em>出生年月日：</span>
							<input type="text" placeholder="请选择" id="date_of_birth" value="${info.dateOfBirth}" onclick="laydate()">
						</li>
						<li><span>企业名称：</span>${enterpriseName}</li>
						<li><span><em>*</em>职位：</span>
							<select name="" id="position">
								<option value="1" <c:if test="${info.position eq '1'}">selected</c:if>>管理人员</option>
								<option value="2" <c:if test="${info.position eq '2'}">selected</c:if>>普通人员</option>
								<option value="3" <c:if test="${info.position eq '3'}">selected</c:if>>屠宰人员</option>
								<option value="4" <c:if test="${info.position eq '4'}">selected</c:if>>检疫人员</option>
							</select>
						</li>
						<li id="ahong" <c:if test="${info.position != '3'}">style="display:none"</c:if>><span><em>*</em>上传阿訇证照：</span><div class="upload">
							<input type="file" name="files" class="file" id="imam-photo">
							<input type="hidden" id="imam-photo-val" value="${info.imamPhoto}">
							<c:if test="${not empty info.imamPhoto && info.position==3}">
								<img src="${pic_prex}${info.imamPhoto}" width="112px" id="imam-photo-up" alt="" >
							</c:if>
							<c:if test="${empty info.imamPhoto || info.position!=3}">
								<img src="images/upload.png" width="112px" id="imam-photo-up" alt="" >
							</c:if>
						</div></li>
						<li><span>婚姻状况：</span>
							<select name="" id="marital_status">
								<option value="1" <c:if test="${info.maritalStatus eq '1'}">selected</c:if>>未婚</option>
								<option value="2" <c:if test="${info.maritalStatus eq '2'}">selected</c:if>>已婚</option>
							</select>
						</li>
						<li><span><em>*</em>联系电话：</span><input type="text" placeholder="输入电话" id="phone_number" value="${info.phoneNumber}" maxlength="64"></li>
						<li><span>证件类型：</span>
							<select name="" id="document_type">
								<option value="1" <c:if test="${info.documentType eq '1'}">selected</c:if>>身份证</option>
							</select>
						</li>

						<li><span>证件号码：</span><input type="text" id="document_number" value="${info.documentNumber}"  maxlength="18"></li>
						<li><span>住宿地址：</span>

						<%@include file="include/create-edit-address.jsp"%>
						<li>
							<span class="save" onclick="save()">保存</span>
							<span class="save" onclick="history.back()">返回</span>
						</li>
					</ul>
				</div>
				
				<!-- <div class="save">
					<span>保存</span>
				</div> -->
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
	   $("#position").change(function(){
	       var val = $("#position").val();
			if(val==3){
			    $("#ahong").show();
			}else{
                $("#ahong").hide();
            }
		});
   </script>

	<script type="text/javascript">
        function save(){
            var params={};
            params.id = '${info.id}';
            params.enterpriseId = '${info.enterpriseId}';
            params.name = $.trim($("#name").val());
            params.sex = $("#sex").val();
            params.national = $.trim($("#national").val());
            params.dateOfBirth = $("#date_of_birth").val();
            params.position = $("#position").val();
            params.maritalStatus = $("#marital_status").val();
            params.phoneNumber = $.trim($("#phone_number").val());
            params.documentType = $("#document_type").val();
            params.documentNumber = $.trim($("#document_number").val());

            params.addressId = '${info.addressId}';
            params.province = $("#province option:selected").text();
            params.city = $("#city option:selected").text();
            params.district = $("#district option:selected").text();
            params.township = $.trim($("#township").val());
            params.village = $.trim($("#village").val());
            params.streetAddresses = $.trim($("#streetAddresses").val());
            if(params.name==""){
                alert("请输入姓名！");
                return
            }
            if(params.national==""){
                alert("请输入民族！");
                return
            }
            if(params.dateOfBirth==""){
                alert("请输入生日！");
                return
            }
            if(params.phoneNumber==""){
                alert("请输入电话号！");
                return
            }
            var myreg = /^((1[0-9]{2})+\d{8})$/;
            if(!myreg.test(params.phoneNumber))
            {
                alert('请输入有效的手机号码！');
                return false;
            }
            if(params.province!="请选择"){
                if(params.province==""||params.city==""||params.district==""||params.province=="请选择"||params.city=="请选择"||params.district=="请选择"){
                    alert("请选择住宿地址！");
                    return;
                }
            }
            if(params.province=="请选择"){
                params.province=null;
                params.city=null;
                params.district=null;
            }
            if(params.position==3){
                params.imamPhoto = $("#imam-photo-val").val();
                if(params.imamPhoto==""){
                    alert("请为屠宰人员上传屠宰证照");
                    return;
                }
            }

            $.ajax({
                url:"${basePath}/enterprise-update-personnel.json",
                type:"post",
                data:params,
                success:function(json){
                    if(json.result.code==0){
                        alert("更新用户成功");
                        window.location.href="${basePath}/enterprise-${info.enterpriseId}.html?tab=3";
                    }else if(json.result.code==2){
                        alert(json.result.msg);
                    }else {
                        alert(json.result.msg+" "+json.data);
                    }
                }
            });
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
	<%@include file="../include/footer.jsp"%>

</body>
</html>