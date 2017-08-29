<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>免疫详情</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/cultivation.css">
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
				<p class='top'><span>养殖管理<em>></em></span><a href="${basePath}immune-list.html"><span>免疫记录<em>></em></span></a><span class="qiDetail">免疫详情</span></p>
				<div class='mainList'>
					<div class='divs'>
						<p class='conLeft' onclick="flush();">全部记录</p>
						<ul class="conRight">
							<li id="id1"></li>
							<li id="id2"></li>
							<li id="id3"></li>
							<li id="id4"></li>
							<%--<li><span>品种：</span><select name="" id="select5">--%>
							<%--<option value="">不限</option>--%>
							<%--<c:forEach items="${immuneList }" var="item">--%>
								<%--<option value="${ item.typeName }">${ item.typeName }</option>--%>
							<%--</c:forEach>--%>
							<%--</select></li>--%>
							<%--<li><em class="require" onclick="init(1);">查询</em></li>--%>
						</ul>
					</div>
					<div class="tab" id="centerlist">
					</div>
					<%@include file="../include/page.jsp"%>
				</div>
			</div>
		</div>
	</div>
	<script src="js/jquery-1.8.0.min.js"></script>
	<script src="js/common.js"></script>
	<script src="js/laydate/laydate.js"></script>
	<script type="text/javascript">
    var type = "";
    var createTime = "";
    var enterpriseName = "";
    var immunePersonnelName = "";
    var drugName = "";
    var immuneWay = "";
    function flush(){
        location.reload();
    }
    function updateTy(a){
        type = a;
    }
    function baseData(b){
    	var sex="公";
    	if(b==0){
    		sex="母";
    	}
    	return sex;
    }
    $(function(){
       init(1);
    });
    function init(pageNo) {
        var params={};
        params.pageNo = pageNo;
        params.pageSize = pageSize;
        params.type = type;
        params.createTime = createTime;
//        params.varietiesId = $("#select5").get(0).value;
        params.varietiesId = "";
        params.documentNumber = "${documentNumber}";
        $.ajax({
            url:"${basePath}/immune-info.json",
            type:"post",
            data:params,
            success:function(json){
                if(json.result.code==0){
                    var html = "<tbody>";
                    for(var i=0;i<json.data.totalList.length;i++){
                        var item = json.data.totalList[i];
                        html += '<tr><td><a href="${basePath}/livestock-'+item.livestockId+'.html">'+item.equipmentNumber+'</a></td><td>'+item.typeName+'</td><td>'+item.sex+'</td></tr>';
						enterpriseName = item.enterpriseName;
                        immunePersonnelName = item.immunePersonnelName;
                        drugName = item.drugName;
                        immuneWay = item.immuneWay;
                    }
                    html = '<table><thead><tr><th>耳标编号</th><th>品种</th><th>性别</th></tr></thead>' + html + '</tbody></table>';
                    $("#centerlist").html(html);
					$("#id1").html('<span >企业：'+enterpriseName+'</span>')
					$("#id2").html('<span >免疫人员：'+immunePersonnelName+'</span>')
					$("#id3").html('<span >免疫药品：'+drugName+'</span>')
					$("#id4").html('<span >免疫方法：'+immuneWay+'</span>')
                    topage(json.data);
                }
            }
        });
    }
	</script>
		<%@include file="../include/footer.jsp"%>

</body>
</html>