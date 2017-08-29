<%@ page language="java" pageEncoding="UTF-8"%>
<!-- 添加弹框 -->
<div class="Bombox12" id="newpwd">
    <p style="font-size:20px">修改密码</p>
    <p><span>验证码：</span><input type="text" placeholder='输入短信验证码' id="code" maxlength="64"><em id="sendcode" onclick="getCode()">获取验证码</em></p>
<%--<p><span>旧密码：</span><input type="text" placeholder='输入旧密码' id="name" maxlength="64"></p>--%>

    <p><span>新密码：</span><input type="password" placeholder='输入新密码' id="password" maxlength="64"></p>
    <p class='baocun12' ><em style="width: 100px;" onclick="savePwd()">保存</em><em style="width: 100px; margin-left: 50px;background:#26B99A" onclick="hidePwd()">取消</em></p>

</div>
<!-- 退出 -->
<script>
    $("#e${left_key}").addClass("shadow");
    $("#m${left_key}").show();
    var wait=60;

    function getCode() {
        var params={};
        $.ajax({
            url:"${basePath}/getCode.json",
            type:"post",
            data:params,
            success:function(json){
                if(json.result.code==0){
                    alert("发送成功！");
                    wait=60;
                    time();
                }else{
                    alert("发送失败！");
                }
            }
        });
    }
    function time() {
        if (wait == 0) {
            $("#sendcode").attr("onclick","getCode()");
            $("#sendcode").attr("style","background:#337ab7;");
            $("#sendcode").text("获取短信验证码");
            wait = 60;
        } else {

            $("#sendcode").removeAttr("onclick");
            $("#sendcode").attr("style","background:gray;");
            $("#sendcode").text("正在发送(" + wait + "秒)");
            wait--;
            setTimeout(function() {
                    time()
                },
                1000)
        }
    }
    function savePwd() {
        var params={};
        params.code=$.trim($("#code").val());
        params.password=$.trim($("#password").val());
        $.ajax({
            url:"${basePath}/savePwd.json",
            type:"post",
            data:params,
            success:function(json){
                if(json.result.code==0){
                    alert("修改密码成功！");
                }else{
                    alert(json.result.msg);
                }
            }
        });
    }
    function newPwd() {
        $("#newpwd, .mengban").show();

    }
    function hidePwd() {
        $("#newpwd, .mengban").hide();
    }
</script>