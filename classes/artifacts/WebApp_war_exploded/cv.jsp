<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" import="java.util.Date" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    request.setAttribute("path", request.getContextPath());
    /*response.setHeader("P3P","CP=CAO PSA OUR");*/
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!doctype html>
<html class="no-js">
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta name="theme-color" content="#2C3E50">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="刘天源WEB前端工程师的个人简历">
    <meta name="keywords" content="web前端,web前端个人简历,前端工程师,刘天源简历,个人博客,WEB前端博客,前端简历">
    <meta name="description" content="WEB前端工程师——Mr.L的个人简历">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="刘天源">
    <title>Web前端工程师简历</title>

    <!-- Set render engine for 360 browser -->
    <meta name="renderer" content="webkit">

    <!-- No Baidu Siteapp-->
    <meta http-equiv="Cache-Control" content="no-siteapp"/>

    <link rel="icon" type="image/png" href="${path}/assets/i/web-icon72x72.png">

    <!-- Add to homescreen for Chrome on Android -->
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="${path}/assets/i/web-icon192x192.png">

    <!-- Add to homescreen for Safari on iOS -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="apple-touch-icon-precomposed" href="${path}/assets/i/web-icon72x72.png">

    <!-- Tile icon for Win8 (144x144 + tile color) -->
    <meta name="msapplication-TileImage" content="${path}/assets/i/web-icon144x144.png">

    <%--<link rel="stylesheet" href="${path}/assets/css/amazeui.min.css">--%>
    <link rel="stylesheet" href="${path}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="${path}/assets/css/font-awesome.css">
    <link rel="stylesheet" href="${path}/css/style.css?time=<%=new Date().getTime() %>">
