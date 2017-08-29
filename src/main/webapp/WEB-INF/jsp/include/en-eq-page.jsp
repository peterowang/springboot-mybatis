<%@ page language="java" pageEncoding="UTF-8"%>
<div class="page">
    <div class="pagesize">
        <ul class="pagelist" id="eq_pagelist">

        </ul>
    </div>
</div>

<script type="text/javascript">
    var eq_pageSize=10;
    function eq_updatePageSize(ps){
        eq_pageSize = ps;
        $("#pagenum").text(ps);
        jump_eq();
    }
    function eq_topage(data){
        var page = data.currentPage;
        var totalPage = data.totalPage;
        var pageHtml = "";
        pageHtml += '<li><p class="bono">共<em id="em">'+data.totalCount+'</em>个记录</p></li>';
        if(page>1){
            pageHtml +='<li><a href="javascript:;" onclick="equipmentlist('+(page-1)+')"><</a></li>';
        }
        var start = page-2<1?1:page-2;
        if(page==totalPage-1){
            start = page-3<1?1:page-3;
        }
        if(page==totalPage){
            start = page-4<1?1:page-4;
        }
        var end = page+2>totalPage?totalPage:page+2;
        if(page==1){
            end = page+4>totalPage?totalPage:page+4;
        }
        if(page==2){
            end = page+3>totalPage?totalPage:page+3;
        }

        for(var i=start;i<=end;i++){

            if(i==page){
                pageHtml +='<li class="active"><a href="javascript:;" style="border-bottom: 1px solid black;">'+i+'</a></li>';
            }else{
                pageHtml +='<li><a href="javascript:;" onclick="equipmentlist('+i+')">'+i+'</a></li>';
            }
        }
        if(page<totalPage){
            pageHtml +='<li><a href="javascript:;" onclick="equipmentlist('+(page+1)+')">></a></li>';
        }


        pageHtml += '<li>';
        pageHtml += '<span class="lis" onclick="lis()"><em class="pagenum" id="pagenum">'+data.pageSize+'</em>条/页<img src="images/pagexl.png" alt=""></span>';
        pageHtml += '<p class="pageNumList" onclick="indef()">';
        pageHtml += '<a href="javascript:;" onclick="eq_updatePageSize(5)">5</a>';
        pageHtml += '<a href="javascript:;" onclick="eq_updatePageSize(10)">10</a>';
        pageHtml += '</p>';
        pageHtml += '</li>';
        pageHtml += '<li><span onclick="jump_eq()">跳至</span></li>';
        pageHtml += '<li><input type="text" value="'+data.currentPage+'" id="jump_eq_page"></li>';
        pageHtml += '<li>页</li>';
        $("#eq_pagelist").html(pageHtml);
    }
    function jump_eq(){
        var eq = $("#jump_eq_page").val();
        equipmentlist(eq);
    }
</script>