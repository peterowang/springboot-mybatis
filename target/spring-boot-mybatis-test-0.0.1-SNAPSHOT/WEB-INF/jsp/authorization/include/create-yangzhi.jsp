<%@ page language="java" pageEncoding="UTF-8"%>
<ul class="indexList none">
    <li>
        <img src="images/pic1.png" alt="" class="pic1">
        <img src="images/biaoti.png" alt="" class="pic2">
        <img src="images/pic3.png" alt="" class="pic3">
        <img src="images/pic4.png" alt="" class="pic4">
    </li>
    <li><span><em>*</em>企业名称：</span><input type="text" placeholder="企业名称" id="yz-name" maxlength="64"></li>
    <li><span><em>*</em>logo：</span><div class="upload">
        <input type="file" name="files" class="file" id="yz-logo">
        <input type="hidden"  id="yz-logo-val">
        <img src="images/upload.png" id="yz-logo-up" width="112px" alt="" >
    </div></li>
    <li><span>营业执照号：</span><input type="text" placeholder="输入营业执照编号" id="yz-license-number" maxlength="64"></li>
    <li><span>营业执照扫描件：</span><div class="upload">
        <input type="file" name="files" class="file" id="yz-business-license">
        <input type="hidden" id="yz-business-license-val">
        <img src="images/upload.png" width="112px" id="yz-business-license-up" alt="" >
    </div></li>

    <li><span><em>*</em>企业负责人：</span><input type="text" placeholder="输入企业负责人姓名"  id="yz-principal" maxlength="64"></li>
    <li><span>联系电话：</span><input type="text" id="yz-telephone" placeholder="输入企业负责人电话" maxlength="64"></li>
    <li><span>传真：</span><input type="text" id="yz-fax" placeholder="输入传真" maxlength="64"></li>
    <li><span>电子邮箱：</span><input type="text" id="yz-email" placeholder="输入企业电子邮箱" maxlength="64"></li>
    <%@include file="create-yangzhi-address.jsp"%>

    <li><span>养殖规模：</span><input type="text" id="yz-farming-scale" placeholder="" maxlength="64"></li>
    <li><span>标识代码：</span><input type="text" id="yz-identification-code" placeholder="" maxlength="64"></li>
    <li><span>行政区域代码：</span><input type="text" id="yz-administrative-areas" placeholder="" maxlength="64"></li>
    <li><span>视频监控设备号：</span><input type="text" id="yz-monitor-number" placeholder="" maxlength="64"></li>
    <li>
        <a href="javascript:;" onclick="saveYangzhi()"><span class="save">保存并下一步</span></a>
    </li>
</ul>
<script type="text/javascript">
    function saveYangzhi() {
        var params={};
        params.enterpriseName = $("#yz-name").val();
        params.enterpriseType = 1;
        params.licenseNumber = $("#yz-license-number").val();
        params.businessLicense = $("#yz-business-license-val").val();
        params.isMuslim = $("input[name='yz-is-muslim']:checked").val();
        params.muslimPhoto = $("#yz-muslim-photo-val").val();
        params.principalName = $("#yz-principal").val();
        params.telephone = $("#yz-telephone").val();
        params.fax = $("#yz-fax").val();
        params.email = $("#yz-email").val();
        params.province = $("#yz-province option:selected").text();
        params.city = $("#yz-city option:selected").text();
        params.district = $("#yz-district option:selected").text();
        params.township = $("#yz-township").val();
        params.village = $("#yz-village").val();
        params.streetAddresses = $("#yz-streetAddresses").val();

        params.farmingScale = $("#yz-farming-scale").val();
        params.identificationCode = $("#yz-identification-code").val();
        params.administrativeAreas = $("#yz-administrative-areas").val();
        params.monitorNumber = $("#yz-monitor-number").val();
        params.logo = $("#yz-logo-val").val();

        if(params.enterpriseName==""){
            alert("请输入企业名！");
            return;
        }
        if(params.logo==""){
            alert("请上传企业logo！");
            return;
        }

        if(params.licenseNumber!=""){
            if(isNaN(params.licenseNumber)||params.licenseNumber.length!=15){
                alert("营业执照编码为15位数字请确认后重新填写！");
                return;
            }
        }


        if(params.principalName==""){
            alert("请输入企业负责人姓名！");
            return;
        }
        if(params.telephone!=""){
            var myreg = /^((1[0-9]{2})+\d{8})$/;
            if(!myreg.test(params.telephone)) {
                alert('请输入有效的手机号码！');
                return false;
            }
        }
        if(params.fax!=""){
            var myreg=/\d{3,4}-\d{7,8}$/;
            if(!myreg.test(params.fax)) {
                alert('请输入有效的传真！');
                return false;
            }
        }
        if(params.email!=""){
            var myreg=/[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?$/;
            if(!myreg.test(params.email)) {
                alert('请输入有效的电子邮箱！');
                return false;
            }
        }

        if(params.province==""||params.city==""||params.district==""||params.province=="请选择"||params.city=="请选择"||params.district=="请选择"){
            alert("请选择企业地址！");
            return;
        }
        $.ajax({
            url:"${basePath}/enterprise-create.json",
            type:"post",
            data:params,
            success:function(json){
                if(json.result.code==0){
                    window.location.href="${basePath}/enterprise-app-auth-"+json.data+".html";
                }else {
                    alert(json.result.msg);
                }
            }
        });
    }
</script>

<script type="text/javascript">
    $(function(){
        //文件上传地址
        var url = '${basePath}/img-upload.json';
        //初始化，主要是设置上传参数，以及事件处理方法(回调函数)
        $('#yz-logo').fileupload({
            autoUpload: true,//是否自动上传
            url: url,//上传地址
            dataType: 'json',
            done: function (e, data) {//设置文件上传完毕事件的回调函数
                if(data.result.result.code=='0'){
                    $("#yz-logo-up").attr("src",data.result.data["url"]);
                    $("#yz-logo-val").val(data.result.data["key"])
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
        $('#yz-business-license').fileupload({
            autoUpload: true,//是否自动上传
            url: url,//上传地址
            dataType: 'json',
            done: function (e, data) {//设置文件上传完毕事件的回调函数
                if(data.result.result.code=='0'){
                    $("#yz-business-license-up").attr("src",data.result.data["url"]);
                    $("#yz-business-license-val").val(data.result.data["key"])
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
        $('#yz-muslim-photo').fileupload({
            autoUpload: true,//是否自动上传
            url: url,//上传地址
            dataType: 'json',
            done: function (e, data) {//设置文件上传完毕事件的回调函数
                if(data.result.result.code=='0'){
                    $("#yz-muslim-photo-up").attr("src",data.result.data["url"]);
                    $("#yz-muslim-photo-val").val(data.result.data["key"])
                }else{
                    alert(data.result.result.msg);
                }
            }
        });
        $("#service").addClass("active");
    });

</script>