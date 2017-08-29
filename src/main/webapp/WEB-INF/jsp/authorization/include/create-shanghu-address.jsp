<%@ page language="java" pageEncoding="UTF-8"%>
    <p>
        <select name="" id="sh-province" class="select select2" onchange="sh_addr(this.value,'3')">
            <option value="0">请选择</option>

            <c:forEach items="${list}" var="item">
                <option value="${item.id}" >${item.name}</option>

            </c:forEach>
        </select>
        省
    </p>
    <p>
        <select name="" id="sh-city" class="select" onchange="sh_addr(this.value,'2')">
            <option value="">请选择</option>
        </select>
        市
    </p>
    <p>
        <select name="" id="sh-district" class="select" onchange="sh_addr(this.value,'1')">
            <option value="">请选择</option>
        </select>
        区/县
    </p>
    <p class="sel">
        <input type="text" id="sh-township" placeholder="乡" maxlength="64">
    </p>
    <p>
        <input type="text" id="sh-village" placeholder="村" maxlength="64">
    </p>
    <p class="p3"><input type="text" id="sh-streetAddresses" placeholder="街道/号/层" maxlength="64"></p>
</li>
<script type="text/javascript">
    function sh_addr(id,type){
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
                        $("#sh-city").html(html);
                        $("#sh-district").html('<option value="0">请选择</option>');

                    }
                    if(type==2){
                        $("#sh-district").html(html);
                    }
                }
            }
        });
    }
</script>