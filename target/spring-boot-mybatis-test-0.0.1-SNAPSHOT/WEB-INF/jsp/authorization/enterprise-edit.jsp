<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>修改企业信息</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/commercial.css">
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
			<!-- 右侧 -->
			<div class="mainRight">
				<p class='top'><span>企业列表<em>></em></span><span >企业详情</span><em>></em></span><span class="qiDetail">修改企业信息</span></p>
				<div class="mainList">
					<ul class="indexList">
					<li><span><em>*</em>企业名称：</span><input type="text" placeholder="企业名称" id="name" value="${info.enterpriseName}" maxlength="64"></li>
					<li><span><em>*</em>企业类型：</span>
						<select name="" id="type" onchange="liopen(this)">
							<c:if test="${enterpriseType eq 5}">
								<option value="5">超管企业</option>
							</c:if>
							<c:if test="${enterpriseType eq 5}">
							<option value="1" <c:if test="${info.enterpriseType eq 1}">selected</c:if>>养殖企业</option>
							<option value="2" <c:if test="${info.enterpriseType eq 2}">selected</c:if>>屠宰企业</option>
							<option value="3" <c:if test="${info.enterpriseType eq 3}">selected</c:if>>加工企业</option>
							<option value="4" <c:if test="${info.enterpriseType eq 4}">selected</c:if>>商户</option>
							</c:if>
						</select>
					</li>

						<li id="logo-li" <c:if test="${info.enterpriseType=='1'}">style="display: none;"</c:if>>
							<span><em>*</em>logo：</span><div class="upload">
						<input type="file" name="files" class="file" id="logo">
						<input type="hidden"  id="logo-val" value="${logo}">
						<img src="<c:if test="${empty logo}">images/upload.png</c:if><c:if test="${not empty logo}">${info.logo}</c:if>" id="logo-up" width="112px" alt="" >
					</div></li>
					<li><span><em>*</em>营业执照号：</span><input type="text" placeholder="输入xx位营业执照编号" id="license-number" value="${info.licenseNumber}" maxlength="64"></li>
					<li><span><em>*</em>营业执照扫描件：</span><div class="upload">
						<input type="file" name="files" class="file" id="business-license">
						<input type="hidden" id="business-license-val" value="${businessLicense}">
						<img src="<c:if test="${empty businessLicense}">images/upload.png</c:if><c:if test="${not empty businessLicense}">${info.businessLicense}</c:if>" width="112px" id="business-license-up" alt="" >
					</div></li>
					<li><span><em>*</em>是否清真企业：</span>
						<p class="radio">
							<input type="radio" id="ra1" name="is-muslim" <c:if test="${info.isMuslim eq '是'}">checked</c:if> value="是">
							<label for="ra1">是</label>
						</p>
						<p class="radio">
							<input type="radio" id="ra2" name="is-muslim" <c:if test="${info.isMuslim eq '否'}">checked</c:if> value="否">
							<label for="ra2">否</label>
						</p>
					</li>
					<li><span><em>*</em>清真证照描件：</span><div class="upload">
						<input type="file" class="file" name="files"  id="muslim-photo">
						<input type="hidden" id="muslim-photo-val" value="${muslimPhoto}">
						<img src="<c:if test="${empty muslimPhoto}">images/upload.png</c:if><c:if test="${not empty muslimPhoto}">${info.muslimPhoto}</c:if>" alt="" width="112px"  id="muslim-photo-up">
					</div></li>
					<li><span><em>*</em>企业负责人：</span><input type="text" placeholder="输入企业负责人姓名" value="${info.principalName}" id="principal" maxlength="64"></li>
					<li><span>联系电话：</span><input type="text" placeholder="输入企业负责人电话" id="telephone" value="${info.telephone}" maxlength="64"></li>
					<li><span>传真：</span><input type="text" placeholder="输入传真" id="fax" value="${info.fax}" maxlength="64"></li>
					<li><span>电子邮件：</span><input type="text" placeholder="输入企业邮件" id="email" value="${info.email}" maxlength="64"></li>
						<li><span><em>*</em>注册地址：</span>

						<%@ include file="include/create-edit-address.jsp"%>

					<li id="fs-li" <c:if test="${info.enterpriseType!='1'}">style="display: none;"</c:if>><span>养殖规模：</span><input type="text" id="farming-scale" placeholder="" maxlength="64"></li>
					<li id="ic-li" <c:if test="${info.enterpriseType!='1'}">style="display: none;"</c:if>><span>标识代码：</span><input type="text" id="identification-code" placeholder="" maxlength="64"></li>
					<li id="aa-li" <c:if test="${info.enterpriseType!='1'}">style="display: none;"</c:if>><span>行政区域代码：</span><input type="text" id="administrative-areas" placeholder="" maxlength="64"></li>
					<li id="mn-li" <c:if test="${info.enterpriseType!='1'}">style="display: none;"</c:if>><span>视频监控设备号：</span><input type="text" id="monitor-number" placeholder="" maxlength="64"></li>
					<li>
						<span class="save" onclick="save()">保存</span>
					</li>
				</ul>
				</div>
			</div>
		</div>
	</div>
   <script src="js/jquery-1.8.0.min.js"></script>
   <script src="js/common.js"></script>
	<script src="js/jquery.ui.widget.js"></script>
	<script src="js/jquery.fileupload.js"></script>
	<script type="text/javascript">


        function save() {
            var params={};
            params.id = '${info.id}';
            params.enterpriseName = $("#name").val();
            params.enterpriseType = $("#type").val();
            params.logo = $("#logo-val").val();
            params.licenseNumber = $("#license-number").val();
            params.businessLicense = $("#business-license-val").val();
            params.isMuslim = $("input[name='is-muslim']:checked").val();
            params.muslimPhoto = $("#muslim-photo-val").val();
            params.principalName = $("#principal").val();
            params.telephone = $("#telephone").val();
            params.fax = $("#fax").val();
            params.email = $("#email").val();
            params.province = $("#province option:selected").text();
            params.city = $("#city option:selected").text();
            params.district = $("#district option:selected").text();
            params.township = $("#township").val();
            params.village = $("#village").val();
            params.streetAddresses = $("#streetAddresses").val();


            params.farmingScale = $("#yz-farming-scale").val();
            params.identificationCode = $("#yz-identification-code").val();
            params.administrativeAreas = $("#yz-administrative-areas").val();
            params.monitorNumber = $("#yz-monitor-number").val();

            if(params.enterpriseName==""){
                alert("请输入企业名！");
                return;
            }
            if(params.enterpriseType!='1'){
                if(params.logo==""){
                    alert("请上传企业logo！");
                    return;
                }
            }

            if(params.licenseNumber==""){
                alert("请输入营业执照编号！");
                return;
            }
            if(params.businessLicense==""){
                alert("请上传营业执照！");
                return;
            }
            if(params.isMuslim=="是"){
                if(params.muslimPhoto==""){
                    alert("请上传清真证照！");
                    return;
                }
            }
            if(params.principalName==""){
                alert("请输入企业负责人姓名！");
                return;
            }
            if(params.email!=""){
                var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
				if(!myreg.test(temp.value)) {
				   alert('请输入有效的E_mail！');
				  return;
			   }
            }
            if(params.province==""||params.city==""||params.district==""||params.province=="请选择"||params.city=="请选择"||params.district=="请选择"){
                alert("请选择企业地址！");
                return;
            }
            $.ajax({
                url:"${basePath}/enterprise-save.json",
                type:"post",
                data:params,
                success:function(json){
                    if(json.result.code==0){
                        alert("保存成功！");
                        window.location.href="${basePath}/enterprise-${info.id}.html";
                    }else {
                        alert(json.result.msg);
                    }
                }
            });
        }
        function liopen(obj) {
			var a = $(obj).val();
			if(a=='1'){
			    $("#logo-li").hide();
			    $("#fs-li").show();
			    $("#ic-li").show();
			    $("#aa-li").show();
			    $("#mn-li").show();
			}else{
                $("#logo-li").show();
                $("#fs-li").hide();
                $("#ic-li").hide();
                $("#aa-li").hide();
                $("#mn-li").hide();

            }
        }
	</script>


	<script type="text/javascript">
        $(function(){
            //文件上传地址
            var url = '${basePath}/img-upload.json';
            //初始化，主要是设置上传参数，以及事件处理方法(回调函数)
            $('#logo').fileupload({
                autoUpload: true,//是否自动上传
                url: url,//上传地址
                dataType: 'json',
                done: function (e, data) {//设置文件上传完毕事件的回调函数
                    if(data.result.result.code=='0'){
                        $("#logo-up").attr("src",data.result.data["url"]);
                        $("#logo-val").val(data.result.data["key"])
                    }else{
                        alert(data.result.result.msg);
                    }
                }
            });
            $("#service").addClass("active");
        });
        $(function(){
            //文件上传地址
            var url = '${basePath}/img-upload.json';
            //初始化，主要是设置上传参数，以及事件处理方法(回调函数)
            $('#business-license').fileupload({
                autoUpload: true,//是否自动上传
                url: url,//上传地址
                dataType: 'json',
                done: function (e, data) {//设置文件上传完毕事件的回调函数
                    if(data.result.result.code=='0'){
                        $("#business-license-up").attr("src",data.result.data["url"]);
                        $("#business-license-val").val(data.result.data["key"])
                    }else{
                        alert(data.result.result.msg);
                    }
                }
            });
            $("#service").addClass("active");
        });

        $(function(){
            //文件上传地址
            var url = '${basePath}/img-upload.json';
            //初始化，主要是设置上传参数，以及事件处理方法(回调函数)
            $('#muslim-photo').fileupload({
                autoUpload: true,//是否自动上传
                url: url,//上传地址
                dataType: 'json',
                done: function (e, data) {//设置文件上传完毕事件的回调函数
                    if(data.result.result.code=='0'){
                        $("#muslim-photo-up").attr("src",data.result.data["url"]);
                        $("#muslim-photo-val").val(data.result.data["key"])
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