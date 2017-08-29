<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>导入完成</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/device.css">
	<link rel="shortcut icon" href="images/logo.png" type="image/x-icon"/>
</head>
<body>
<div class="mengban"></div>
<!-- 退出 -->
<%@include file="../include/header.jsp"%>
<div class="mengban"></div>

<!-- 添加弹框 -->
<div class="box">
	<div class="hed">
		<img src="images/suc.png" alt="">
		<span>添加成功！请设置管理员</span>
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
<div class="wrap">
	<!-- 头部 -->
	<%@include file="../include/nav.jsp"%>

	<!-- 内容 -->
	<div class="maincon">
		<!-- 左侧 -->
		<div class="mainLeft">
			<%@include file="../include/left.jsp"%>
		</div>
		<!-- 右侧 -->
		<div class="mainRight">
			<p class='top'><span>企业列表<em>></em></span><span class="qiDetail">企业详情</span></p>
			<div class='center'>
				<!-- 人员架构 -->
				<div class='structure'>
					<div class='centerTop'>
						<ul class="indexList indexList2">
							<li>
								<img src="images/pic5.png" alt="" class="pic1">
								<img src="images/biaoti.png" alt="" class="pic2 pic2s">
								<img src="images/pic3.png" alt="" class="pic3">
								<img src="images/pic8.png" alt="" class="pic4">
							</li>
						</ul>
						<h3 class='administrators'>管理员<span class='addbox'>添加</span></h3>
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
							<p class='conLeft'>全部<span id="totalCount"></span>员工</p>
							<%--<span class='addbox'>添加</span>--%>
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
								</tr>
								</thead>
								<tbody id="slist">
								</tbody>
							</table>
						</div>
						<%@include file="../include/en-complete-page.jsp"%>

					</div>
				</div>
			</div>
			<div class="next">
				<a href="${basePath}/enterprise-import-${enterpriseId}.html" ><span>上一步</span></a>
				<a href="${basePath}/enterprise-${enterpriseId}.html" ><span>完成</span></a>
			</div>
		</div>
	</div>
</div>
<script src="js/jquery-1.8.0.min.js"></script>
<script src="js/common.js"></script>
<script>
    $(function(){
        $('.center>div').eq(0).show();
        $('.cenTab li').on('click',function(){
            var inde = $(this).index();
            $('.center>div').eq(inde).show().siblings('div').hide();
            $(this).addClass('bg').siblings().removeClass('bg');
        })
        $(".addbox ,.addman").click(function(){
            $(".mengban , .box").show();
        })
//        $(".point").click(function(){
//            $(this).parent("ol").remove();
//        });
        $(".btn span ,.mengban").click(function(){
            $(".mengban , .box").hide();
        })
        $(".lis").click(function(){
            $('.pageNumList').show();
        })
        $('.pageNumList').on('click','a',function(){
            var inde = $(this).text();
            $('.pagenum').text(inde);
            $('.pageNumList').hide();

        })

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
    });


    function init(pageNo) {
        var params={};
        params.pageNo = pageNo;
        params.pageSize = pageSize;
        params.enterpriseId = '${enterpriseId}';
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
                        html+='<td>'+item.name+'</td>';
                        html+='<td>'+item.phoneNumber+'</td>';
                        html+='<td>'+item.sex+'</td>';
                        html+='<td>'+item.dateOfBirth+'</td>';
                        html+='<td>'+item.position+'</td>';
                        if(item.position=='屠宰人员'){
                            if(item.imamPhoto==""||item.imamPhoto==null){
                                html+='<td style="color:red;">请上传阿訇证照</td>';
                            }else{
                                html+='<td>阿訇</td>';
                            }
                        }else{
                            html+='<td></td>';
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
                    init(1);
                }
            }

        });
    }

</script>
<script src="js/enterprise/person-manager.js"></script>
<%@include file="../include/footer.jsp"%>

</body>
</html>