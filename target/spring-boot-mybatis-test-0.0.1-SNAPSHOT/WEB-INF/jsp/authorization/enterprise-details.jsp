<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>授权管理</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/device.css">
	<link rel="shortcut icon" href="images/logo.png" type="image/x-icon"/>
	<style>
		/* 弹框 */
		.Bombox{
			display: none;
			text-align: center;
			width: 360px;
			/*height:200px;*/
			background: #fff;
			z-index: 120;
			position: fixed;
			left:50%;
			top:50%;
			margin-left: -180px;
			margin-top: -100px;
			padding:25px 0;
		}
		.Bombox p{
			margin-top: 20px;
		}
		.Bombox p span{
			width:70px;
			text-align: right;
			display: inline-block;
		}
		.Bombox p input,select{
			height: 28px;
			font-size: 12px;
			color: #555;
			border: 1px solid #E6E9ED;
			outline: none;
			padding-left: 10px;
			width: 200px;
			line-height: 28px;
			box-shadow: inset 0 0.5px 1px rgba(0,0,0,.075);
		}
	</style>
</head>
<body>
	<div class="mengban"></div>
	<!-- 添加弹框 -->
	<div class="box">
		<div class="hed">
			<img src="images/suc.png" alt="">
			<span>设置管理员</span>
		</div>
		<div class="con">
			<ul class="clearfix">
				<li class="left5">管理员</li>
				<li class="left169">已选<span id="_p">0</span>/<span id="total_p"></span>人</li>
				<li class="left83">新添人员</li>
				<li class="left169 left140">总员工<span id="total_p1"></span>人</li>
			</ul>
			<div class="man" id="man">
			</div>


			<div class="man" id="man1">
			</div>
		</div>
		<div class="btn">
			<span onclick="updateManager('${enterpriseId}')">确定</span>
		</div>
	</div>
	<!-- 退出 -->
	<div class="Bombox">
		<p><img src="" id="img" width="300px"></p>

	</div>
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
				<p class='top'><span>企业列表<em>></em></span><span class="qiDetail">企业详情</span></p>
				<dl class='enterprise'>
					<dt style="widows: 120;"><img src="${enterprise.logo}" ></dt>
					<dd>
						<h2>${enterprise.enterpriseName}</h2>
						<p>

							<span class="iconT" style="color: orange;">
								<c:if test="${enterprise.enterpriseType eq '1'}">养</c:if>
								<c:if test="${enterprise.enterpriseType eq '2'}">屠</c:if>
								<c:if test="${enterprise.enterpriseType eq '3'}">加</c:if>
								<c:if test="${enterprise.enterpriseType eq '4'}">商</c:if>
								<c:if test="${enterprise.enterpriseType eq '5'}">超</c:if>
							</span>
							<c:if test="${enterprise.isMuslim eq '是'}">
								<span class="iconT" style="color: lightgreen;">清</span>
							</c:if>

						</p>
						<p>负责人：${enterprise.principalName} ${enterprise.telephone}</p>
						<p>通讯地址(${address.province}
							<c:if test="${not empty address.province}">、${address.city}</c:if>
							<c:if test="${not empty address.city}">、${address.district}</c:if>
							<c:if test="${not empty address.township}">、${address.township}</c:if>
							<c:if test="${not empty address.village}">、${address.village}</c:if>
							<c:if test="${not empty address.streetAddresses}">、${address.streetAddresses}</c:if>)</p>
					</dd>

					<c:if test="${!(superEnterprise==1 and personnelType==2)}">
						<div class='modify'><a href="enterprise-edit-${enterpriseId}.html">修改</a></div>
					</c:if>
				</dl>
				<div class='center'>
					<ul class="cenTab">

						<a href="${basePath}/enterprise-${enterpriseId}.html">
						<li <c:if test="${param.tab==1 || empty param.tab}">class='bg' </c:if> >设备管理</li>
						</a>
						<a href="${basePath}/enterprise-${enterpriseId}.html?tab=2">
						<li <c:if test="${param.tab==2}">class='bg' </c:if>onclick="applist()">应用管理</li>
						</a>
						<a href="${basePath}/enterprise-${enterpriseId}.html?tab=3">
						<li <c:if test="${param.tab==3}">class='bg' </c:if>onclick="person()">人员架构</li>
						</a>
					</ul>
					<!-- 设备管理 -->
					<div class='main' id="main">
						<div class='divs'>
							<a href="${basePath}/enterprise-${enterpriseId}.html">
							<p class='conLeft'>全部设备</p>
							</a>
							<ul class="conRight">
								<li><span>设备：</span>
									<select name="" id="type">
										<option value="">不限</option>
										<option value="1">耳标</option>
										<option value="2">PDA</option>
									</select>
								</li>

								<li><em class="require" onclick="equipmentlist(1)">查询</em></li>
							</ul>
						</div>
						<div class='tab'>
							<table>
								<thead>
									<tr>
										<th>设备编号</th>
										<th>设备名称</th>
										<th>认领时间</th>
										<th>认领人</th>
										<th>状态</th>
									</tr>
								</thead>
								<tbody id="eqlist">


								</tbody>
							</table>
						</div>
						<%@include file="../include/en-eq-page.jsp"%>
					</div>
					<!-- 应用管理 -->
					 <div class='applyName' id="applist">
					</div>
					<!-- 人员架构 -->
					<div class='structure' id="p">
						<div class='centerTop'>
							<c:if test="${superEnterprise==1 and personnelType==2}">
								<h3 class='administrators'>管理员</h3>
							</c:if>
							<c:if test="${!(superEnterprise==1 and personnelType==2)}">
								<h3 class='administrators'>管理员<span class='addbox'>添加</span></h3>
							</c:if>
							<div class='tab'>
								<table>
									<thead>
										<tr>
											<th>姓名</th>
											<th>手机号</th>
											<th>性别</th>
											<th>生日</th>
											<th>职位</th>
											<th>阿訇</th>
										</tr>
									</thead>
									<tbody id="mlist">

									</tbody>
								</table>
							</div>
							<div class='equipment' >
								<a href="${basePath}/enterprise-${enterpriseId}.html?tab=3">
								<p class='conLeft'>全部<span id="totalCount"></span>员工</p>
								</a>
								<ul class="conRight allinp">
									<li><span>姓名：</span><input type="text" placeholder='不限' id="name" maxlength="60"></li>
									<li><span>性别：</span>
										<select name="" id="sex">
										<option value="">不限</option>
										<option value="男">男</option>
										<option value="女">女</option>
										</select>
									</li>
									<li><span>手机号：</span><input type="text" placeholder='不限' id="phone" maxlength="60"></li>
									<li><em class="require" onclick="personlist(1)">查询</em></li>
								</ul>
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
											<th>阿訇</th>
											<th>在职状态</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody id="slist">

									</tbody>
								</table>
							</div>
							  <%@include file="../include/en-user-page.jsp"%>
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
	   $(function(){
		   	$('.center>div').eq(0).show();
			$('.cenTab li').on('click',function(){
				var inde = $(this).index();
				$('.center>div').eq(inde).show().siblings('div').hide();
				$(this).addClass('bg').siblings().removeClass('bg');
			})
			$(".addbox").click(function(){
				$(".mengban , .box").show();
			})
			$(".point").click(function(){
				$(this).parent("ol").remove();
			});
			$(".btn span ,.mengban").click(function(){
				$(".mengban , .box").hide();
				$(".mengban , .Bombox").hide();

			})
			$(".lis").click(function(){
				$('.pageNumList').show();
			})
			$('.pageNumList').bind('click','a',function(){
				var inde = $(this).text();
				$('.pagenum').text(inde);
				$('.pageNumList').hide();
				
			})


	   });
       function lis(){
           $('.pageNumList').show();
       }
       function indef(){
           var inde = $(this).text();
           $('.pagenum').text(inde);
           $('.pageNumList').hide();
       }
	</script>