</head>
<body>
<canvas id="canvas" style="position:fixed;z-index:0; height: 100%; width:100%;"></canvas>
<div class="comment">
    <div class="cv-container">
        <div id="chapter1" class="chapter active">
            <div class="myInfo">
                <h1 class="fade">Hello，I'm Mr.L</h1>
                <h3 class="fade">专注用户体验的WEB前端工程狮</h3>
                <span class="fade active" data-num="2">关于我</span>
                <span class="fade" data-num="4">我的作品</span>
            </div>
            <ul class="bg-img">
                <li></li>
                <li></li>
                <li></li>
                <li></li>
            </ul>
            <div class="mouse fade">
                <p class="colorText">滚动界面</p>
                <i class="fa fa-angle-down roll"></i>
            </div>
        </div>
        <div class="to-top top fade" title="回到顶部">
            <img src="img/top.png" alt="回到顶部">
        </div>
        <div class="to-qq top fade qq" title="联系我">
            <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=1536237744&site=qq&menu=yes"><i
                    class="fa fa-qq"></i></a>
        </div>
        <div id="chapter2" class="chapter">
            <%--导航栏--%>
            <div id="nav-bar" class="bar">
                <div class="container">
                    <a class="bolg">
                        <div class="fl" title="Mr.L的博客">
                            Mr.L的博客
                        </div>
                    </a>
                    <ul class="fr nav-ul">
                        <li>关于我</li>
                        <li>求职意向</li>
                        <li>作品集</li>
                        <li>技术掌握</li>
                        <li>我的经历</li>
                        <li>联系我</li>
                    </ul>
                    <div class="fr more-nav">
                        <img src="${path}/img/more.png" alt="更多">
                    </div>
                </div>
                <ul class="nav-ul nav-sm-ul">
                    <li>关于我</li>
                    <li>求职意向</li>
                    <li>作品集</li>
                    <li>技术掌握</li>
                    <li>我的经历</li>
                    <li>联系我</li>
                </ul>
            </div>
            <%--个人简介--%>
            <h2>关于我</h2>
            <hr>
            <div class="center fades fadesIn">
                <div class="center">
                    <img src="${path}/img/mypic3.jpg" alt="">
                </div>
                <div class="my-info">
                    <p>personalProfile[{</p>
                    <p class="intro">"name"："刘天源"</p>
                    <p class="intro">"title"："是这个人的简历"</p>
                    <p class="intro">"job"："web前端工程师"</p>
                    <p class="intro">"address"："重庆"</p>
                    <p class="intro">"description"："有些无趣，对各种活动无反应，对各种美观实用的插件兴趣 \"</p>
                    <p class="intro-pro">能熟悉开发符合W3C标准的界面，拥有良好的编码习惯 \</p>
                    <p class="intro-pro">不知天文，也不通地理，略懂如何保养程序员的颈椎以及推拿 \</p>
                    <p class="intro-pro">计算机软硬件，设计交互网络前后端开发，样样都经手都不精通</p>
                    <p class="intro-pro">\</p>
                    <p class="intro-pro">嗯上面的说的话.....其实前端还挺不错XD \</p>
                    <p class="intro-pro">理解能力、自学能力强，可通过自学提高自己的综合能力说的就是我 \</p>
                    <p class="intro">"contactInformation"：{</p>
                    <p class="intro-pro">"qq" ："1536237744"</p>
                    <p class="intro-pro">"email" ："l1536237744@gmail.com"</p>
                    <p class="intro-pro">"attention"："问在吗都不在，时间有限，抓紧热爱"</p>
                    <p class="intro">}</p>
                    <p class="intro">"motto"："用已知BUG顶住未知BUG"</p>
                    <p class="intro">"callback"："看到这里长得好看的人已经去留言了"</p>
                    <p>}]</p>
                </div>
            </div>
        </div>
        <div id="chapter3" class="chapter">
            <h2>求职意向</h2>
            <hr>
            <div class="container center fades fadesIn">
                <div class="col-md-3 col-xs-6 skill">
                    <p>
                        <img class="" src="img/web.png"/>
                    </p>
                    <p class="pTitle">PS切图</p>
                    <p>从PSD上切出页面需要的图片</p>
                    <p>将小图标合成spirts优化。</p>
                </div>
                <div class="col-md-3 col-xs-6 skill">
                    <p>
                        <img class="" src="img/css.png"/>
                    </p>
                    <p class="pTitle">网页开发</p>
                    <p>相应式布局，美观简洁</p>
                    <p>css3动画流畅，兼容性良好，除了IE。</p>
                </div>
                <div class="col-md-3 col-xs-6 skill">
                    <p>
                        <img class="" src="img/js.png"/>
                    </p>
                    <p class="pTitle">前端能力</p>
                    <p>框架能用就用，原生也玩得转</p>
                    <p>根据后台文档获取内容完成数据绑定。</p>
                </div>
                <div class="col-md-3 col-xs-6 skill">
                    <p>
                        <img class="" src="img/H5.png"/>
                    </p>
                    <p class="pTitle">H5界面</p>
                    <p>移动端的适配与页面书写</p>
                    <p>兼容Android、IOS。</p>
                </div>
            </div>
        </div>
        <div id="chapter4" class="chapter">
            <h2>作品集</h2>
            <hr>
            <div class="container center fades fadesIn">
                <p class="center intros">写jq前端功能的时候，我的宗旨是能手写就手写，不依赖插件。手写代码更简洁高效，也更能提升自己技术。</p>
                <div class="col-md-3 col-xs-6">
                    <a href="http://www.bomin-china.com/cq/" title="点击查看该网页" target="_blank">
                        <div class="imgBox">
                            <img src="img/01.jpg" alt="作品配图">
                        </div>
                        <div class="cover">
                            <h4 class="fade am1">官网类型</h4>
                            <p class="fade am2">相应式布局，兼容各类浏览器与移动端。</p>
                            <img class="icon am3" src="img/search.png" alt="查看">
                        </div>
                    </a>
                </div>
                <div class="col-md-3 col-xs-6">
                    <a href="http://www.bomin-china.com/cq/" title="点击查看该网页" target="_blank">
                        <div class="imgBox">
                            <img src="img/01.jpg" alt="作品配图">
                        </div>
                        <div class="cover">
                            <h4 class="fade am1">无缝轮播</h4>
                            <p class="fade am2">点击不同的坐标平滑过度到其指定图。</p>
                            <img class="icon am3" src="img/search.png" alt="查看">
                        </div>
                    </a>
                </div>
                <div class="col-md-3 col-xs-6">
                    <a href="javascript:void(0)" title="微信公众号" target="_blank">
                        <div class="imgBox">
                            <img src="img/01.jpg" alt="作品配图">
                        </div>
                        <div class="cover" data-type="wsd" data-name="微信公众号" data-num="5" data-alt="由于需要进入公众号所以是截图">
                            <h4 class="fade am1">购物类型</h4>
                            <p class="fade am2">微信公众号网页开发。</p>
                            <img class="icon am3" src="img/search.png" alt="查看">
                        </div>
                    </a>
                </div>
                <div class="col-md-3 col-xs-6">
                    <a href="javascript:void(0)" title="APP开发" target="_blank">
                        <div class="imgBox">
                            <img src="img/01.jpg" alt="作品配图">
                        </div>
                        <div class="cover" data-type="jsb" data-name="聚疏宝APP" data-num="4" data-alt="百度该APP下载即可使用">
                            <h4 class="fade am1">手机APP类</h4>
                            <p class="fade am2">聚疏宝，采用MUI.js开发完成。</p>
                            <img class="icon am3" src="img/search.png" alt="查看">
                        </div>
                    </a>
                </div>
                <div class="col-md-3 col-xs-6">
                    <a href="javascript:void(0)" title="APP开发" target="_blank">
                        <div class="imgBox">
                            <img src="img/01.jpg" alt="作品配图">
                        </div>
                        <div class="cover" data-type="yyt" data-name="娱易通" data-num="4" data-alt="百度该APP下载即可使用">
                            <h4 class="fade am1">手机APP类</h4>
                            <p class="fade am2">娱易通，H5界面开发，配合jq。</p>
                            <img class="icon am3" src="img/search.png" alt="查看">
                        </div>
                    </a>
                </div>
                <div class="col-md-3 col-xs-6">
                    <a href="http://www.bomin-china.com/cq/about-loan/" title="网页视频播放" target="_blank">
                        <div class="imgBox">
                            <img src="img/01.jpg" alt="作品配图">
                        </div>
                        <div class="cover">
                            <h4 class="fade am1">视频类页面</h4>
                            <p class="fade am2">根据分辨率适配不同的播放器。</p>
                            <img class="icon am3" src="img/search.png" alt="查看">
                        </div>
                    </a>
                </div>
                <div class="col-md-3 col-xs-6">
                    <a href="${path}/plug" title="查看分页插件" target="_blank">
                        <div class="imgBox">
                            <img src="img/01.jpg" alt="作品配图">
                        </div>
                        <div class="cover">
                            <h4 class="fade am1">插件制作</h4>
                            <p class="fade am2">分页条是最常用的工具之一，自己封装一个用起来很舒服。</p>
                            <img class="icon am3" src="img/search.png" alt="查看">
                        </div>
                    </a>
                </div>
                <div class="col-md-3 col-xs-6">
                    <a href="javascript:void(0)" title="个人技术博客" target="_blank">
                        <div class="imgBox">
                            <img src="img/01.jpg" alt="作品配图">
                        </div>
                        <div class="cover">
                            <h4 class="fade am1">个人技术博客</h4>
                            <p class="fade am2">界面正在设计中。</p>
                            <img class="icon am3" src="img/search.png" alt="查看">
                        </div>
                    </a>
                </div>
            </div>
        </div>
        <div id="chapter5" class="chapter">
            <h2>技术掌握</h2>
            <hr>
            <div class="container center fades fadesIn">
                <div class="col-md-3 col-xs-6">
                    <canvas id="myCanvas" class="" width="320px" height="320px">
                        Your browser does not support the HTML5 canvas tag.
                    </canvas>
                    <p class="pTitle">HTM5</p>
                </div>
                <div class="col-md-3 col-xs-6">
                    <canvas id="myCanvas2" class="" width="320px" height="320px">
                        Your browser does not support the HTML5 canvas tag.
                    </canvas>
                    <p class="pTitle">JQ</p>
                </div>
                <div class="col-md-3 col-xs-6">
                    <canvas id="myCanvas3" class="" width="320px" height="320px">
                        Your browser does not support the HTML5 canvas tag.
                    </canvas>
                    <p class="pTitle">JS</p>
                </div>
                <div class="col-md-3 col-xs-6">
                    <canvas id="myCanvas4" class="" width="320px" height="320px">
                        Your browser does not support the HTML5 canvas tag.
                    </canvas>
                    <p class="pTitle">CSS3</p>
                </div>
                <div class="col-md-3 col-xs-6">
                    <canvas id="myCanvas5" class="" width="320px" height="320px">
                        Your browser does not support the HTML5 canvas tag.
                    </canvas>
                    <p class="pTitle">VUE</p>
                </div>
                <div class="col-md-3 col-xs-6">
                    <canvas id="myCanvas6" class="" width="320px" height="320px">
                        Your browser does not support the HTML5 canvas tag.
                    </canvas>
                    <p class="pTitle">MUI</p>
                </div>
                <div class="col-md-3 col-xs-6">
                    <canvas id="myCanvas7" class="" width="320px" height="320px">
                        Your browser does not support the HTML5 canvas tag.
                    </canvas>
                    <p class="pTitle">AJAX</p>
                </div>
                <div class="col-md-3 col-xs-6">
                    <canvas id="myCanvas8" class="" width="320px" height="320px">
                        Your browser does not support the HTML5 canvas tag.
                    </canvas>
                    <p class="pTitle">CANVAS</p>
                </div>
            </div>
        </div>
        <div id="chapter6" class="chapter">
            <h2>我的经历</h2>
            <hr>
            <div class="container center fades fadesIn">
                <ul class="timeLine">
                    <li>
                        <div class="date-box">
                            <p>09/2016</p>
                            <p>-</p>
                            <p>02/2018</p>
                        </div>
                        <div class="job-info">
                            <p class="strong fade fade1">重庆多企源科技有限公司</p>
                            <p class="pTitle fade fade2">技术部/前端工程师</p>
                            <p class="fade fade3">负责官网页面制作。PSD切图后构建页面框架<br>
                                利用JS、CSS3书写前端功能，让页面更充实丰富<br>
                                并将代码上传到代码托管平台上</p>
                        </div>
                    </li>
                    <li>
                        <div class="date-box">
                            <p>06/2016</p>
                            <p>-</p>
                            <p>09/2013</p>
                        </div>
                        <div class="job-info job-info-fr">
                            <p class="strong fade fade1">重庆电子工程学院</p>
                            <p class="pTitle fade fade2">大学/专科</p>
                            <p class="info fade fade3">获得全国计算机专业人才证书</p>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        <div id="chapter7" class="chapter">
            <h2>联系我</h2>
            <hr>
            <div class="container fades fadesIn">
                <div class="post">
                    <div class="comment-list">
                        <!--输入框-->
                        <div id="comment-main">
                            <form action="###" class="new-comment">
                                <a class="avatar" href="javascript:void(0);">
                                    <c:choose>
                                    <c:when test="${!empty sessionScope.get('users')}">
                                    <img class="userCenter" src="${sessionScope.get("users").getPortrait()}"
                                         alt="头像"></a>
                                <textarea placeholder="写下你的评论..."></textarea>
                                </c:when>
                                <c:otherwise>
                                    <img class="userLogin" src="${path}/img/touxiang.png" alt="头像"></a>
                                    <div class="sign-container">
                                        <a href="javascript:void(0);" class="btn btn-sign">登录</a>
                                        <span>后发表评论</span>
                                    </div>
                                </c:otherwise>
                                </c:choose>
                            </form>
                        </div>
                        <div class="normal-comment-list">
                            <div>
                                <div class='top-title'>
                                    <span>条评论</span>
                                    <a class='author-only' data-sort='author'>只看作者</a>
                                    <div class='pull-right'>
                                        <a class='active' data-sort='enjoy'>按喜欢排序</a>
                                        <a data-sort='time'>按时间正序</a>
                                        <a data-sort='time-desc'>按时间倒序</a>
                                    </div>
                                </div>
                            </div>
                            <div class="comments-placeholder">
                                <div class="author">
                                    <div class="avatar"></div>
                                    <div class="info">
                                        <div class="name"></div>
                                        <div class="meta"></div>
                                    </div>
                                </div>
                                <div class="text"></div>
                                <div class="text animation-delay"></div>
                                <div class="tool-group">
                                    <i class="fa fa-thumbs-up"></i>
                                    <div class="zan"></div>
                                    <i class="fa fa-comment"></i>
                                    <div class="zan"></div>
                                </div>
                            </div>
                        </div>
                        <div>
                            <%--<ul id="paging" class="paging">
                                <li><a href="javascript:void(null)" class="active">1</a></li>
                                <li><a>2</a></li>
                                <li><a>3</a></li>
                                <li><span>...</span></li>
                                <li><a>下一页</a></li>
                            </ul>--%>
                            <div class="load-more" rel="2">加载更多留言 <i class="fa fa-angle-down"></i></div>
                            <ul class="paging" id="pageTool"></ul>
                            <input type="hidden" value="10" id="pageSize">
                            <input type="hidden" value="1" id="pageNo">
                            <input type="hidden" value="enjoy" id="sort">
                            <input type="hidden" value="false" id="authorState">
                            <input type="hidden" value="0" id="loadNum">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script src="${path}/assets/js/jquery-1.12.2.js"></script>
