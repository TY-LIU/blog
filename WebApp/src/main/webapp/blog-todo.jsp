<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" import="java.util.Date" %>
<%
    request.setAttribute("path", request.getContextPath());
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!doctype html>
<html class="no-js">
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta name="theme-color" content="#e6dacb">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="刘天源WEB前端工程师的个人简历">
    <meta name="keywords" content="web前端,web前端个人简历,前端工程师,刘天源简历,个人博客,WEB前端博客,前端简历">
    <meta name="description" content="WEB前端工程师——Mr.L的自学之路，个人博客知识笔记与心得记录">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="刘天源">
    <title>Blog » Mr.L的个人学习小站</title>

    <!-- Set render engine for 360 browser -->
    <meta name="renderer" content="webkit">

    <!-- No Baidu Siteapp-->
    <meta http-equiv="Cache-Control" content="no-siteapp"/>

    <link rel="icon" type="image/png" href="${path}/assets/i/favicon.png">

    <!-- Add to homescreen for Chrome on Android -->
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="${path}/assets/i/app-icon72x72@2x.png">

    <!-- Add to homescreen for Safari on iOS -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="apple-touch-icon-precomposed" href="${path}/assets/i/app-icon72x72@2x.png">

    <!-- Tile icon for Win8 (144x144 + tile color) -->
    <meta name="msapplication-TileImage" content="${path}/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileColor" content="#0e90d2">

    <link rel="stylesheet" href="${path}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="${path}/css/blog.css?time=<%=new Date().getTime() %>">
    <!--[if lte IE 9]>
    <script type="text/javascript">
        window.location = "http://www.xiaoyuezhang.com/error.html"
    </script>
    <![endif]-->
