<%@ page language="java" pageEncoding="UTF-8"%>
<ul class="indexList none">
    <li>
        <img src="images/pic1.png" alt="" class="pic1">
        <img src="images/biaoti.png" alt="" class="pic2">
        <img src="images/pic3.png" alt="" class="pic3">
        <img src="images/pic4.png" alt="" class="pic4">
    </li>
    <li><span><em>*</em>企业名称：</span><input type="text" placeholder="企业名称" id="tz-name" maxlength="64"></li>
    <li><span><em>*</em>logo：</span><div class="upload">
        <input type="file" name="files" class="file" id="tz-logo">
        <input type="hidden"  id="tz-logo-val">
        <img src="images/upload.png" id="tz-logo-up" width="112px" alt="" >
    </div></li>
    <li><span><em>*</em>营业执照号：</span><input type="text" placeholder="输入营业执照编号" id="tz-license-number" maxlength="64"></li>
    <li><span><em>*</em>营业执照扫描件：</span><div class="upload">
        <input type="file" class="file" name="files" id="tz-business-license">
        <input type="hidden" id="tz-business-license-val">
        <img src="images/upload.png" width="112px" id="tz-business-license-up" alt="" >
    </div></li>
    <li>
        <span><em>*</em>是否清真企业：</span>
        <p class="radio">
            <input type="radio" id="ra3" name="tz-is-muslim" value="是">
            <label for="ra3">是</label>
        </p>
        <p class="radio">
            <input type="radio" id="ra4" name="tz-is-muslim" checked="checked" value="否">
            <label for="ra4">否</label>
        </p>
    </li>
    <li><span><em>*</em>清真证照描件：</span><div class="upload">
        <input type="file" class="file" name="files"  id="tz-muslim-photo">
        <input type="hidden" id="tz-muslim-photo-val">
        <img src="images/upload.png" alt="" width="112px"  id="tz-muslim-photo-up">
    </div></li>
    <li><span><em>*</em>企业负责人：</span><input type="text" placeholder="输入企业负责人姓名"  id="tz-principal" maxlength="64"></li>
    <li><span>联系电话：</span><input type="text" id="tz-telephone" placeholder="输入企业负责人电话" maxlength="64"></li>
    <li><span>传真：</span><input type="text" id="tz-fax" placeholder="输入传真" maxlength="64"></li>
    <li><span>电子邮箱：</span><input type="text" id="tz-email" placeholder="输入企业电子邮箱" maxlength="64"></li>
    <%@include file="create-tuzai-address.jsp"%>

    <li>
        <a href="javascript:;" onclick="saveTuzai()"><span class="save">保存并下一步</span></a>
    </li>
</ul>
<script type="text/javascript">
    function saveTuzai() {
        var params={};
        params.enterpriseName = $("#tz-name").val();
        params.enterpriseType = 2;
        params.logo = $("#tz-logo-val").val();
        params.licenseNumber = $("#tz-license-number").val();
        params.businessLicense = $("#tz-business-license-val").val();
        params.isMuslim = $("input[name='tz-is-muslim']:checked").val();
        params.muslimPhoto = $("#tz-muslim-photo-val").val();
        params.principalName = $("#tz-principal").val();
        params.telephone = $("#tz-telephone").val();
        params.fax = $("#tz-fax").val();
        params.email = $("#tz-email").val();
        params.province = $("#tz-province option:selected").text();
        params.city = $("#tz-city option:selected").text();
        params.district = $("#tz-district option:selected").text();
        params.township = $("#tz-township").val();
        params.village = $("#tz-village").val();
        params.streetAddresses = $("#tz-streetAddresses").val();
        if(params.enterpriseName==""){
            alert("请输入企业名！");
            return;
        }
        if(params.licenseNumber==""){
            alert("请输入营业执照编号！");
            return;
        }
        if(params.licenseNumber!=""){
            if(isNaN(params.licenseNumber)||params.licenseNumber.length!=15){
                alert("营业执照编码为15位数字请确认后重新填写！");
                return;
            }
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
        $('#tz-logo').fileupload({
            autoUpload: true,//是否自动上传
            url: url,//上传地址
            dataType: 'json',
            done: function (e, data) {//设置文件上传完毕事件的回调函数
                if(data.result.result.code=='0'){
                    $("#tz-logo-up").attr("src",data.result.data["url"]);
                    $("#tz-logo-val").val(data.result.data["key"])
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
        $('#tz-business-license').fileupload({
            autoUpload: true,//是否自动上传
            url: url,//上传地址
            dataType: 'json',
            done: function (e, data) {//设置文件上传完毕事件的回调函数
                if(data.result.result.code=='0'){
                    $("#tz-business-license-up").attr("src",data.result.data["url"]);
                    $("#tz-business-license-val").val(data.result.data["key"])
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
        $('#tz-muslim-photo').fileupload({
            autoUpload: true,//是否自动上传
            url: url,//上传地址
            dataType: 'json',
            done: function (e, data) {//设置文件上传完毕事件的回调函数
                if(data.result.result.code=='0'){
                    $("#tz-muslim-photo-up").attr("src",data.result.data["url"]);
                    $("#tz-muslim-photo-val").val(data.result.data["key"])
                }else{
                    alert(data.result.result.msg);
                }
            }
        });
        $("#service").addClass("active");
    });

</script>