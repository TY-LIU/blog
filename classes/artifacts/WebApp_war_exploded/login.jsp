<%@ page contentType="text/html;charset=UTF-8" import="com.personal.cv.entity.Users" language="java" %>
<%
    if (session.getAttribute("manager") instanceof Users) {
        response.sendRedirect(request.getContextPath() + "/login/toPages/main");
        return;
    }
    Object msg = session.getAttribute("unManagerLogin");
    session.removeAttribute("unManagerLogin");
    request.setAttribute("path", request.getContextPath());
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="博客后端管理系统">
    <meta name="keywords" content="博客后台,后台管理程序,个人博客管理系统">
    <meta name="description" content="博客后台管理系统">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="刘天源">
    <title>博客后端管理系统</title>

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
    <link href="${path}/assets/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="${path}/assets/css/font-awesome.min.css"/>
    <!--[if IE 7]>
    <link rel="stylesheet" href="${path}/assets/css/font-awesome-ie7.min.css"/>
    <![endif]-->
    <link rel="stylesheet" href="${path}/assets/css/ace.min.css"/>
    <link rel="stylesheet" href="${path}/assets/css/ace-rtl.min.css"/>
    <link rel="stylesheet" href="${path}/assets/css/ace-skins.min.css"/>
    <link rel="stylesheet" href="${path}/assets/css/login.css"/>
    <!--[if lte IE 8]>
    <link rel="stylesheet" href="${path}/assets/css/ace-ie.min.css"/>
    <![endif]-->
    <script src="${path}/assets/js/ace-extra.min.js"></script>
    <!--[if lt IE 9]>
    <script src="${path}/assets/js/html5shiv.js"></script>
    <script src="${path}/assets/js/respond.min.js"></script>
    <![endif]-->
    <script src="${path}/assets/js/jquery-1.12.2.js"></script>
    <script src="${path}/assets/layer/layer.js" type="text/javascript"></script>
    <title>登录</title>
</head>

<body class="login-layout">
<header>
    <div class="logintop">
        <span>欢迎登录后台管理系统</span>
        <ul>
            <li><a href="#">返回首页</a></li>
            <li><a href="javascript:void(0);" onclick="AddFavorite()">收藏本站</a></li>
            <li><a href="#">关于</a></li>
        </ul>
    </div>