<script src="${path}/assets/js/jquery.form.js"></script>
<script src="js/makeCircle.js"></script>
<script src="${path}/js/loadPage.js"></script>
<script src="${path}/js/base.js?time=<%=new Date().getTime() %>"></script>
<script src="${path}/assets/layer/layer.js" type="text/javascript"></script>
<script src="${path}/js/rain.js" type="text/javascript"></script>
<script src="${path}/assets/js/gt.js" type="text/javascript"></script>
<script type="text/javascript">
    //无评论样式
    var _title_null = "<div><div class='top-title'><span>评论</span></div><div class='message-null'></div><div>暂无评论</div></div>";
    var toolload = "false";
    var loadmore = "false";
    $(function () {

        //开启hash
        /*var hash_page = window.location.hash.split("=")[1];
        hash_page = hash_page == undefined ? 1 : hash_page;*/

        var scrollNum = 0;
        var cpHeight7 = $("#chapter7").offset().top - 50;
        //滚动监控
        $(window).scroll(function () {
            var scrollTop = $(this).scrollTop();
            if (scrollTop >= cpHeight7 && scrollNum == 0) {
                loadData($("#pageNo").val(), $("#sort").val(), $("#authorState").val());
                scrollNum++;
            }
        });

        //查询留言方法
        function loadData(pageNo, sort, authorState) {
            var _authorState = $("#authorState").val();
            $(".normal-comment-list").find(".comments-placeholder").css("display", "block");
            $(".normal-comment-list").find(".comment").remove();
            $("#pageTool").hide();
            var param = {};//定义值，后台获取
            param.pageSize = $("#pageSize").val();
            param.pageNo = pageNo;//当前页码
            param.sort = sort;
            param.authorState = authorState;
            $.ajax({
                type: "post",
                url: "${path}/messageInfo/selectByIndex",
                timeout: 20000,
                data: param,
                success: function (data) {
                    var pageModel = data.pageModel;
                    if (pageModel == "" || pageModel == null ||pageModel.data.length==0) {
                        $(".top-title").remove();
                        $(".normal-comment-list").append(_title_null);
                        $(".normal-comment-list").find(".comments-placeholder").css("display", "none");
                        return false;
                    }
                    if (toolload == "false") {
                        $.pageInit({
                            totalPages: pageModel.totalPages,
                            totalRecords: pageModel.totalRecords,
                            pageNo: pageModel.pageNo,
                            pageSize: pageModel.pageSize,
                            nextPageNo: pageModel.nextPageNo,
                            previousPageNo: pageModel.previousPageNo,
                            callback: loadData
                        });
                    }
                    $(".top-title span").text("" + pageModel.totalRecords + "条评论");
                    var _comment = "";
                    var addFlag = true;
                    $.each(pageModel.data, function (index, item) {
                        _comment += "<div class='comment' id='comment-" + item.message_id + "'>" +
                            "<div>" +
                            "    <div class='author'>" +
                            "        <div class='tooltip-container'>" +
                            "            <div class='tooltip-content'>" +
                            "                <a href='javascript:void(0);' class='avatar'>" +
                            "                    <img src='" + item.portrait + "'alt='头像'>" +
                            "                </a>" +
                            "            </div>" +
                            "        </div>" +
                            "        <div class='info'>" +
                            "            <a href='javascript:void(0);' class='name'>" + (item.user_id == 6 ? '' + item.nickname + '<p class="moderator">作者</p>' : '' + item.nickname + '') + "</a>" +
                            "            <div class='meta'>" +
                            "                <span>" + item.message_id + "楼 · " + item.message_time + "</span>" +
                            "            </div>" +
                            "        </div>" +
                            "    </div>" +
                            "    <div class='comment-wrap'>" +
                            "        <p>" + item.message_content + "</p>" +
                            "        <div class='tool-group'>";
                        for (var i = 0; i < data.list.length; i++) {
                            addFlag = true;
                            if (data.list[i] == item.message_id) {
                                _comment += "<a href='javascript:void(0);' class='zan active' data-type='cancel' data-id='" + item.message_id + "'><i class='fa fa-thumbs-up bounce'></i>";
                                addFlag = false;
                                break;
                            }
                        }
                        if (addFlag) {
                            _comment += "<a href='javascript:void(0);' class='zan' data-type='zan' data-id='" + item.message_id + "'><i class='fa fa-thumbs-o-up'></i>";
                        }
                        _comment += "<span>" + (item.enjoy == 0 ? '' : '' + item.enjoy + '人') + "赞</span>" +
                            "            </a>" +
                            "            <a href='javascript:void(0);' class='reply' send-to='" + item.nickname + "' data-id='" + item.message_id + "' data-userid='" + item.user_id + "'>" +
                            "                <i class='fa fa-comment-o'></i>" +
                            "                <span>回复</span>" +
                            "            </a>" +
                            "            <a href='javascript:void(0);' class='report' data-userid='" + item.user_id + "' data-id='" + item.message_id + "'>" +
                            "                <span>举报</span>" +
                            "            </a>" +
                            "        </div>" +
                            "    </div>" +
                            "</div>";
                        if (item.reply_num == 0) {
                            _comment += "<div class='sub-comment-list hide'></div>";
                        } else {
                            _comment += "<div class='sub-comment-list'>";
                            $.each(item.reply, function (index1, item1) {
                                _comment +=
                                    "<div id='reply-" + item1.reply_id + "' class='sub-comment'>" +
                                    "<p>" +
                                    "<div class='tooltip-container'>" +
                                    "<div class='tooltip-content'>" +
                                    "<a href='javascript:void(0);'>" + (item1.users.user_id == 6 ? '' + item1.users.nickname + '<p class="moderator">作者</p>' : '' + item1.users.nickname + '') + "</a>" +
                                    "</div>" +
                                    "</div>" +
                                    "<span><em>回复</em><a href='javascript:void(0);'>" + (item1.to_users.user_id == 6 ? '' + item1.to_users.nickname + '<p class="moderator">作者</p>' : '' + item1.to_users.nickname + '') + "</a>：" + item1.reply_content + "</span>" +
                                    "</p>" +
                                    "<div class='sub-tool-group'>" +
                                    "<span>" + item1.s_reply_time + "</span>" +
                                    "<a href='javascript:void(0);' class='reply' data-id='" + item.message_id + "' data-userid='" + item1.user_id + "' data-name='" + item1.users.nickname + "'>" +
                                    "<i class='fa fa-comment-o'></i>" +
                                    "<span>回复</span>" +
                                    "</a>" +
                                    "<a class='report' data-userid='" + item1.users.user_id + "' data-id='" + item1.reply_id + "'><span>举报</span></a>" +
                                    "</div>" +
                                    "</div>";
                            });
                            _comment += "<div class='sub-comment more-comment'>" +
                                "        <a href='javascript:void(0);' class='add-comment-btn' send-to='" + item.nickname + "' data-id='" + item.message_id + "' data-userid='" + item.user_id + "'>" +
                                "            <i class='fa fa-pencil'></i>" +
                                "            <span>添加新评论</span>" +
                                "        </a>";
                            if (item.reply_num > 4) {
                                _comment += "<span class='line-warp' data-id='" + item.message_id + "' data-page='1'>还有" + (item.reply_num - 4) + "条评论，<a>展开查看</a></span>";
                            }
                        }
                        _comment += "</div></div></div>";
                    });

                    $(".normal-comment-list").append(_comment);
                    $(".normal-comment-list").find(".comments-placeholder").css("display", "none");
                    $("#pageTool").show();
                    $(".prevPage").attr("rel", pageModel.previousPageNo);
                    $(".nextPage").attr("rel", pageModel.nextPageNo);
                    $("#pageNo").val(pageModel.pageNo);
                    toolload = "true";
                    if (pageModel.pageNo == pageModel.indexPageNo) {
                        $(".prevPage").parent().addClass("disabled");
                    } else {
                        $(".prevPage").parent().removeClass("disabled");
                    }
                    if (pageModel.pageNo == pageModel.lastPageNo) {
                        $(".load-more").attr("class","load-done").html("加载完成");
                        $(".nextPage").parent().addClass("disabled");
                    } else {
                        $(".nextPage").parent().removeClass("disabled");
                    }
                    if ($("#loadNum").val() == 1) {
                        $("html, body").animate({
                            scrollTop: $("#comment-main").offset().top + "px"
                        }, {
                            duration: 1000,
                            easing: "swing"
                        });
                    }
                    $("#loadNum").val("0");

                }, complete: function (XMLHttpRequest, status) {
                    if (status == "timeout") {
                        layer.alert('网络异常，请检查网络', {
                            icon: 2,
                            skin: 'layer-ext-moon',
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        }, function () {
                            $(".top-title").remove();
                            $(".normal-comment-list").append(_title_null);
                            $(".normal-comment-list").find(".comments-placeholder").css("display", "none");
                            layer.close(layer.index);
                        });
                    } else if (status == "error") {
                        layer.alert('发生错误,请求失败', {
                            icon: 2,
                            skin: 'layer-ext-moon',
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        }, function () {
                            $(".top-title").remove();
                            $(".normal-comment-list").append(_title_null);
                            $(".normal-comment-list").find(".comments-placeholder").css("display", "none");
                            layer.close(layer.index);
                        });
                    }
                }
            });
        }


        function loadDataByPhone(pageNo, sort, authorState) {
            $(".normal-comment-list").append($(".comments-placeholder"));
            $(".normal-comment-list").find(".comments-placeholder").css("display", "block");
            var param = {};//定义值，后台获取
            param.pageSize = $("#pageSize").val();
            param.pageNo = pageNo;//当前页码
            param.sort = sort;
            param.authorState = authorState;
            $.ajax({
                type: "post",
                url: "${path}/messageInfo/selectByIndex",
                timeout: 20000,
                data: param,
                success: function (data) {
                    var pageModel = data.pageModel;
                    if (pageModel == "" || pageModel == null) {
                        $(".top-title").remove();
                        $(".normal-comment-list").append(_title_null);
                        $(".normal-comment-list").find(".comments-placeholder").css("display", "none");
                        return false;
                    }
                    $(".top-title span").text("" + pageModel.totalRecords + "条评论");
                    var _comment = "";
                    var addFlag = true;
                    $.each(pageModel.data, function (index, item) {
                        _comment += "<div class='comment' id='comment-" + item.message_id + "'>" +
                            "<div>" +
                            "    <div class='author'>" +
                            "        <div class='tooltip-container'>" +
                            "            <div class='tooltip-content'>" +
                            "                <a href='javascript:void(0);' class='avatar'>" +
                            "                    <img src='" + item.portrait + "'alt='头像'>" +
                            "                </a>" +
                            "            </div>" +
                            "        </div>" +
                            "        <div class='info'>" +
                            "            <a href='javascript:void(0);' class='name'>" + (item.user_id == 6 ? '' + item.nickname + '<p class="moderator">作者</p>' : '' + item.nickname + '') + "</a>" +
                            "            <div class='meta'>" +
                            "                <span>" + item.message_id + "楼 · " + item.message_time + "</span>" +
                            "            </div>" +
                            "        </div>" +
                            "    </div>" +
                            "    <div class='comment-wrap'>" +
                            "        <p>" + item.message_content + "</p>" +
                            "        <div class='tool-group'>";
                        for (var i = 0; i < data.list.length; i++) {
                            addFlag = true;
                            if (data.list[i] == item.message_id) {
                                _comment += "<a href='javascript:void(0);' class='zan active' data-type='cancel' data-id='" + item.message_id + "'><i class='fa fa-thumbs-up bounce'></i>";
                                addFlag = false;
                                break;
                            }
                        }
                        if (addFlag) {
                            _comment += "<a href='javascript:void(0);' class='zan' data-type='zan' data-id='" + item.message_id + "'><i class='fa fa-thumbs-o-up'></i>";
                        }
                        _comment += "<span>" + (item.enjoy == 0 ? '' : '' + item.enjoy + '人') + "赞</span>" +
                            "            </a>" +
                            "            <a href='javascript:void(0);' class='reply' send-to='" + item.nickname + "' data-id='" + item.message_id + "' data-userid='" + item.user_id + "'>" +
                            "                <i class='fa fa-comment-o'></i>" +
                            "                <span>回复</span>" +
                            "            </a>" +
                            "            <a href='javascript:void(0);' class='report' data-userid='" + item.user_id + "' data-id='" + item.message_id + "'>" +
                            "                <span>举报</span>" +
                            "            </a>" +
                            "        </div>" +
                            "    </div>" +
                            "</div>";
                        if (item.reply_num == 0) {
                            _comment += "<div class='sub-comment-list hide'></div>";
                        } else {
                            _comment += "<div class='sub-comment-list'>";
                            $.each(item.reply, function (index1, item1) {
                                _comment +=
                                    "<div id='reply-" + item1.reply_id + "' class='sub-comment'>" +
                                    "<p>" +
                                    "<div class='tooltip-container'>" +
                                    "<div class='tooltip-content'>" +
                                    "<a href='javascript:void(0);'>" + (item1.users.user_id == 6 ? '' + item1.users.nickname + '<p class="moderator">作者</p>' : '' + item1.users.nickname + '') + "</a>" +
                                    "</div>" +
                                    "</div>" +
                                    "<span><em>回复</em><a href='javascript:void(0);'>" + (item1.to_users.user_id == 6 ? '' + item1.to_users.nickname + '<p class="moderator">作者</p>' : '' + item1.to_users.nickname + '') + "</a>：" + item1.reply_content + "</span>" +
                                    "</p>" +
                                    "<div class='sub-tool-group'>" +
                                    "<span>" + item1.s_reply_time + "</span>" +
                                    "<a href='javascript:void(0);' class='reply' data-id='" + item.message_id + "' data-userid='" + item1.user_id + "' data-name='" + item1.users.nickname + "'>" +
                                    "<i class='fa fa-comment-o'></i>" +
                                    "<span>回复</span>" +
                                    "</a>" +
                                    "<a class='report' data-userid='" + item1.users.user_id + "' data-id='" + item1.reply_id + "'><span>举报</span></a>" +
                                    "</div>" +
                                    "</div>";
                            });
                            _comment += "<div class='sub-comment more-comment'>" +
                                "        <a href='javascript:void(0);' class='add-comment-btn' send-to='" + item.nickname + "' data-id='" + item.message_id + "' data-userid='" + item.user_id + "'>" +
                                "            <i class='fa fa-pencil'></i>" +
                                "            <span>添加新评论</span>" +
                                "        </a>";
                            if (item.reply_num > 4) {
                                _comment += "<span class='line-warp' data-id='" + item.message_id + "' data-page='1'>还有" + (item.reply_num - 4) + "条评论，<a>展开查看</a></span>";
                            }
                        }
                        _comment += "</div></div></div>";
                    });
                    $(".normal-comment-list").append(_comment);
                    $(".normal-comment-list").find(".comments-placeholder").css("display", "none");
                    $(".load-more").attr("rel", pageModel.nextPageNo);
                    if (pageModel.pageNo == pageModel.lastPageNo) {
                        $(".load-more").attr("class","load-done").html("加载完成");
                    }
                    loadmore="false";
                }, complete: function (XMLHttpRequest, status) {
                    if (status == "timeout") {
                        layer.alert('网络异常，请检查网络', {
                            icon: 2,
                            skin: 'layer-ext-moon',
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        }, function () {
                            $(".top-title").remove();
                            $(".normal-comment-list").append(_title_null);
                            $(".normal-comment-list").find(".comments-placeholder").css("display", "none");
                            layer.close(layer.index);
                        });
                    } else if (status == "error") {
                        layer.alert('发生错误,请求失败', {
                            icon: 2,
                            skin: 'layer-ext-moon',
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        }, function () {
                            $(".top-title").remove();
                            $(".normal-comment-list").append(_title_null);
                            $(".normal-comment-list").find(".comments-placeholder").css("display", "none");
                            layer.close(layer.index);
                        });
                    }
                }
            });
        }
        $("body").on("click",".load-more",function(){
            if(loadmore=="false"){
                var _pageNo=$(this).attr("rel");
                loadDataByPhone(_pageNo, "", "");
                loadmore="true";
            }
        });

        //评论区回复样式
        function newComment(username, dataId, userId, _placeholder) {
            var placeholder = typeof(_placeholder) == "undefined" || _placeholder == "" ? "写下你的评论..." : "" + _placeholder + "";
            var _newComment = " <div><form action='###' class='new-comment'><a class='avatar' href='javascript:void(0);'>" +
                "<img src='${sessionScope.get('users').getPortrait()}' alt='头像'></a>" +
                "<textarea placeholder='" + placeholder + "'></textarea><div class='write-function-block' data-type='reply'>" +
                "<div class='emoji-modal-wrap'><a data-v-b36e9416='' class='emoji'>" +
                "<i class='fa fa-smile-o'></i></a></div><div class='hint'>Ctrl+Enter 发送</div>" +
                "<a class='btn btn-send' data-id='" + dataId + "' data-userid='" + userId + "' send-to='" + username + "'>发送</a><a class='cancel' data-id='" + dataId + "'>取消</a></div></form></div>";
            return _newComment;
        }

        //侧栏回复样式
        function newReply(dataId, userId, _placeholder) {
            var placeholder = typeof(_placeholder) == "undefined" || _placeholder == "" ? "写下你的评论..." : "" + _placeholder + "";
            var _newComment = " <div><form action='###' class='new-comment'>" +
                "<textarea placeholder='" + placeholder + "'></textarea><div class='write-function-block' data-type='reply'>" +
                "<div class='emoji-modal-wrap'><a data-v-b36e9416='' class='emoji'>" +
                "<i class='fa fa-smile-o'></i></a></div><div class='hint'>Ctrl+Enter 发送</div>" +
                "<a class='btn btn-send' data-id='" + dataId + "' data-userid='" + userId + "'>发送</a><a class='cancel' data-id='" + dataId + "'>取消</a></div></form></div>";
            return _newComment;
        }

        //textarea控件点击
        $("body").on("focus", "#comment-main textarea", function () {
            var _write = "<div class='write-function-block' data-type='reply'><div class='emoji-modal-wrap'>" +
                "<a data-v-b36e9416='' class='emoji'><i class='fa fa-smile-o'></i></a></div>" +
                "<div class='hint'>Ctrl+Enter 发送</div><a class='btn btn-send'>发送</a><a class='cancel' data-id='main'>取消</a></div>";
            if ($("#comment-main").find(".write-function-block").length == 0) {
                $(this).after(_write);
            }
        });

        //博客
        $(".bolg").click(function () {
            layer.msg('正在开发中嗷~', {
                offset: '80%', icon: 7,
                skin: 'layer-ext-moon',
                shade: 0.001, time: 1500
            });
        });

        //作品
        $(".cover").click(function () {
            var _type = $(this).attr("data-type");
            if (_type != "" && _type != null) {
                var _title = $(this).attr("data-name");
                var _num = parseInt($(this).attr("data-num"));
                var _alt = $(this).attr("data-alt");
                var _data = [];
                for (var i = 1; i <= _num; i++) {
                    _data.push({
                        "alt": _alt,
                        "pid": "" + _type + i + "",
                        "src": "${path}/img/works/" + _type + i + ".jpg",
                    })
                }
                var _json = {
                    "title": _title, //相册标题
                    "id": _type, //相册id
                    "start": 0,
                    "data": _data
                };
                layer.photos({
                    photos: _json,
                    area: '400px',
                    shade: 0.3,
                    anim: 0
                });
            }
        });

        //查看更多
        $("body").on("click", ".more-comment .line-warp", function () {
            var _dataId = $(this).attr("data-id");
            var _pageNo = $(this).attr("data-page");
            var _type = $(this).find("a").text();
            if (_type == "收起" && typeof(_pageNo) == "undefined") {
                $("#comment-" + _dataId + " .sub-comment-list").find(".sub-comment:gt(3)").not(".more-comment").addClass("hide");
                $(this).find("a").text("展开");
                return false;
            } else if (_type == "展开" && typeof(_pageNo) == "undefined") {
                $("#comment-" + _dataId + " .sub-comment-list").find(".sub-comment:gt(3)").not(".more-comment").removeClass("hide");
                $(this).find("a").text("收起");
                return false;
            }
            $.ajax({
                type: "post",
                url: "${path}/m_replyInfo/selectReply",
                timeout: 20000,
                data: {pageNo: _pageNo, pageSize: "10", message_id: _dataId},
                success: function (data) {
                    var sub_comment = "";
                    $.each(data.data, function (index, item) {
                        sub_comment +=
                            "<div id='reply-" + item.reply_id + "' class='sub-comment'>" +
                            "<p>" +
                            "<div class='tooltip-container'>" +
                            "<div class='tooltip-content'>" +
                            "<a href='javascript:void(0);'>" + (item.users.user_id == 6 ? '' + item.users.nickname + '<p class="moderator">作者</p>' : '' + item.users.nickname + '') + "</a>" +
                            "</div>" +
                            "</div>" +
                            "<span><em>回复</em><a href='javascript:void(0);'>" + (item.to_users.user_id == 6 ? '' + item.to_users.nickname + '<p class="moderator">作者</p>' : '' + item.to_users.nickname + '') + "</a>：" + item.reply_content + "</span>" +
                            "</p>" +
                            "<div class='sub-tool-group'>" +
                            "<span>" + item.s_reply_time + "</span>" +
                            "<a href='javascript:void(0);' class='reply' data-id='" + item.message_id + "' data-name='" + item.users.nickname + "'>" +
                            "<i class='fa fa-comment-o'></i>" +
                            "<span>回复</span>" +
                            "</a>" +
                            "<a class='report' data-userid='" + item.users.user_id + "' data-id='" + item.reply_id + "'><span>举报</span></a>" +
                            "</div>" +
                            "</div>";
                    });
                    $("#comment-" + _dataId + " .more-comment").before(sub_comment);
                    if (((data.totalRecords - 4) - (data.pageNo * data.pageSize)) > 1) {
                        $("#comment-" + _dataId + " .more-comment .line-warp").attr("data-page", "" + data.nextPageNo + "").html("还有" + ((data.totalRecords - 4) - (data.pageNo * data.pageSize)) + "条评论，<a>展开查看</a>");
                    } else {
                        $("#comment-" + _dataId + " .more-comment .line-warp").removeAttr("data-page").html("<a>收起</a>");
                    }

                }, complete: function (XMLHttpRequest, status) {
                    if (status == "timeout") {
                        layer.alert('网络异常，请检查网络', {
                            icon: 2,
                            skin: 'layer-ext-moon',
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        }, function () {
                            layer.close(layer.index);
                        });
                    } else if (status == "error") {
                        layer.alert('发生了错误，都是我的锅！', {
                            icon: 2,
                            skin: 'layer-ext-moon',
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        }, function () {
                            layer.close(layer.index);
                        });
                    }
                }
            });
        });

        //赞
        $("body").on("click", ".post .tool-group .zan", function () {
            var _this = $(this);
            var _dataId = _this.attr("data-id");
            var _type = _this.attr("data-type");
            $.ajax({
                type: "post",
                url: "${path}/enjoyInfo/like",
                timeout: 20000,
                data: {entityId: _dataId, EntityType: "message", zanType: _type},
                success: function (data) {
                    if (data == "exist") {
                        _this.addClass("active").find("i").attr("class", "fa fa-thumbs-up bounce");
                        _this.attr("data-type", "cancel");
                        layer.msg('你已经赞过该留言了', {
                            offset: '80%', icon: 7,
                            skin: 'layer-ext-moon',
                            shade: 0.001, time: 1500
                        });
                    } else if (data == "loginOut") {
                        _this.addClass("active").find("i").attr("class", "fa fa-thumbs-up bounce");
                        _this.attr("data-type", "cancel");
                        layer.msg('游客不能取消赞嗷', {
                            offset: '80%', icon: 7,
                            skin: 'layer-ext-moon',
                            shade: 0.001, time: 1500
                        });
                    } else if (data == "error") {
                        layer.msg('赞错误', {
                            offset: '80%', icon: 2,
                            skin: 'layer-ext-moon',
                            shade: 0.001, time: 1500
                        });
                    } else if (parseInt(data) > 0) {
                        if (_type == "cancel") {
                            _this.addClass("active").find("i").attr("class", "fa fa-thumbs-o-up");
                            _this.attr("data-type", "zan");
                        } else {
                            _this.addClass("active").find("i").attr("class", "fa fa-thumbs-up bounce");
                            _this.attr("data-type", "cancel");
                        }
                        _this.find("span").text("" + data + "人赞");
                    } else if (parseInt(data) == 0) {
                        if (_type == "cancel") {
                            _this.addClass("active").find("i").attr("class", "fa fa-thumbs-o-up");
                            _this.attr("data-type", "zan");
                        } else {
                            _this.addClass("active").find("i").attr("class", "fa fa-thumbs-up bounce");
                            _this.attr("data-type", "cancel");
                        }
                        _this.find("span").text("赞");
                    } else {
                        layer.msg('赞错误', {
                            offset: '80%', icon: 2,
                            skin: 'layer-ext-moon',
                            shade: 0.001, time: 1500
                        });
                    }
                }, complete: function (XMLHttpRequest, status) {
                    if (status == "timeout") {
                        layer.msg('网络异常，请检查网络', {
                            icon: 2,
                            skin: 'layer-ext-moon',
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                    } else if (status == "error") {
                        layer.msg('赞错误', {
                            icon: 2,
                            skin: 'layer-ext-moon',
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                    }
                }
            });

        });

        //添加新评论
        $("body").on("click", ".post .tool-group .reply,.more-comment .add-comment-btn", function () {
            if ("${sessionScope.get("users").getUser_id()}" == "") {
                layer.msg('你还没有登录嗷', {
                    offset: '80%', icon: 7,
                    skin: 'layer-ext-moon',
                    shade: 0.001, time: 1500
                });
                return false;
            }
            var _dataId = $(this).attr("data-id");
            var _userId = $(this).attr("data-userid");
            var _username = $(this).attr("send-to");
            if ($("#comment-" + _dataId + "").find(".write-function-block").length <= 0) {
                $("#comment-" + _dataId + " .sub-comment-list").removeClass("hide").append(newComment(_username, _dataId, _userId));
            } else {
                $("#comment-" + _dataId + " .sub-comment-list").find("textarea").attr("placeholder", "写下你的评论...");
                $("#comment-" + _dataId + "").find(".btn-send").attr("data-userid", _userId).attr("send-to", _username);
            }
        });

        //回复
        $("body").on("click", ".post .sub-tool-group .reply", function () {
            if ("${sessionScope.get("users").getUser_id()}" == "") {
                layer.msg('你还没有登录嗷', {
                    offset: '80%', icon: 7,
                    skin: 'layer-ext-moon',
                    shade: 0.001, time: 1500
                });
                return false;
            }
            var _dataId = $(this).attr("data-id");
            var _userId = $(this).attr("data-userid");
            var _name = $(this).attr("data-name");
            if ($("#comment-" + _dataId + "").find(".write-function-block").length <= 0) {
                $("#comment-" + _dataId + " .sub-comment-list").append(newComment(_name, _dataId, _userId, "回复：" + _name + ""));
            } else {
                $("#comment-" + _dataId + "").find("textarea").attr("placeholder", "回复：" + _name + "");
                $("#comment-" + _dataId + "").find(".btn-send").attr("data-userid", _userId).attr("send-to", _name);
            }
        });

        //回复(侧栏)
        $("body").on("click", ".sidebar .tool-group .reply", function () {
            var _dataId = $(this).attr("data-id");
            var _userId = $(this).attr("data-userid");
            var _name = $(this).parent().parent().find(".user-my-comment-username").attr("data-name");
            var _newC = $(this).parent().parent().find(".new-comment");
            var _newCparent = $(this).parent().parent();
            if (_newCparent.find(".new-comment").length <= 0) {
                _newCparent.append(newReply(_dataId, _userId, "回复：" + _name + ""));
            } else {
                _newC.addClass("new-comment-leave");
                setTimeout(function () {
                    _newC.remove();
                }, 300);
            }
        });

        //发送
        $('body').on("click", '.normal-comment-list .btn-send,#comment-main .btn-send,.sidebar .btn-send', function () {
            var _newcomment = $(this);
            var content = $.trim($(this).parent().parent().find("textarea").val());
            if (content == "" || content == "undefined") {
                $(this).parent().parent().find("textarea").val("");
                $(this).parent().parent().find("textarea").addClass("shake");
                setTimeout(function () {
                    $("textarea").removeClass("shake");
                }, 400);
            } else {
                if ("${sessionScope.get("users").getUser_id()}" == "") {
                    layer.msg('你还没有登录嗷', {
                        offset: '80%', icon: 7,
                        skin: 'layer-ext-moon',
                        shade: 0.001, time: 1500
                    });
                } else {
                    _newcomment.addClass("disable");
                    var _messageId = $(this).attr("data-id");
                    var _to_uid = $(this).attr("data-userid");
                    var _user_id = "${sessionScope.get("users").getUser_id()}";
                    if ($(this).parent().parent().parent().attr("id") == "comment-main") {
                        addMessage(_newcomment, content, _user_id);
                    } else {
                        addReply(_newcomment, content, _messageId, _to_uid, _user_id);
                    }
                }
            }
        });

        $('body').on("keydown", '.normal-comment-list textarea,#comment-main textarea,.sidebar textarea', function (event) {
            if (event.keyCode == 13 && event.ctrlKey) {
                $(this).next("div").find(".btn-send").click();
            }
        });

        //取消
        $('body').on("click", '.cancel', function () {
            var _newcomment = $(this);
            var _dataId = $(this).attr("data-id");
            if (_dataId == "main") {
                $("#comment-" + _dataId + " .write-function-block").addClass("tool-leave");
                setTimeout(function () {
                    $("#comment-" + _dataId + " .write-function-block").remove();
                }, 300);
            } else {
                $(this).parent().parent().addClass("new-comment-leave");
                setTimeout(function () {
                    _newcomment.parent().parent().parent().remove();
                    if ($("#comment-" + _dataId + " .sub-comment").length == 0) {
                        $("#comment-" + _dataId + " .sub-comment-list").addClass("hide");
                    }
                }, 300);
            }
        });

        //悬浮变属性
        $('body').on("mouseover", ".comment-list .comment,.sub-comment-list .sub-tool-group", function () {
            var _userId = $(this).find(".report").attr("data-userid");
            if (_userId == "${sessionScope.get('users').getUser_id()}") {
                $(this).find(".report span").text("删除");
                $(this).find(".report").attr("class", "subcomment-delete");
            }
        });

        // todo 举报
        $('body').on("click", ".comment-list .report", function () {
            if ("${sessionScope.get("users").getUser_id()}" == "") {
                layer.msg('你还没有登录嗷', {
                    offset: '80%', icon: 7,
                    skin: 'layer-ext-moon',
                    shade: 0.001, time: 1500
                });
            } else {
                var _userId = $(this).attr("data-userid");
                var _messageId = $(this).attr("data-id");
                layer.msg('举报成功', {
                    offset: '80%', icon: 1,
                    skin: 'layer-ext-moon',
                    shade: 0.001, time: 1500
                });
            }
        });

        //删除
        $('body').on("click", ".tool-group .subcomment-delete,.sub-tool-group .subcomment-delete", function () {
            if ("${sessionScope.get("users").getUser_id()}" == "") {
                layer.msg('你还没有登录嗷', {
                    offset: '80%', icon: 7,
                    skin: 'layer-ext-moon',
                    shade: 0.001, time: 1500
                });
            } else {
                var _userId = $(this).attr("data-userid");
                var _messageId = $(this).attr("data-id");
                var _type = $(this).parent().attr("class");
                if (_type == "tool-group") {
                    delFun("${path}/messageInfo/delMessage", _userId, _messageId, "message");
                } else if (_type == "sub-tool-group") {
                    delFun("${path}/m_replyInfo/delReply", _userId, _messageId, "reply");
                }
            }
        });

        //排序方式
        $("body").on("click", ".top-title .pull-right a", function () {
            var _class = $(this).attr("class");
            if (_class == "active") {
                return false;
            }
            var _sort = $(this).attr("data-sort");
            $("#sort").val(_sort);
            $("#pageNo").val("1");
            toolload = "false";
            $(this).addClass("active").siblings().removeClass("active");
            loadData($("#pageNo").val(), _sort, $("#authorState").val());
        });

        //查看作者
        $("body").on("click", ".top-title .author-only", function () {
            var _class = $(this).attr("class");
            var _sort = $(".pull-right").find(".active").attr("data-sort");
            $("#pageNo").val("1");
            toolload = "false";
            if (_class == "author-only") {
                $(this).addClass("active");
                loadData($("#pageNo").val(), _sort, "true");
                $("#authorState").val("true");
                return false;
            } else if (_class == "author-only active") {
                $(this).removeClass("active");
                $("#authorState").val("false");
            }
            loadData($("#pageNo").val(), _sort, "false");
        });

        //登录按钮
        $("body").on("click", ".btn-sign", function () {
            $(".cv-container").addClass("vague");
            $("body").addClass("overf");
            $("body").append("<div class='mask'></div>");
            $.ajax({
                url: "var_login.jsp",
                type: "GET", //静态页用get方法，否则服务器会抛出405错误
                dataType: "html",
                success: function (data) {
                    $("#canvas").after(data);
                    $(".f-sign").attr("class", "f-sign scaleIn");
                }
            });
        });

        //点击遮罩删除login登录框
        $("body").on("click", ".mask,.remove-sign", function () {
            $(".f-sign").attr("class", "f-sign scaleOut");
            $(".cv-container").removeClass("vague");
            $("body").removeClass("overf");
            $(this).remove();
            setTimeout(function () {
                $(".f-sign").remove();
            }, 300);
        });

        //todo 表情
        var num = 1;
        $('body').on("click", '.emoji', function () {
            $(this).attr("data-num", "" + num++ + "");
            var _num = $(this).attr("data-num");
            if (_num == 1) {
                layer.msg("开发者太懒，还没做呢");
            } else if (_num == 2) {
                layer.msg("别点惹，都说还没做呢");
            } else if (_num == 3) {
                layer.msg("你这人怎么这么奇怪，一直点人家");
            } else if (_num == 4) {
                layer.msg("你在点我我就要哭了啊");
            } else if (_num == 5) {
                layer.msg("嘤嘤嘤嘤嘤，你欺负银，我要哭了");
            } else if (_num == 6) {
                main(true);
                $("#chapter7").attr("style", "background-color: inherit");
                layer.msg("冷冷的冰雨在脸上胡乱的拍");
            } else if (_num == 9) {
                layer.msg("看你点了人家这么多下，我就不哭了嘛");
                main(false);
                $("#chapter7").attr("style", "");
            } else if (_num == 20) {
                layer.msg("哇你竟然点了二十多次了，有这么喜欢我嘛");
            } else if (_num == 50) {
                layer.alert('五十次了兄dei，你就这么无聊么[冷漠脸]', {
                    title: '喂喂喂'
                    , skin: 'layui-layer-lan'
                    , closeBtn: 0
                    , anim: 6 //动画类型
                });
            } else if (_num == 100) {
                layer.alert('噗~我被点得受不了了，求赐我一死！', {
                    title: '阿西吧'
                    , skin: 'layui-layer-lan'
                    , closeBtn: 0
                    , anim: 6 //动画类型
                });
            } else if (_num == 200) {
                layer.alert('噗~后面真的没有彩蛋了，我求你别点了！！！', {
                    title: '阿西吧'
                    , skin: 'layui-layer-lan'
                    , closeBtn: 0
                    , anim: 6 //动画类型
                });
            } else if(_num == 250){
                main(true);
                $("#chapter7").attr("style", "background-color: inherit");
                layer.msg("欺负银。。。。");
            }

        });

        //用户中心
        $("body").on("click", ".userCenter", function () {
            if ("${sessionScope.get("users").getUser_id()}" == "") {
                layer.msg('你还没有登录嗷', {
                    offset: '80%', icon: 7,
                    skin: 'layer-ext-moon',
                    shade: 0.001, time: 1500
                });
                return false;
            }
            $("body").addClass("overf");
            $("body").append("<div class='mask-black'></div>");
            $.ajax({
                url: "var_sidebar.jsp",
                type: "GET", //静态页用get方法，否则服务器会抛出405错误
                dataType: "html",
                success: function (data) {
                    $("#canvas").after(data);
                    $(".sidebar ").addClass("slide-show");
                }
            });
        });

        //点击遮罩删除用户中心
        $("body").on("click", ".mask-black,.back", function () {
            $(".sidebar").attr("class", "sidebar slide-hide");
            $("body").removeClass("overf");
            $(".mask-black").remove();
            setTimeout(function () {
                $(".sidebar").remove();
                $("body").off('click', ".user-page .user-comment-list .del", fn);
            }, 300);
        });

        /**
         * @method addMessage 留言方法
         * @param event 发送标签的jquery对象
         * @param content 留言内容
         * @param user_id 留言用户ID
         *
         * */
        function addMessage(event, content, user_id) {
            event.parent().addClass("tool-leave");
            setTimeout(function () {
                event.parent().remove();
            }, 300);
            var param = {};
            param.user_id = user_id;
            param.content = content;
            param.url = window.location.href;
            param.title = $("title").text();
            $.ajax({
                type: "post",
                url: "${path}/messageInfo/addMessage",
                timeout: 20000,
                data: param,
                success: function (data) {
                    event.parent().parent().find("textarea").val("");
                    if (data != "" && data != null) {
                        var _comment = "<div class='comment' id='comment-" + data.message_id + "' style='display: none'>" +
                            "<div><div class='author'>" +
                            "<div class='tooltip-container'>" +
                            "<div class='tooltip-content'><a href='javascript:void(0);' class='avatar'>" +
                            "<img src='" + data.users.portrait + "' alt='头像'>" +
                            "</a></div></div><div class='info'><a href='javascript:void(0);' class='name'>" + data.users.nickname + "</a>" +
                            "<div class='meta'><span>" + data.message_id + "楼 · " + data.s_message_time + "</span></div></div></div>" +
                            "<div class='comment-wrap'><p>" + data.message_content + "</p><div class='tool-group'>" +
                            "<a href='javascript:void(0);' class='zan' data-type='zan' data-id='" + data.message_id + "'><i class='fa fa-thumbs-o-up'></i>" +
                            "<span>" + (data.enjoy == 0 ? '' : '' + data.enjoy + '人') + "赞</span>" +
                            "<a href='javascript:void(0);' class='reply' send-to='" + data.users.nickname + "' data-id='" + data.message_id + "' data-userid='" + data.users.user_id + "'><i class='fa fa-comment-o'></i>" +
                            "<span>回复</span></a><a href='javascript:void(0);' class='report' data-userid='" + data.users.user_id + "' data-id='" + data.message_id + "'><span>举报</span></a></div></div></div>" +
                            "<div class='sub-comment-list hide'></div></div>";
                        $(".comments-placeholder").after(_comment);
                        $("#comment-" + data.message_id + "").slideDown("fast", function () {
                            layer.msg('留言成功', {
                                icon: 1,
                                skin: 'layer-ext-moon',
                                offset: '80%',
                                time: 1500,
                                shade: 0.01,
                                zIndex: layer.zIndex,
                                success: function (layero) {
                                    layer.setTop(layero);
                                }
                            });
                        });
                    } else {
                        layer.msg('留言失败', {
                            icon: 2,
                            skin: 'layer-ext-moon',
                            offset: '80%',
                            time: 1500,
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                    }
                }, complete: function (XMLHttpRequest, status) {
                    if (status == "timeout") {
                        layer.msg('网络出现波动，留言可能失败', {
                            icon: 2,
                            offset: '80%',
                            time: 1500,
                            skin: 'layer-ext-moon',
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                    } else if (status == "error") {
                        layer.msg('留言失败，都是我的锅！', {
                            icon: 2,
                            offset: '80%',
                            time: 1500,
                            skin: 'layer-ext-moon',
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                    }
                }
            });
        }

        /**
         * @method addReply 回复方法
         * @param event 发送标签的jquery对象
         * @param content 回复内容
         * @param messageId 留言ID
         * @param to_uid 被回复用户ID
         * @param user_id 回复用户ID
         *
         * */
        function addReply(event, content, messageId, to_uid, user_id) {
            event.parent().parent().addClass("new-comment-leave");
            setTimeout(function () {
                event.parent().parent().parent().remove();
            }, 300);
            var param = {};
            param.message_id = messageId;
            param.reply_content = content;
            param.to_uid = to_uid;
            param.user_id = user_id;

            $.ajax({
                type: "post",
                url: "${path}/m_replyInfo/addReply",
                timeout: 20000,
                data: param,
                success: function (data) {
                    if (data != "" && data != null) {
                        if ($("#comment-" + messageId + "").find(".sub-comment").length == 0) {
                            var _moreComent = "<div class='sub-comment more-comment'>" +
                                "<a href='javascript:void(0);' class='add-comment-btn' send-to='" + data.to_users.nickname + "' data-id='" + data.message_id + "' data-userid='" + data.to_users.user_id + "'>" +
                                "<i class='fa fa-pencil'></i><span>添加新评论</span></a></div>";
                            $("#comment-" + messageId + " .sub-comment-list").append(_moreComent);
                        }
                        var _comment =
                            "<div id='reply-" + data.reply_id + "' class='sub-comment' style='display: none'>" +
                            "<p>" +
                            "<div class='tooltip-container'>" +
                            "<div class='tooltip-content'>" +
                            "<a href='javascript:void(0);'>" + (data.users.user_id == 6 ? '' + data.users.nickname + '<p class="moderator">作者</p>' : '' + data.users.nickname + '') + "</a>" +
                            "</div>" +
                            "</div>" +
                            "<span><em>回复</em><a href='javascript:void(0);'>" + (data.to_users.user_id == 6 ? '' + data.to_users.nickname + '<p class="moderator">作者</p>' : '' + data.to_users.nickname + '') + "</a>：" + data.reply_content + "</span>" +
                            "</p>" +
                            "<div class='sub-tool-group'>" +
                            "<span>" + data.s_reply_time + "</span>" +
                            "<a href='javascript:void(0);' class='reply' data-id='" + data.message_id + "' data-userid='" + data.users.user_id + "' data-name='" + data.users.nickname + "'>" +
                            "<i class='fa fa-comment-o'></i>" +
                            "<span>回复</span>" +
                            "</a>" +
                            "<a class='report' data-userid='" + data.users.user_id + "' data-id='" + data.reply_id + "'><span>举报</span></a>" +
                            "</div>" +
                            "</div>";
                        $("#comment-" + messageId + " .more-comment").before(_comment);
                        $("#comment-" + messageId + " .sub-comment-list").removeClass("hide");
                        if ($("#comment-" + messageId + "").length > 0) {
                            $("#reply-" + data.reply_id + "").slideDown("fast");
                        }
                        layer.msg('回复成功', {
                            icon: 1,
                            skin: 'layer-ext-moon',
                            offset: '80%',
                            time: 1500,
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                    } else {
                        layer.msg('回复失败', {
                            icon: 2,
                            skin: 'layer-ext-moon',
                            offset: '80%',
                            time: 1500,
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                    }
                }, complete: function (XMLHttpRequest, status) {
                    if (status == "timeout") {
                        layer.msg('网络出现波动，可能回复失败', {
                            icon: 2,
                            offset: '80%',
                            skin: 'layer-ext-moon',
                            time: 1500,
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                    } else if (status == "error") {
                        layer.msg('数据获取失败', {
                            icon: 2,
                            offset: '80%',
                            time: 1500,
                            skin: 'layer-ext-moon',
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                    }
                }
            });
        }

        /**
         * @method delFun 删除留言以及留言回复
         * @param url ajax的url
         * @param userId 用户id
         * @param entityId 实体id
         * @param 删除类型
         *
         * */
        function delFun(url, userId, entityId, type) {
            var param = {};
            param.userId = userId;
            if (type == "message") {
                param.messageId = entityId;
            } else if (type == "reply") {
                param.replyId = entityId;
            }
            $.ajax({
                type: "post",
                url: url,
                timeout: 20000,
                data: param,
                success: function (data) {
                    if (data == "true") {
                        if (type == "message") {
                            $("#comment-" + entityId + "").slideUp("fast", function () {
                                $(this).remove();
                            });
                        } else if (type == "reply") {
                            $("#reply-" + entityId + "").slideUp("fast", function () {
                                if ($("#reply-" + entityId + "").parent().find(".sub-comment").not(".more-comment").length == 1) {
                                    $("#reply-" + entityId + "").parent().slideUp("fast", function () {
                                        $(this).attr("style", "").addClass("hide").empty();
                                        return;
                                    });
                                }
                                $("#reply-" + entityId + "").remove();
                            });
                        }

                        layer.msg('删除成功', {
                            icon: 1,
                            offset: '80%',
                            skin: 'layer-ext-moon',
                            time: 1500,
                            shade: 0.001,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                    } else if (data == "false") {
                        layer.msg('删除失败', {
                            icon: 2,
                            offset: '80%',
                            skin: 'layer-ext-moon',
                            time: 1500,
                            shade: 0.001,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                    } else if (data == "loginOut") {
                        layer.msg('你还没登录嗷', {
                            icon: 7,
                            offset: '80%',
                            skin: 'layer-ext-moon',
                            time: 1500,
                            shade: 0.001,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                    }
                }, complete: function (XMLHttpRequest, status) {
                    if (status == "timeout") {
                        layer.msg('网络异常，请检查后重试', {
                            icon: 2,
                            offset: '80%',
                            skin: 'layer-ext-moon',
                            time: 1500,
                            shade: 0.001,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                    } else if (status == "error") {
                        layer.msg('删除失败，都是我的锅！', {
                            icon: 2,
                            offset: '80%',
                            time: 1500,
                            skin: 'layer-ext-moon',
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                    }
                }
            });
        }
    });

    // 对Date的扩展，将 Date 转化为指定格式的String
    // 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
    // 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
    // 例子：
    // (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423
    // (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18
    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        }
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt))
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;

    };
</script>
</body>
</html>