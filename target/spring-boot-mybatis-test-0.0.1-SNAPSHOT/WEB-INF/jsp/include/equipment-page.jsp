<%@ page language="java" pageEncoding="UTF-8"%>
<div class="page">
    <p class="all"><input type="checkbox" onclick="check_all(this)">全选</p>
    <span class="addman" >批量授权</span>
    <div class="pagesize">
        <ul class="pagelist" id="pagelist">

        </ul>
    </div>
</div>

<script type="text/javascript">
    var pageSize=10;
    function updatePageSize(ps){
        pageSize = ps;
        jump_user();
    }
    function topage(data){
        var page = data.currentPage;
        var totalPage = data.totalPage;
        var pageHtml = "";
        pageHtml += '<li><p class="bono">共<em id="em">'+data.totalCount+'</em>个记录</p></li>';
        if(page>1){
            pageHtml +='<li><a href="javascript:;" onclick="init('+(page-1)+')"><</a></li>';
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
                pageHtml +='<li class="active"><a href="javascript:;"  style="border-bottom: 1px solid black;">'+i+'</a></li>';
            }else{
                pageHtml +='<li><a href="javascript:;" onclick="init('+i+')">'+i+'</a></li>';
            }
        }
        if(page<totalPage){
            pageHtml +='<li><a href="javascript:;" onclick="init('+(page+1)+')">></a></li>';
        }


        pageHtml += '<li>';
        pageHtml += '<span class="lis" onclick="lis()" ><em class="pagenum" id="pagenum">'+data.pageSize+'</em>条/页<img src="images/pagexl.png" alt=""></span>';
        pageHtml += '<p class="pageNumList"  onclick="indef()">';
        pageHtml += '<a href="javascript:;" onclick="updatePageSize(5)">5</a>';
        pageHtml += '<a href="javascript:;" onclick="updatePageSize(10)">10</a>';
        pageHtml += '<a href="javascript:;" onclick="updatePageSize(100)">100</a>';
        pageHtml += '<a href="javascript:;" onclick="updatePageSize(500)">500</a>';
        pageHtml += '<a href="javascript:;" onclick="updatePageSize(1000)">1000</a>';
        pageHtml += '</p>';
        pageHtml += '</li>';
        pageHtml += '<li><span onclick="jump_user()">跳至</span></li>';
        pageHtml += '<li><input type="text" value="'+data.currentPage+'" id="jump_user_page"></li>';
        pageHtml += '<li>页</li>';
        $("#pagelist").html(pageHtml);
    }
    function jump_user(){
        var eq = $("#jump_user_page").val();
        init(eq);
    }
    function check_all(obj) {
        $("input[name='eq_id']").attr("checked","true");
        $(obj).attr("onclick","uncheck(this)");
    }
    function uncheck(obj) {
        $("input[name='eq_id']").removeAttr("checked")
        $(obj).attr("onclick","check_all(this)");
    }
</script>