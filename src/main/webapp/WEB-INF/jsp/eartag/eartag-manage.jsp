<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>耳标管理</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/device.css">
	<link rel="shortcut icon" href="images/logo.png" type="image/x-icon"/>
</head>
<body>
	<div class="mengban"></div>
	<!-- 添加库存 -->
	<div class="repertory">
		<p class="addtitle">添加耳标</p>
		<ul class="addlist addlist2">
			<li>
				<span>起始编号：</span>
				<input type="text" id="start" onblur="toCount()" maxlength="10">
			</li>
			<li>
				<span>末尾编号：</span>
				<input type="text" id="end" onblur="toCount()" onchange="toCount()"  maxlength="10">
			</li>
			<li>
				<span>数量：</span>
				<span id="count" style="text-align: left;"></span>
			</li>
		</ul>
		<div class="addbtn">
			<span>取消</span>
			<span class="affirm" onclick="addinventory()">确认</span>
		</div>
	</div>
	<!-- 添加授权 -->
	<div class="equipmentAlet">
		<p class="addtitle">授权</p>
		<ul class="addlist">
			<li>
				<span>企业：</span>
				<select id="enterprise" onchange="plist(this.value)">
					<c:forEach items="${list}" var="item">
						<option value="${item.id}">${item.enterpriseName}</option>
					</c:forEach>
				</select>
				<div class="yingy" id="app">
				</div>
			</li>
			<li>
				<span>认领人：</span>
				<select id="person">

				</select>
			</li>

			<li>
				<span>数量：</span>
				<span id="auth_count" style="text-align: left;"></span>
			</li>
		</ul>
		<div class="addbtn">
			<span>取消</span>
			<span class="affirm" onclick="authorization()">确认</span>
		</div>
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
				<p class='top'><span class="qiDetail">耳标管理</span><var class="inventory">添加库存</var></p>
				<dl class='enterprise'>
					<dt><img src="images/user.png" alt=""></dt>
					<dd>
						<h4>设备名称：${equipment.equipmentName}</h4>
						<p class="brand">品牌：${equipment.brand}</p>
						<p class="brand">型号：${equipment.model}</p>
					</dd>
					<div class='modify'><a href="javascript:;" class="sq">授权</a></div>
				</dl>
				<div class="manage manage2">
					<div class="earList">
						<span>总库存</span>
						<em id="inventory-all"></em>
					</div>
					<div class="earList">
						<span>已授权</span>
						<em id="inventory-auth"></em>
					</div>
					<div class="earList">
						<span>追溯中</span>
						<em id="inventory-trace"></em>
					</div>
					<div class="earList earList1">
						<span>剩余库存</span>
						<em id="inventory-remain"></em>
					</div>
				</div>
				<div class="main main2">
					<div class='divs'>
						<a href="javascript:;" onclick="location.reload()"><p class='conLeft'>全部设备</p></a>
						<ul class="conRight">

							<li><span>企业：</span><select name="" id="senterprise">
								<option value="">不限</option>

								<c:forEach items="${list}" var="item">
									<option value="${item.id}">${item.enterpriseName}</option>
								</c:forEach>

							</select></li>
							<li><span>状态：</span><select name="" id="state">
								<option value="">不限</option>
								<option value="-1">未授权</option>
								<option value="1">授权</option>
								<option value="2">追溯</option>
								<option value="0">作废</option>

							</select></li>
							<li><span>耳标编码：</span><input type="text" placeholder='不限' id="number" maxlength="60"></li>
							<li><em class="require" onclick="init(0)">查询</em></li>
						</ul>
					</div>
					<div class='tab'>
						<table>
							<thead>
								<tr>
									<th></th>
									<th>设备编号</th>
									<th>授权企业</th>
									<th>授权时间</th>
									<th>认领人</th>
									<th>状态</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody id="list">


							</tbody>
						</table>
					</div>
					<!-- 翻页 -->
            		<%@include file="../include/equipment-page.jsp"%>
				</div>
			</div>
		</div>
	</div>
	<script src="js/jquery-1.8.0.min.js"></script>
	<script src="js/common.js"></script>
	<script>
	    // 添加授权
		$(".addman ,.sq").click(function(){
		    var i=0;
            $("input[name='eq_id']:checked").each(function(){
               i+=1;
            });
            $("#auth_count").text(i);
			$(".mengban ,.equipmentAlet ").show();
		})
		$(".addbtn span").click(function(){
			$(".mengban ,.equipmentAlet ,.repertory").hide();
		})
		// 添加库存
		$(".inventory").click(function(){
			$(".mengban,.repertory").show();
		})
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
    $(function(){
        init(1);
        inventory();
        plist('${enterpriseId}');
        <%--applist('${enterpriseId}')--%>
    });
    function init(pageNo) {
        var params={};
        params.pageNo = pageNo;
        params.pageSize = pageSize;
        params.enterpriseId = $("#senterprise").val();
        params.state = $("#state").val();
        params.number = $("#number").val();
        $.ajax({
            url:"${basePath}/eartag-list.json",
            type:"post",
            data:params,
            success:function(json){

                if(json.result.code==0){
                    var html = "";
                    for(var i=0;i<json.data.totalList.length;i++){
                        var item = json.data.totalList[i];
                        html += '<tr>';
                        if(item.state!='未授权'){
                            html += '<td></td>';
                        }else{
                            html += '<td><input type="checkbox" name="eq_id" value="'+item.id+'"></td>';
                        }
                        html += '<td>'+item.equipmentNumber+'</td>';
                        html += '<td>'+item.enterpriseName+'</td>';
                        html += '<td>'+item.createTime+'</td>';
                        html += '<td>'+item.personnel+'</td>';
                        html += '<td>'+item.state+'</td>';
                        if(item.state!='未授权'){
                            html += '<td></td>';
                        }else {
                            html += '<td><a href="javascript:;" onclick="zf(\''+item.id+'\')">作废</a></tr>';
                        }
                    }

                    $("#list").html(html);
                    topage(json.data);
                }
            }

        });
    }
    function zf(id){
        if(!confirm("是否确认作废该耳标？")){
            return;
		}
		var params={};
        params.id=id;
        $.ajax({
            url:"${basePath}/eartag-zuofei.json",
            type:"post",
            data:params,
            success:function(json){

                if(json.result.code==0){
                    alert("耳标作废成功！");
                    init(1);
                }else{
                    alert(json.result.msg);
                }
            }

        });
	}

    function inventory() {
        $.ajax({
            url:"${basePath}/eartag-state.json",
            type:"post",
            data:{},
            success:function(json){

                if(json.result.code==0){
					var item = json.data;
                    $("#inventory-all").html(item['total']);
                    $("#inventory-auth").html(item['authCount']);
                    $("#inventory-trace").html(item['zsCount']);
                    $("#inventory-remain").html(item['noCount']);
                }
            }

        });
    }
    function toCount() {
		var start = $("#start").val();
		var end = $("#end").val();
		if(start==""||end==""){
            $("#count").text("");
            return;
        }
        var c = end-start;
		if(c<0){
            $("#count").text("");
            return;
		}
		$("#count").text(c+1);
    }
    function addinventory() {
        var params = {};
        params.start = $("#start").val();
        params.end = $("#end").val();
        if(params.start==""||params.end==""){
            alert("请输入耳标编号！");
            return;
		}
        var c = params.end-params.start;
        if(c<0){
            alert("末尾编号必须大于等于起始编号！");
            return;
        }
        $.ajax({
            url:"${basePath}/eartag-add-inventory.json",
            type:"post",
            data:params,
            success:function(json){

                if(json.result.code==0){
                   	alert("添加库存成功");
                    init(1);
                    inventory();
                }else{
                    alert(json.result.msg);
                }
            }

        });
    }

    function plist(enterpriseId) {
        var params = {};
        params.enterpriseId = enterpriseId;
        $.ajax({
            url:"${basePath}/person-list.json",
            type:"post",
            data:params,
            success:function(json){

                if(json.result.code==0){
                    var html = '';
                    var data = json.data;
                    for(var i=0;i<data.length;i++){
                        html +='<option value="'+data[i].id+'" >'+data[i].name+'</option>';
                    }
                    $("#person").html(html);
                }
            }

        });
//        applist(enterpriseId);
    }

    function applist(enterpriseId) {
        var params = {};
        params.enterpriseId = enterpriseId;
        $.ajax({
            url:"${basePath}/application-list.json",
            type:"post",
            data:params,
            success:function(json){

                if(json.result.code==0){
                    var html = '';
                    var data = json.data;
                    var temp = 0;
                    for(var i=0;i<data.length;i++){
						if(i%2==0){
                            html +='<p>';
                            temp = i+2;
                        }
                        html +='<a href="jascript:;">';
                        html +='<input type="radio" class="check" name="app" value="'+data[i].id+'"><var>'+data[i].appName+'</var>';
                        html +='</a>';
//                        html +='<a href="jascript:;">';
//                        html +='<input type="checkbox" class="check"><var>耳标</var>';
//                        html +='</a>';
                        if((i==temp)||i==data.length-1){
                            html +='</p>';
                        }
                    }
                    $("#app").html(html);
                }
            }

        });
    }
    function authorization() {
		var apps = $("input[name='app']:checked").val();
		var eqIds = "";
        $("input[name='eq_id']:checked").each(function(){
            eqIds+=$(this).val();
            eqIds+=',';
        });
        var params = {};
        params.enterpriseId = $("#enterprise").val();
        params.personnelId = $("#person").val();
        params.eqIds = eqIds;
        params.apps = apps;
        if(params.eqIds==""){
            alert("请选择设备后授权！");
            return;
		}
//        if(apps==undefined||apps==''){
//            alert("请选择授权的应用");
//            return;
//		}
        $.ajax({
            url:"${basePath}/eartag-auth.json",
            type:"post",
            data:params,
            success:function(json){

                if(json.result.code==0){
                    alert("授权成功");
                    init(1);
                    inventory();
                }else{
                    alert(json.result.msg);
                }
            }

        });
    }
</script>
	<%@include file="../include/footer.jsp"%>

</body>
</html>