</header>
<section>
    <div class="loginbody">
        <div class="login-container">
            <div class="center">
                <h1>
                    <span class="white">博客后台管理系统</span>
                </h1>
                <h4 class="white">Management System</h4>
            </div>
            <div class="space-6"></div>
            <div class="position-relative">
                <div id="login-box" class="login-box widget-box no-border visible">
                    <div class="widget-body">
                        <div class="widget-main">
                            <%--<h4 class="header white lighter bigger" style="text-align: center;">
                                <i class="icon-coffee white"></i>
                                <a href="javascript:void(0)" class="white" id="ap_login">账号登录</a>
                                &nbsp;|&nbsp;&nbsp;<a href="javascript:void(0)" class="white"
                                                      id="sms_login">短信登录</a>
                            </h4>--%>
                            <div class="toux"
                                 style="width: 100%;padding-top:0px;padding-bottom: 5px;text-align: center;">
                                <img class="toux-img" src="${path}/img/mypic.jpg"/>
                            </div>
                            <%--账号密码登录--%>
                            <fieldset id="apLogin" class="apLogin">
                                <!--用户名-->
                                <label class="block clearfix">
                                        <span class="block input-icon input-icon-right">
                                            <input type="text" ${identifier eq null?"autofocus":""}
                                                   class="form-control" placeholder="用户名/邮箱" id="loginName"
                                                   value="${identifier}">
                                            <i class="icon-user"></i>
                                        </span>
                                </label>
                                <!--密码-->
                                <label class="block clearfix">
                                        <span class="block input-icon input-icon-right">
                                            <input type="password" ${managerPwd eq null?"autofocus":""}
                                                   class="form-control" placeholder="密码" id="managerPwd">
                                            <i class="icon-lock"></i>
                                        </span>
                                </label>
                                <!--验证码-->
                                <div id="code_container">

                                </div>
                                <div style="position:relative;top: -3px;color: red;">
                                    <span id="ap_error_hint"><%=msg == null ? "" : "您必须登录后才能访问" %></span>
                                </div>
                                <div class="clearfix">
                                    <label class="inline" style="cursor: pointer;">
                                        <input type="checkbox" class="ace" id="rememberPwd" ${managerPwd eq null?"":"checked"}>
                                        <span class="lbl">保存密码</span>
                                    </label>
                                    <a href="javascrip:void(0);" class="lbl forgetPassword" style="">忘记密码</a>
                                </div>
                                <div class="clearfix" style="text-align: center;">
                                    <button id="ap_login_btn" class="btn btn-primary login-btn">登&nbsp;&nbsp;&nbsp;&nbsp;录</button>
                                </div>
                            </fieldset>
                            <%--短信登录--%>
                            <%--<fieldset id="smsLogin" class="apLogin" style="display: none">
                                <!--手机号码-->
                                <label class="block clearfix">
											<span class="block input-icon input-icon-right">
												<input type="text" class="form-control" placeholder="手机号码"
                                                       id="mobiephone">
												<i class="icon-mobile-phone" style="width:20px;font-size:25px;"></i>
											</span>
                                </label>
                                <!--验证码-->
                                <label class="block clearfix">
											<span class="block input-icon input-icon-right">
												<input class="form-control" placeholder="验证码" id="smscode"
                                                       style="width: 150px;display: inline">
                                                <button id="sms_btn" class="btn btn-primary">获取验证码</button>
											</span>
                                </label>
                                <div style="position:relative;top: -3px;color: red;">
                                    <span id="sms_error_hint"><%=msg == null ? "" : "您必须登录后才能访问" %></span>
                                </div>
                                <div class="clearfix" style="text-align: center;">
                                    <button id="sms_login_btn" class="btn btn-primary login-btn">登&nbsp;&nbsp;&nbsp;&nbsp;录</button>
                                </div>
                            </fieldset>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<footer>
    <div class="loginbm">版权所有 2017©<a href="">Mr.L</a></div>
</footer>
</body>

</html>
<script>
    !function () {
        function A(a, b, c) {
            return a.getAttribute(b) || c
        }

        function F(a) {
            return document.getElementsByTagName(a);
        }

        function D() {
            var c = F("script"),
                a = c.length,
                b = c[a - 1];
            return {
                l: a,
                z: A(b, "zIndex", -1),
                o: A(b, "opacity", 0.5),
                c: A(b, "color", "0,0,0"),
                n: A(b, "count", 199)
            }
        }

        function E() {
            x = i.width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            B = i.height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        }

        function M() {
            J.clearRect(0, 0, x, B);
            var c = [I].concat(v);
            var b, d, a, g, e, f;
            v.forEach(function (h) {
                h.x += h.xa,
                    h.y += h.ya,
                    h.xa *= h.x > x || h.x < 0 ? -1 : 1,
                    h.ya *= h.y > B || h.y < 0 ? -1 : 1,
                    J.fillRect(h.x - 0.5, h.y - 0.5, 1, 1);
                for (d = 0; d < c.length; d++) {
                    b = c[d];
                    if (h !== b && null !== b.x && null !== b.y) {
                        g = h.x - b.x;
                        e = h.y - b.y;
                        f = g * g + e * e;
                        f < b.max && (b === I && f >= b.max / 2 && (h.x -= 0.03 * g, h.y -= 0.03 * e), a = (b.max - f) / b.max, J.beginPath(), J.lineWidth = a / 2, J.strokeStyle = "rgba(" + w.c + "," + (a + 0.2) + ")", J.moveTo(h.x, h.y), J.lineTo(b.x, b.y), J.stroke())
                    }
                }
                c.splice(c.indexOf(h), 1);
            }),
                C(M);
        }

        var i = document.createElement("canvas"),
            w = D(),
            L = "c_n" + w.l, //c_n2
            J = i.getContext("2d"),
            x,
            B,
            C = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame ||
                function (a) {
                    window.setTimeout(a, 1000 / 45)
                },
            N = Math.random,
            I = {
                x: null,
                y: null,
                max: 20000
            };
        i.id = L;
        i.style.cssText = "position:fixed;top:0;left:0;z-index:" + w.z + ";opacity:" + w.o;
        F("body")[0].appendChild(i);
        E();
        window.onresize = E;
        window.onmousemove = function (a) {
            a = a || window.event,
                I.x = a.clientX,
                I.y = a.clientY
        };
        window.onmouseout = function () {
            I.x = null,
                I.y = null
        };
        for (var v = [], z = 0; w.n > z; z++) {
            var G = N() * x,
                H = N() * B,
                y = 2 * N() - 1,
                K = 2 * N() - 1;
            v.push({
                x: G,
                y: H,
                xa: y,
                ya: K,
                max: 6000
            });
        }
        setTimeout(function () {
            M()
        }, false)
    }();
