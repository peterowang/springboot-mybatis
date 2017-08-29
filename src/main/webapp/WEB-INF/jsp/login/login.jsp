<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="../include/tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/sign.css">
	<script src="js/jquery-1.8.0.min.js"></script>

	<script>
        //检查用户名和密码是否为空
        function check(){
            var username= document.getElementById("username");
            if(username.value.trim()==""){//没有输入用户名是显示提示
                //获取所有子节点
                var findNodes = document.getElementById("name").children;
                if(findNodes.length==0){//只添加一次span
                    var appdom= document.createElement("span");
                    appdom.innerHTML="*用户名不能为空";
                    appdom.style.color="red";
                    document.getElementById("name").appendChild(appdom);
                }
                return false;
            }else{//输入了内容后清除节点内容
                var findNodes =document.getElementById("name").children;
                if(findNodes.length>0){
                    document.getElementById("name").removeChild(findNodes[0]);
                }
            }
            var userpwd = document.getElementById("userpwd");
            if(userpwd.value.trim()==""){
                var findNodes2 = document.getElementById("pwd").children;
                if(findNodes2.length==0){
                    var appdom2 = document.createElement("span");
                    appdom2.innerHTML="*密码不能为空";
                    appdom2.style.color="red";
                    document.getElementById("pwd").appendChild(appdom2);
                }
                return false;
            }else{
                var findNodes2 = document.getElementById("pwd").children;
                if(findNodes2.length>0){
                    document.getElementById("pwd").removeChild(findNodes2[0]);
                }
            }
            var params={};
            params.username = $("#username").val();
            params.userpwd = $("#userpwd").val();
            $.ajax({
                url:"${basePath}/logon.json",
                type:"post",
                data:params,
                success:function(json){

                    if(json.result.code==0){
                        alert("登录成功！");
                        if(json.data=="admin"){
                            window.location.href = "${basePath}/index.html";
                        }else{
                            window.location.href = "${basePath}/farm-manage.html";
                        }
                    }else{
                        alert(json.result.msg);
                    }

                }
            });
        }
	</script>
</head>
<body>
<div class="wrap">
	<p class="title"><img src="images/logo6.png" width="50px" alt=""><em>伊牧云追溯系统管理平台</em></p>
	<ul class="signList">
		<li class='lis'>用户名</li>
		<li class='inps'>
			<input type="text" name="username" id="username"><span><img src="images/name.png" alt=""></span>
			<em id="name"></em>
		</li>
		<li class='lis'>密码</li>
		<li class='inps'>
			<input type="password" name="userpwd" id="userpwd"><span><img src="images/pass.png" alt=""></span>
			<em id="pwd"></em>
		</li>
		<!-- <li class='inps'><input type="submit" value="登录" onclick="return check();" class='sign'></li> -->
		<li class='inps'><em class='sign' onclick="return check();">登录</em></li>
	</ul>
</div>
</body>
</html>