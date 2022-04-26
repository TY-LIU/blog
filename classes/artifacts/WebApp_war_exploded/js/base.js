$(function () {
    var length = 0;
    loadPic(0);

    //切换背景图
    function loadPic(len) {
        $("#chapter1 .bg-img li").eq(len).addClass("show").siblings().removeClass("show");
        if (len == 3) {
            $("#chapter1 .bg-img li").eq(0).addClass("showPrev").siblings().removeClass("showPrev");
        } else {
            $("#chapter1 .bg-img li").eq(len + 1).addClass("showPrev").siblings().removeClass("showPrev");
        }
    }

    setInterval(function () {
        loadPic(length + 1);
        length > 3 ? length = 0 : length++;
    }, 8000);

});
$(function () {
    $(" h1.fade").addClass("fade1");
    $(" h3.fade").addClass("fade2");
    $(" span.fade").addClass("fade3");
    $(".mouse").addClass("fade4");
    var cpHeight2 = $("#chapter2").offset().top;
    var cpHeight3 = $("#chapter3").offset().top - 50;
    var cpHeight4 = $("#chapter4").offset().top - 50;
    var cpHeight5 = $("#chapter5").offset().top - 50;
    var cpHeight6 = $("#chapter6").offset().top - 50;
    var cpHeight7 = $("#chapter7").offset().top - 50;

    //全局滚动
    function scrollTo(index, num) {
        if (num == "" || num == null) {
            num = 0;
        }
        $("html, body").animate({
            scrollTop: $("#chapter" + index + "").offset().top + num + "px"
        }, {
            duration: 400,
            easing: "swing"
        });
        return false;

    }

    $(".nav-ul li").click(function () {
        var index = $(this).index();
        scrollTo(index + 2);
    });
    $("span.fade").click(function () {
        var index = $(this).attr("data-num");
        scrollTo(index);
    });
    var num = 1;
    $(window).scroll(function () {
        var scrollTop = $(this).scrollTop();
        if ($("#chapter5").attr("class") == "chapter active") {
            if (num) {
                startCircle("myCanvas", 85, 80, 80, 65, 10, "#DDDDDD", "white", "#2C3E50", 10, "#2C3E50", 30);
                startCircle("myCanvas2", 90, 80, 80, 65, 10, "#DDDDDD", "white", "#2C3E50", 10, "#2C3E50", 30);
                startCircle("myCanvas3", 80, 80, 80, 65, 10, "#DDDDDD", "white", "#2C3E50", 10, "#2C3E50", 30);
                startCircle("myCanvas4", 75, 80, 80, 65, 10, "#DDDDDD", "white", "#2C3E50", 10, "#2C3E50", 30);
                startCircle("myCanvas5", 30, 80, 80, 65, 10, "#DDDDDD", "white", "#2C3E50", 10, "#2C3E50", 30);
                startCircle("myCanvas6", 60, 80, 80, 65, 10, "#DDDDDD", "white", "#2C3E50", 10, "#2C3E50", 30);
                startCircle("myCanvas7", 85, 80, 80, 65, 10, "#DDDDDD", "white", "#2C3E50", 10, "#2C3E50", 30);
                startCircle("myCanvas8", 30, 80, 80, 65, 10, "#DDDDDD", "white", "#2C3E50", 10, "#2C3E50", 30);
                num = 0;
            }
        }
        if (scrollTop >= cpHeight2) {
            $(".to-top").addClass("fadeIn");
            $("#nav-bar").addClass("fixed");
            $("#chapter2 h2").addClass("yetFixed");
        }else {
            $(".to-top").removeClass("fadeIn");
            $("#nav-bar").removeClass("fixed");
            $("#chapter2 h2").removeClass("yetFixed");
        }
        if(scrollTop<cpHeight7){
            $(".to-qq").removeClass("fadeIn");
        }
        if (scrollTop >= cpHeight2 && scrollTop < cpHeight3) {
            $("#nav-bar .nav-ul li").eq(0).addClass("active").siblings().removeClass("active");
            $("#nav-bar .nav-sm-ul li").eq(0).addClass("active").siblings().removeClass("active");
            $("#chapter2").addClass("active");
        } else if (scrollTop >= cpHeight3 && scrollTop < cpHeight4) {
            $("#nav-bar .nav-ul li").eq(1).addClass("active").siblings().removeClass("active");
            $("#nav-bar .nav-sm-ul li").eq(1).addClass("active").siblings().removeClass("active");
            $("#chapter3").addClass("active");
        } else if (scrollTop >= cpHeight4 && scrollTop < cpHeight5) {
            $("#nav-bar .nav-ul li").eq(2).addClass("active").siblings().removeClass("active");
            $("#nav-bar .nav-sm-ul li").eq(2).addClass("active").siblings().removeClass("active");
            $("#chapter4").addClass("active");
        } else if (scrollTop >= cpHeight5 && scrollTop < cpHeight6) {
            $("#nav-bar .nav-ul li").eq(3).addClass("active").siblings().removeClass("active");
            $("#nav-bar .nav-sm-ul li").eq(3).addClass("active").siblings().removeClass("active");
            $("#chapter5").addClass("active");
        } else if (scrollTop >= cpHeight6 && scrollTop < cpHeight7) {
            $("#nav-bar .nav-ul li").eq(4).addClass("active").siblings().removeClass("active");
            $("#nav-bar .nav-sm-ul li").eq(4).addClass("active").siblings().removeClass("active");
            $("#chapter6").addClass("active");
        } else if (scrollTop >= cpHeight7) {
            $(".to-qq").addClass("fadeIn");
            $("#nav-bar .nav-ul li").eq(5).addClass("active").siblings().removeClass("active");
            $("#nav-bar .nav-sm-ul li").eq(5).addClass("active").siblings().removeClass("active");
            $("#chapter7").addClass("active");
        }
    });

    $(".top").click(function () {
        $("html, body").animate({
            scrollTop: $("#chapter1").offset().top
        }, {
            duration: 400,
            easing: "swing"
        });
    });
    $(".more-nav").click(function(){
        $(".nav-ul.nav-sm-ul").slideToggle(200);
    });
    $("#nav-bar .nav-sm-ul li").click(function(){
        $(".nav-ul.nav-sm-ul").slideUp(200);
    });
});