</head>
<body>
<div class="content">
    <div class=" container">
        <div class="header-box">
            <img src="img/mypic.jpg" alt="头像">
        </div>
        <div class="center">
            <p class="myId">Mr.L</p>
        </div>
        <div class="sort center">
            <a href="${path}/cv" title="简历">简历</a>
            <a href="${path}/blog" title="博客">博客</a>
            <a href="javascript:void(0);" title="留言">留言</a>
        </div>
        <div class="top fade" title="回到顶部">
            <img src="img/top.png" alt="回到顶部">
        </div>
        <div id="container">
            <div class="timeAxis">
                <div class="axis-content">
                    <%--圆点,时间--%>
                    <div class="dots"></div>
                    <a class="clock" href="">
                        <span class="triangle"></span>
                        <span class="data">2017.10.28</span>
                    </a>
                    <div class="axis-container">
                        <div class="timeLine"></div>
                        <div class="blog-content">
                            <p class="blog-title">
                                <a href="javascript:void(0)">
                                    测试测试测试测试测试测试测试
                                </a>
                            </p>
                            <div class="col-md-5 col-xs-8 blog-img">
                                <img src="img/bimg/test1.jpg" alt="文章配图">
                            </div>
                            <div class="col-md-10 col-xs-10 blog-detail">
                                <p>
                                    学习过程中所记录的笔记，按着步骤来可以自己搭建一个能通信的服务器，遇到不懂的地方问度娘。 在 我的码云和github上有搭建完成后的代码，前端用的Vue框架。
                                    不完善的地方还在修改ing~
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="axis-content">
                    <%--圆点,时间--%>
                    <div class="dots"></div>
                    <a class="clock" href="">
                        <span class="triangle"></span>
                        <span class="data">2017.10.28</span>
                    </a>
                    <div class="axis-container">
                        <div class="timeLine"></div>
                        <div class="blog-content">
                            <p class="blog-title">
                                <a href="javascript:void(0)">
                                    测试测试测试测试测试测试测试
                                </a>
                            </p>
                            <div class="col-md-4 col-xs-8 blog-img">
                                <img src="img/bimg/test1.jpg" alt="文章配图">
                            </div>
                            <div class="col-md-6 col-xs-10 blog-detail">
                                <p>
                                    学习过程中所记录的笔记，按着步骤来可以自己搭建一个能通信的服务器，遇到不懂的地方问度娘。 在 我的码云和github上有搭建完成后的代码，前端用的Vue框架。
                                    不完善的地方还在修改ing~
                                    学习过程中所记录的笔记，按着步骤来可以自己搭建一个能通信的服务器，遇到不懂的地方问度娘。 在 我的码云和github上有搭建完成后的代码，前端用的Vue框架。
                                    不完善的地方还在修改ing~
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="axis-content">
                    <%--圆点,时间--%>
                    <div class="dots"></div>
                    <a class="clock" href="">
                        <span class="triangle"></span>
                        <span class="data">2017.10.28</span>
                    </a>
                    <div class="axis-container">
                        <div class="timeLine"></div>
                        <div class="blog-content">
                            <p class="blog-title">
                                <a href="javascript:void(0)">
                                    测试测试测试测试测试测试测试
                                </a>
                            </p>
                            <div class="col-md-10 col-xs-8 blog-img">
                                <img src="img/bimg/test1.jpg" alt="文章配图">
                            </div>
                            <div class="col-md-10 col-xs-10 blog-detail">
                                <p>
                                    学习过程中所记录的笔记，按着步骤来可以自己搭建一个能通信的服务器，遇到不懂的地方问度娘。 在 我的码云和github上有搭建完成后的代码，前端用的Vue框架。
                                    不完善的地方还在修改ing~
                                    学习过程中所记录的笔记，按着步骤来可以自己搭建一个能通信的服务器，遇到不懂的地方问度娘。 在 我的码云和github上有搭建完成后的代码，前端用的Vue框架。
                                    不完善的地方还在修改ing~
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="axis-content">
                    <%--圆点,时间--%>
                    <div class="dots"></div>
                    <a class="clock" href="">
                        <span class="triangle"></span>
                        <span class="data">2017.10.28</span>
                    </a>
                    <div class="axis-container">
                        <div class="timeLine"></div>
                        <div class="blog-content">
                            <p class="blog-title">
                                <a href="javascript:void(0)">
                                    测试测试测试测试测试测试测试
                                </a>
                            </p>
                            <div class="col-md-10 col-xs-8 blog-img">
                                <img src="img/bimg/test1.jpg" alt="文章配图">
                            </div>
                            <div class="col-md-10 col-xs-10 blog-detail">
                                <p>
                                    学习过程中所记录的笔记，按着步骤来可以自己搭建一个能通信的服务器，遇到不懂的地方问度娘。 在 我的码云和github上有搭建完成后的代码，前端用的Vue框架。
                                    不完善的地方还在修改ing~
                                    学习过程中所记录的笔记，按着步骤来可以自己搭建一个能通信的服务器，遇到不懂的地方问度娘。 在 我的码云和github上有搭建完成后的代码，前端用的Vue框架。
                                    不完善的地方还在修改ing~
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="axis-content">
                    <%--圆点,时间--%>
                    <div class="dots"></div>
                    <a class="clock" href="">
                        <span class="triangle"></span>
                        <span class="data">2017.10.28</span>
                    </a>
                    <div class="axis-container">
                        <div class="timeLine"></div>
                        <div class="blog-content">
                            <p class="blog-title">
                                <a href="javascript:void(0)">
                                    测试测试测试测试测试测试测试
                                </a>
                            </p>
                            <div class="col-md-10 col-xs-8 blog-img">
                                <img src="img/bimg/test1.jpg" alt="文章配图">
                            </div>
                            <div class="col-md-10 col-xs-10 blog-detail">
                                <p>
                                    学习过程中所记录的笔记，按着步骤来可以自己搭建一个能通信的服务器，遇到不懂的地方问度娘。 在 我的码云和github上有搭建完成后的代码，前端用的Vue框架。
                                    不完善的地方还在修改ing~
                                    学习过程中所记录的笔记，按着步骤来可以自己搭建一个能通信的服务器，遇到不懂的地方问度娘。 在 我的码云和github上有搭建完成后的代码，前端用的Vue框架。
                                    不完善的地方还在修改ing~
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="axis-content">
                    <%--圆点,时间--%>
                    <div class="dots"></div>
                    <a class="clock" href="">
                        <span class="triangle"></span>
                        <span class="data">2017.10.28</span>
                    </a>
                    <div class="axis-container">
                        <div class="timeLine"></div>
                        <div class="blog-content">
                            <p class="blog-title">
                                <a href="javascript:void(0)">
                                    测试测试测试测试测试测试测试
                                </a>
                            </p>
                            <div class="col-md-10 col-xs-8 blog-img">
                                <img src="img/bimg/test1.jpg" alt="文章配图">
                            </div>
                            <div class="col-md-10 col-xs-10 blog-detail">
                                <p>
                                    学习过程中所记录的笔记，按着步骤来可以自己搭建一个能通信的服务器，遇到不懂的地方问度娘。 在 我的码云和github上有搭建完成后的代码，前端用的Vue框架。
                                    不完善的地方还在修改ing~
                                    学习过程中所记录的笔记，按着步骤来可以自己搭建一个能通信的服务器，遇到不懂的地方问度娘。 在 我的码云和github上有搭建完成后的代码，前端用的Vue框架。
                                    不完善的地方还在修改ing~
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="axis-content" style="min-height: 3em;">
                    <div class="dots"></div>
                </div>
            </div>
        </div>
        <p class="center record">© Mr.L | <a href="http://www.miitbeian.gov.cn/publish/query/indexFirst.action">蜀ICP备16004270号</a></p>
    </div>
</div>
<script src="${path}/assets/js/jquery-1.12.2.js"></script>
<script>
    $(".header-box,.myId").addClass("fadeIn");
    var _top = window.screen.availHeight;
    $(window).scroll(function () {
        var scrollTop = $(this).scrollTop();
        if (scrollTop >= _top) {
            $(".top").addClass("fadeIn");
        } else {
            $(".top").removeClass("fadeIn");
        }
    });
    $(".top").click(function () {
        $("html, body").animate({
            scrollTop: 0
        }, {
            duration: 400,
            easing: "swing"
        });
    });
</script>
</body>
</html>
