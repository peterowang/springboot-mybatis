$(function(){
	$(".managementList").click(function(){
			$(this).toggleClass("shadow").siblings(".child_menu").slideToggle()
					.parent("li").siblings().children("a").removeClass("shadow")
					.next(".child_menu").slideUp();
	})
	$(".child_menu li").click(function(){
		$(this).css({"background":"#374A5E"}).children("a").css({"color":"#fff"})
		.parent().siblings("li").css({"background":"#2A3F54"}).children("a").css({"color":"#e7e7e7"});
	})

	$(".userName").click(function(){
		$(".loginName").toggle();
	})
	// 退出
	$(".quit").click(function(){
		$(".mengban ,.quitCon").show();
	})
	$(".btns span").click(function(){
		$(".mengban ,.quitCon ,.remove,.quitCon2").hide();
	})
	// 点击编辑
	$(".compile").click(function(){
		$(".indexList").hide().siblings(".indexList2").show();
	})
	// 删除
	$(".removes").click(function(){
		$(".remove ,.mengban").show();
	})
	// 翻页
	$(".lis").click(function(){
		$('.pageNumList').show();
	})
	$('.pageNumList').on('click','a',function(){
		var inde = $(this).text();
		$('.pagenum').text(inde);
		$('.pageNumList').hide();
		
	})
	$(".pagelist span").hover(function(){
		$(this).children("img").attr("src","images/pagexz.png")
	},function(){
		$(this).children("img").attr("src","images/pagexl.png")
	});
	// 添加设备
	$(".addEquipment").click(function(){
		$(".mengban ,.equipmentAlet").show();
	})
	$(".addbtn span").click(function(){
		$(".mengban ,.equipmentAlet").hide();
	})
	
})
