<%@ page language="java" pageEncoding="UTF-8"%>
<li><span><em>*</em>注册地址：</span>
    <p>
        <select name="" id="yz-province" class="select select2" onchange="yz_addr(this.value,'3')">
            <option value="0">请选择</option>

            <c:forEach items="${list}" var="item">
                <option value="${item.id}" >${item.name}</option>

            </c:forEach>
        </select>
        省
    </p>
    <p>
        <select name="" id="yz-city" class="select" onchange="yz_addr(this.value,'2')">
            <option value="">请选择</option>
        </select>
        市
    </p>
    <p>
        <select name="" id="yz-district" class="select" onchange="yz_addr(this.value,'1')">
            <option value="">请选择</option>
        </select>
        区/县
    </p>
    <p class="sel">
        <input type="text" id="yz-township" placeholder="乡" maxlength="64">
    </p>
    <p>
        <input type="text" id="yz-village" placeholder="村" maxlength="64">
    </p>
    <p class="p3"><input type="text" id="yz-streetAddresses" placeholder="街道/号/层" maxlength="64"></p>
</li>
<script type="text/javascript">
    function yz_addr(id,type){
        var params={};
        params.id = id;
//TODO 增加条件判断
        $.ajax({
            url:"${basePath}/address-list.json",
            type:"post",
            data:params,
            success:function(json){
                if(json.result.code==0){
                    var html = '<option value="0">请选择</option>';
                    var data = json.data;
                    for(var i=0;i<data.length;i++){
                        html +='<option value="'+data[i].id+'" >'+data[i].name+'</option>';
                    }
                    if(type==3){
                        $("#yz-city").html(html);
                        $("#yz-district").html('<option value="0">请选择</option>');

                    }
                    if(type==2){
                        $("#yz-district").html(html);
                    }
                }
            }
        });
    }
</script>