<script type="text/javascript">
	$(function () {

        <c:if test="${param.tab==1|| empty param.tab}">equipmentlist(1);</c:if>
        <c:if test="${param.tab==2}">applist();
		$("#main").hide();
		$("#applist").show();
		$("#p").hide();

		</c:if>
        <c:if test="${param.tab==3}">person();
        $("#main").hide();
        $("#applist").hide();
        $("#p").show();
		</c:if>
    });
    var enterpriseId = '${enterpriseId}';
    var apps = new Array();



	function applist(){
        var params={};
        params.enterpriseId = '${enterpriseId}';

        $.ajax({
            url:"${basePath}/enterprise-app-list.json",
            type:"post",
            data:params,
            success:function(json){
                if(json.result.code==0){
                    var html="";
                    for(var i=0;i<json.data.length;i++){
                        var item = json.data[i];
                        html+='<dl class="applydl">';
                        html+='<dt>';
                        html+='<img src="images/user.png" alt="">';
                        html+='</dt>';
                        html+='<dd>';
                        html+='<h3>'+item.name+'</h3>';
                        if(item.auth=='1'){
                            html+='<p style="color:green" onclick="deleteApp(\''+item.no+'\')">已授权</p>';
                        }else{
                            html+='<p><a href="javascipt:;" onclick="updateApp(\''+item.no+'\')">授权</a></p>';
                        }
                        html+='</dd>';
                        html+='</dl>';
                    }
                    $("#applist").html(html);

                }else {
                    alert(json.result.msg);
                }
            }
        });
	}


    function person(){
	    personlist(1);
	}

    function personlist(pageNo) {
        var params={};
        params.pageNo = pageNo;
        params.pageSize = pageSize;
        params.enterpriseId = '${enterpriseId}';
        params.sex = $("#sex").val();
        params.phone = $.trim($("#phone").val());
        params.name = $.trim($("#name").val());
        $.ajax({
            url:"${basePath}/enterprise-person-list.json",
            type:"post",
            data:params,
            success:function(json){

                if(json.result.code==0){
                    var html = "";
                    for(var i=0;i<json.data.totalList.length;i++){
                        var item = json.data.totalList[i];
                        html+='<tr>';
                        html+='<td>' +
                            <c:if test="${superEnterprise!=1}">
                            '<a href="${basePath}/person-edit-'+item.id+'.html">'+
							</c:if>
							item.name+
                            <c:if test="${superEnterprise!=1}">
                            '</a>' +
							</c:if>
							'</td>';
                        html+='<td>'+item.phoneNumber+'</td>';
                        html+='<td>'+item.sex+'</td>';
                        html+='<td>'+item.dateOfBirth+'</td>';
                        html+='<td>'+item.position+'</td>';
                        if(item.position=='屠宰人员'){
                            if(item.imamPhoto==""||item.imamPhoto==null){
                                html+='<td style="color:red;">' +
                                    <c:if test="${superEnterprise!=1}">
                                    '<a href="${basePath}/person-edit-'+item.id+'.html">' +
									'请上传阿訇证照</a>' +
									</c:if>
									'</td>';
                            }else{
                                html+='<td onclick="ah(\''+item.imamPhoto+'\')">阿訇</td>';
                            }
                        }else{
                            html+='<td></td>';
                        }
                        if(item.type==3){
                            html+='<td style="color: lightcoral">已离职</td>';
                            html+='<td><a href="javascript:;" onclick="lizhi('+item.id+',2)">设为在职</a></td>';
                        }else{
                            html+='<td style="color: lightseagreen">在职</td>';
                            html+='<td><a href="javascript:;" onclick="lizhi('+item.id+',3)">设为离职</a></td>';
                        }
                        html+='</tr>';
                    }

                    $("#slist").html(html);
                    topage(json.data);
                }
            }

        });
        manage('${enterpriseId}');
    }
	function ah(image){
        $(".Bombox").show();
        $(".mengban").show();
        $("#img").attr("src","${pic_prex}/"+image);
	}
    function updateApp(appString) {
		if(!confirm("确认授权该应用吗？")){
		    return;
		}
        var params={};
        params.enterpriseId = enterpriseId;
        params.appString = appString;

        $.ajax({
            url:"${basePath}/enterprise-app-auth-add.json",
            type:"post",
            data:params,
            success:function(json){
                if(json.result.code==0){
                    alert("授权成功");
                }else {
                    alert(json.result.msg);

                }
                applist();

            }
        });
    }

    function deleteApp(appString) {
        if(!confirm("确认取消该应用吗？")){
            return;
        }
        var params={};
        params.enterpriseId = enterpriseId;
        params.appString = appString;

        $.ajax({
            url:"${basePath}/enterprise-app-auth-delete.json",
            type:"post",
            data:params,
            success:function(json){
                if(json.result.code==0){
                    alert("取消授权成功");
                }else {
                    alert(json.result.msg);

                }
                applist();

            }
        });
    }
    function lizhi(id,type) {
	    if(type==3){
            if(!confirm("确认设置该用户为离职状态吗？")){
                return;
            }
		}else {
            if(!confirm("确认设置该用户为在职状态吗？")){
                return;
            }
		}

        var params={};
        params.id = id;
        params.type = type;

        $.ajax({
            url:"${basePath}/enterprise-update-personType.json",
            type:"post",
            data:params,
            success:function(json){
                if(json.result.code==0){
                    alert("操作成功！");
                }else {
                    alert(json.result.msg);

                }
                personlist(1);

            }
        });

    }

    var eqType="all";
    var appType="all";
    function equipmentType(obj) {
		eqType = $(obj).val();
    }
    function applicationType(obj) {
        appType = $(obj).val();
    }

    function equipmentlist(pageNo) {
        var params={};
        params.pageNo = pageNo;
        params.pageSize = eq_pageSize;
        params.type = $("#type").val();
        params.enterpriseId = enterpriseId;

        $.ajax({
            url:"${basePath}/enterprise-equipment-list.json",
            type:"post",
            data:params,
            success:function(json){

                if(json.result.code==0){
                    var html = "";
                    for(var i=0;i<json.data.totalList.length;i++){
                        var item = json.data.totalList[i];


                        html += '<tr>';
                        if(item.livestockId!=null&&item.livestockId!=''){
                            html += '<td><a href="${basePath}/livestock-'+item.livestockId+'.html">'+item.equipmentNumber+'</a></td>';

                        }else{
                            html += '<td>'+item.equipmentNumber+'</td>';
                        }
                        html += '<td>'+item.equipmentName+'</td>';
//                        html += '<td>'+item.appName+'</td>';
                        html += '<td>'+item.createTime+'</td>';
                        html += '<td>'+item.personnel+'</td>';
                        html += '<td>'+item.state+'</td>';
                        html += '</tr>';
                    }

                    $("#eqlist").html(html);
                    eq_topage(json.data);
                }
            }

        });
    }
	<c:if test="${!(superEnterprise==1 and personnelType==2)}">
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
                info = new Array();

                if(data.result.result.code=='0'){
                    var html = '';
                    for(var i=0;i<data.result.data.length;i++){
                        var item = data.result.data[i];
                        item.enterpriseId = '${enterpriseId}';
                        info.push(item);
                    }

                    infoImport();
                }else{
                    alert(data.result.msg);
                }
            }
        });
        $("#service").addClass("active");

    });
    function infoImport(){
        var params={};
        params.personnels = JSON.stringify(info);;

        $.ajax({
            url:"${basePath}/enterprise-import.json",
            type:"post",
            data:params,
            success:function(json){
                if(json.result.code==0){
                    person();
                }else if(json.result.code==2){
                    alert(json.result.msg);
                }else {
                    alert(json.result.msg+" "+json.data);
                }
            }
        });
    }
    function updateManager(enterpriseId) {
        var p = "";
        for(var i=0;i<array.length;i++){
            p+=array[i].id;
            if(i!=array.length-1){
                p+=','
            }
        }
        var params = {};
        params.enterpriseId = enterpriseId;
        params.personnels = p;
        $.ajax({
            url:"/enterprise-add-manager.json",
            type:"post",
            data:params,
            success:function(json){

                if(json.result.code==0){
                    alert("保存成功！");
                    person(1);
                }
            }

        });
    }
    </c:if>

</script>
	<script src="js/enterprise/person-manager.js"></script>
	<%@include file="../include/footer.jsp"%>

</body>
</html>