
var array = new Array();
var simple = new Array();

function manage(enterpriseId) {
    var params={};
    params.enterpriseId = enterpriseId;
    $.ajax({
        url:"/enterprise-person-manager.json",
        type:"post",
        data:params,
        success:function(json){

            if(json.result.code==0){
                var html = "";
                for(var i=0;i<json.data.length;i++){
                    var item = json.data[i];
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
                $("#mlist").html(html);

                html = "";
                for(var i=0;i<json.data.length;i++){
                    var item = json.data[i];
                    html+='<ol>';
                    html+='<li class="default">'+item.name+'</li>';
                    html+='<li>'+item.sex+'</li>';
                    html+='<li>'+item.phoneNumber+'</li>';
                    html+='<li class="point" onclick="point(this,\''+JSON.stringify(item).replace(/"/g, '&quot;')+'\')">x</li>';
                    html+='</ol>';
                    array.push(item);
                }
                $("#_p").text(array.length);

                $("#man").html(html);
            }
            open_list(enterpriseId);
        }

    });
}
function open_list(enterpriseId) {
    var params = {};
    params.enterpriseId = enterpriseId;
    $.ajax({
        url:"/person-list.json",
        type:"post",
        data:params,
        success:function(json){

            if(json.result.code==0){
                var html = "";
                for(var i=0;i<json.data.length;i++){
                    var bb=0;
                    var item = json.data[i];

                    for(var j=0;j<array.length;j++){
                        if(array[j].id==item.id){
                           bb=1;
                        }
                    }
                    if(bb==0){
                        html+='<ol onclick="m_point(this,\''+JSON.stringify(item).replace(/"/g, '&quot;')+'\')">';
                        html+='<li class="default">'+item.name+'</li>';
                        html+='<li>'+item.sex+'</li>';
                        html+='<li>'+item.phoneNumber+'</li>';
                        html+='<li class="point" ></li>';
                        html+='</ol>';
                        simple.push(item);
                    }


                }

                $("#man1").html(html);
            }
        }

    });
}



function point(obj,it){
    $(obj).parent("ol").remove();
    var per = eval('('+ it +')');
    simple.push(per);
    var b = new Array();
    for(var i=0;i<array.length;i++){
        if(array[i].id==per.id){
            continue;
        }
        b.push(array[i]);
    }
    array = b;
    $("#_p").text(array.length);

    var  html='';
    for(var i=0;i<simple.length;i++){
        var item = simple[i];
        html +='<ol>';
        html+='<li class="default">'+item.name+'</li>';
        html+='<li>'+item.sex+'</li>';
        html+='<li>'+item.phoneNumber+'</li>';
        html+='<li class="point" onclick="m_point(this,\''+JSON.stringify(item).replace(/"/g, '&quot;')+'\')">x</li>';
        html+='</ol>';
    }

    $("#man1").html(html);
}
function m_point(obj,it){
    $(obj).remove();
    var per = eval('('+ it +')');
    array.push(per);
    var b = new Array();
    for(var i=0;i<simple.length;i++){
        if(simple[i].id==per.id){
            continue;
        }
        b.push(simple[i]);
    }
    simple = b;
    $("#_p").text(array.length);


    var  html='';
    for(var i=0;i<array.length;i++){
        var item = array[i];
        html +='<ol>';
        html+='<li class="default">'+item.name+'</li>';
        html+='<li>'+item.sex+'</li>';
        html+='<li>'+item.phoneNumber+'</li>';
        html+='<li class="point" onclick="point(this,\''+JSON.stringify(item).replace(/"/g, '&quot;')+'\')">x</li>';
        html+='</ol>';
    }

    $("#man").html(html);

}