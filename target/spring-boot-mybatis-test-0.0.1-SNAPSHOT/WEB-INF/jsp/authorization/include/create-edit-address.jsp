<%@ page language="java" pageEncoding="UTF-8"%>
    <p>
        <select name="" id="province" class="select select2"  onchange="addr(this.value,'3')">
            <option value="0">请选择</option>

            <c:forEach items="${provincelist}" var="item">
                <option value="${item.id}" <c:if test="${addr.provinceid eq item.id}">selected</c:if>>${item.name}</option>

            </c:forEach>
        </select>
        省
    </p>
    <p>
        <select name="" id="city" class="select" onchange="addr(this.value,'2')">
            <option value="">请选择</option>
            <c:forEach items="${citylist}" var="item">
                <option value="${item.id}" <c:if test="${addr.cityid eq item.id}">selected</c:if>>${item.name}</option>

            </c:forEach>
        </select>
        市
    </p>
    <p>
        <select name="" id="district" class="select" onchange="addr(this.value,'1')">
            <option value="">请选择</option>
            <c:forEach items="${districtlist}" var="item">
                <option value="${item.id}" <c:if test="${addr.districtid eq item.id}">selected</c:if>>${item.name}</option>

            </c:forEach>
        </select>
        区/县
    </p>
    <p class="sel">
        <input type="text" id="township" placeholder="乡" value="${addr.township}" maxlength="64">
    </p>
    <p>
        <input type="text" id="village" placeholder="村" value="${addr.village}" maxlength="64">
    </p>
    <p class="p3"><input type="text" id="streetAddresses" value="${addr.streetAddresses}" placeholder="街道/号/层" maxlength="64"></p>
</li>
<script type="text/javascript">
    function addr(id,type){
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
                        $("#city").html(html);
                        $("#district").html('<option value="0">请选择</option>');

                    }
                    if(type==2){
                        $("#district").html(html);
                    }
                }
            }
        });
    }
</script>