</script>

<script>
    //收藏本站
    function AddFavorite() {
        var url = window.location;
        var title = document.title;
        var ua = navigator.userAgent.toLowerCase();
        if (ua.indexOf("360se") > -1) {
            alert("由于360浏览器功能限制，请按 Ctrl+D 手动收藏！");
        }
        else if (ua.indexOf("msie 8") > -1) {
            window.external.AddToFavoritesBar(url, title); //IE8
        }
        else if (document.all) {
            try{
                window.external.addFavorite(url, title);
            }catch(e){
                alert('您的浏览器不支持,请按 Ctrl+D 手动收藏!');
            }
        }
        else if (window.sidebar) {
            window.sidebar.addPanel(title, url, "");
        }
        else {
            alert('您的浏览器不支持,请按 Ctrl+D 手动收藏!');
        }
    }

    $(function () {
        var $imgcode = $("#imgcode");
        var $loginName = $("#loginName");
        var $managerPwd = $("#managerPwd");
        var $checkcode = $("#checkcode");
        var $ap_error_hint = $("#ap_error_hint");
        var $ap_login_btn = $("#ap_login_btn");
        var $apLogin = $("#apLogin");
        var $smsLogin = $("#smsLogin");
        var code_reg = /^[A-Za-z0-9]{4}$/;
        var name_reg = /^1[3|4|5|8][0-9]\d{4,8}$/;
        var emil_reg = /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/;
        $managerPwd.val("${managerPwd}");
        var check_ap_login = function (isShowError, isFocus, op) {
            var error = "";
            if (typeof(op) != "number" || op < -1 || op > 2)
                op = -1;
            if (op == -1 || op == 0) {
                if ($loginName.val() == "") {
                    error = "请输入登录帐号或邮箱";
                    $loginName.focus();
                } else if (!name_reg.test($loginName.val()) && !emil_reg.test($loginName.val())) {
                    error = "请输入正确格式的帐号或邮箱";
                    $loginName.focus();
                }
            }
            if (op == -1 || op == 1) {
                if (error == "" && $managerPwd.val() == "") {
                    error = "请输入密码";
                    $managerPwd.focus();
                }
            }
            if (op == -1 || op == 2) {
                if (error == "" && $checkcode.length > 0) {
                    if ($checkcode.val() == "") {
                        error = "请输入验证码";
                        $checkcode.focus();
                    } else if (!code_reg.test($checkcode.val())) {
                        error = "验证码格式有误";
                        $checkcode.focus();
                    }
                }
            }
            if (isShowError == true)
                $ap_error_hint.text(error);
            if (error != "")
                return false;
            if (isFocus == true)
                $ap_login_btn.focus();
            return true;
        };
        $("#ap_login").click(function () {
            if ($smsLogin.css("display") === "none")
                return;
            $apLogin.show();
            $smsLogin.hide();
            check_ap_login(false, false);
        });
        var showcode = function () {
            if ($checkcode.length > 0)
                return;
            $('#code_container').append("<label class='block clearfix' style='height: 35px;'>" +
                "<span class='block input-icon input-icon-right'>" +
                "<input type='text' class='form-control' placeholder='验证码' id='checkcode' style='float: left;padding-right: 110px;position: absolute;z-index: 2;'>" +
                "<a href='javascrip:void(0);' id='changeyan' class='change-captcha'>" +
                "<i class='icon-refresh' style='font-size: 16px;line-height: 34px;'></i>" +
                "</a>" +
                "<a href='javascrip:void(0);'>" +
                "<img src='${path}/login/toCaptcha' id='imgcode' class='captcha'/>" +
                "</a>" +
                "</span>" +
                "</label>");
            $checkcode = $("#checkcode");
            $imgcode = $("#imgcode");
            $checkcode.keyup(function (event) {
                var e = event || window.event;
                var keycode = e.which ? e.which : e.keyCode;
                if (keycode == 13)
                    $ap_login_btn.click();
                else
                    check_ap_login(true, false, 2);
            });
            $("#imgcode,#changeyan").click(function () {
                $ap_error_hint.text("");
                $imgcode.attr("src", "${path}/login/toCaptcha?d=" + new Date().getTime());
            });
        };
        var ap_login = function () {
            var param = {};//定义值，后台获取
            param.identifier = $loginName.val();
            param.credential = $managerPwd.val();
            param.rememberPwd = $("#rememberPwd")[0].checked;
            $.ajax({
                type: "post",
                url: "${path}/login/login",
                data: param,
                success: function (data) {
                    if (data == -4) {
                        $("#ap_login_btn").html("登&nbsp;&nbsp;&nbsp;&nbsp;录").removeAttr("disabled");
                        $ap_error_hint.text("连接服务器异常...");
                    }else if(data==-3){
                        $("#ap_login_btn").html("登&nbsp;&nbsp;&nbsp;&nbsp;录").removeAttr("disabled");
                        $imgcode.click();
                        $ap_error_hint.text("该帐号不存在");
                        $loginName.val("");
                        $managerPwd.val("");
                        $loginName.focus();
                        showcode();
                    }else if (data == -2) {
                        $("#ap_login_btn").html("登&nbsp;&nbsp;&nbsp;&nbsp;录").removeAttr("disabled");
                        $ap_error_hint.text("密码输入错误");
                        $managerPwd.val("");
                        $managerPwd.focus();
                    } else if (data == 1) {
                        if ($("#rememberPwd")[0].checked)
                            $managerPwd.attr("autocomplete", "on");
                        layer.msg("登录成功,正在跳转", {icon: 6, time: 2000});
                        top.location = "${path}/login/toPages/main";

                    }  else {
                        $imgcode.click();
                        $("#ap_login_btn").html("登&nbsp;&nbsp;&nbsp;&nbsp;录").removeAttr("disabled");
                        layer.msg("登录失败", {icon: 2, time: 1000});
                        showcode();
                    }
                }, error: function (data) {
                    $("#ap_login_btn").html("登&nbsp;&nbsp;&nbsp;&nbsp;录").removeAttr("disabled");
                    layer.msg("登录失败", {icon: 5, time: 1000});
                    showcode();
                }
            });
        };
        $loginName.keyup(function (event) {
            var e = event || window.event;
            var keycode = e.which ? e.which : e.keyCode;
            if (keycode == 13)
                $ap_login_btn.click();
            else
                check_ap_login(true, false, 0);
        });
        $managerPwd.keyup(function (event) {
            var e = event || window.event;
            var keycode = e.which ? e.which : e.keyCode;
            if (keycode == 13)
                $ap_login_btn.click();
            else
                check_ap_login(true, false, 1);
        });
        $ap_login_btn.click(function () {
            if (!check_ap_login(true, false))
                return false;
            $("#ap_login_btn").text("正在登录...").attr("disabled",true);
            if ($checkcode.length > 0) {
                $.ajax({
                    type: "post",
                    url: "${path}/login/toCaptcha",
                    data: {checkcode: $checkcode.val()},
                    success: function (data) {
                        if (data == "true") {
                            ap_login();
                        } else {
                            $("#ap_login_btn").html("登&nbsp;&nbsp;&nbsp;&nbsp;录").removeAttr("disabled");
                            $imgcode.click();
                            $ap_error_hint.text("验证码有误");
                            $checkcode.val("");
                            $checkcode.focus();
                        }
                    }, error: function () {
                        $("#ap_login_btn").html("登&nbsp;&nbsp;&nbsp;&nbsp;录").removeAttr("disabled");
                        layer.msg("验证失败", {icon: 5, time: 1000});
                    }
                });
            } else {
                ap_login();
            }
            return false;
        });
    });
</script>