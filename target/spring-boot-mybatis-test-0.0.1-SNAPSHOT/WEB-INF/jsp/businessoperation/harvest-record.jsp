<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>收货记录</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/cultivation.css">
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
			<!-- 右侧 -->
			<div class="mainRight">
				<p class='top'><span>商户操作管理<em>></em></span><span class="qiDetail">收货记录</span></p>
				<div class='mainList'>
					<div class='divs'>
						<p class='conLeft' onclick="flush();">全部履历</p>
						<ul class="conRight">
							<shiro:hasRole name="admin">

							<li><span>企业：</span><select name="" id="select1">
								<option value="">不限</option>
								<c:forEach items="${list}" var="item">
									<option value="${item.id}">${item.enterpriseName}</option>
								</c:forEach>
							</select></li>
							</shiro:hasRole>
							<li><span>时间：</span><input type="text" placeholder='请选择' id="input2" onclick="laydate()"><em>至</em><input type="text" placeholder='请选择' id="input3" onclick="laydate()"></li>
							<li><em class="require" onclick="init(1);">查询</em></li>
						</ul>
					</div>
					<div class="tab">
						<table>
							<thead>
								<tr>
									<th>收货时间</th>
									<th>车辆信息</th>
									<th>联系电话</th>
									<th>企业</th>
									<th>签收人员</th>
								</tr>
							</thead>
							<tbody id="cmerchantlist">
							</tbody>
						</table>
					</div>
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
        function flush(){
            location.reload();
        }
        function init(pageNo) {
            var params={};
            params.pageNo = pageNo;
            params.pageSize = pageSize;
            params.id = "";
            <shiro:hasRole name="admin">
            params.enterpriseId = $("#select1").get(0).value;
			</shiro:hasRole>
            <shiro:lacksRole name="admin">
            params.enterpriseId = '${enterpriseId}';
			</shiro:lacksRole>
            params.startTime = $("#input2").get(0).value;
            params.endTime = $("#input3").get(0).value;
            $.ajax({
                url:"${basePath}/harvest-record.json",
                type:"post",
                data:params,
                success:function(json){

                    if(json.result.code==0){
                        var html = "";
                        for(var i=0;i<json.data.totalList.length;i++){
                            var item = json.data.totalList[i];
                            html += '<tr>';
//                            html += '<td>'+item.id+'</td>';
                            html += '<td>'+item.receiptTime+'</td>';
                            html += '<td>'+item.carNum+' '+item.carName+'</td>';
                            html += '<td>'+item.phoneNum+'</td>';
                            html += '<td><a href="${basePath}/enterprise-'+item.enterpriseId+'.html">'+item.enterpriseName+'</a></td>';
                            html += '<td><a href="${basePath}/person-'+item.consigneeId+'.html">'+item.personnelName+'</td></td>';
                            html += '</tr>';
                        }

                        $("#cmerchantlist").html(html);
                        topage(json.data);
                    }
                }

            });
        }
	</script>
	<%@include file="../include/footer.jsp"%>

</body>
</html>