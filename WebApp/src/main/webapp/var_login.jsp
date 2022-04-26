<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%
    request.setAttribute("path", request.getContextPath());
%>
<!--登录注册框-->
<div class="f-sign hide">
    <div class="sign">
        <span class="remove-sign">
            <i class="fa fa-plus-circle"></i>
        </span>
        <h4 class="title">
            <div class="normal-title">
                <a class="active">登录</a>
                <b>·</b>
                <a id="js-sign-up-btn" class="">注册</a>
            </div>
        </h4>
        <div style="overflow: hidden;">
            <ul class="banner banner-move">
                <li class="banner-sub">
                    <form id="sub_login" action="${path}/users/login" accept-charset="UTF-8" method="post">
                        <div class="input-prepend restyle">
                            <input id="account" name="identifier" type="tel" placeholder="手机号" required>
                            <i class="fa fa-user"></i>
                        </div>
                        <div class="input-prepend">
                            <input id="password" name="credential" type="password" placeholder="密码" required>
                            <i class="fa fa-lock"></i>
                        </div>
                        <div id="geetest-area">
                            <p id="wait" class="wait show">正在加载验证码......</p>
                        </div>
                        <br>
                        <div class="remember-btn">
                            <label><input type="checkbox" value="true" checked="checked" name="session[remember_me]"
                                          id="session_remember_me"><span>记住我</span></label>
                        </div>
                        <input id="login" type="submit" name="commit" value="登录" class="sign-in-button"
                               data-disable-with="登录">
                    </form>
                    <div class="more-sign">
                        <h6>社交帐号登录</h6>
                        <ul>
                            <li><a class="qq qqlogin" href="${path}/users/qqLogin"><i class="fa fa-qq"></i></a></li>
                        </ul>
                    </div>
                </li>
                <li class="banner-sub">
                    <form id="register" action="${path}/users/register" accept-charset="UTF-8" method="post">
                        <div class="input-prepend restyle">
                            <input type="hidden" id="signNameState">
                            <input id="signName" type="text" name="nickname" placeholder="你的昵称" required>
                            <i class="fa fa-user fa-fw"></i>
                        </div>
                        <div class="input-prepend restyle">
                            <input id="signAccont" type="tel" name="identifier" placeholder="电话号" required
                                   oninput="checkNum($(this));">
                            <i class="fa fa-phone fa-fw"></i>
                        </div>
                        <div class="input-prepend restyle hide">
                            <input id="code" type="tel" name="code" placeholder="验证码" required>
                            <i class="fa fa-info fa-fw"></i>
                            <a <%--tabindex="-1"--%> class="btn-up-resend js-send-code-button disable">发送验证码</a>
                        </div>
                        <div class="input-prepend">
                            <input id="signPassword" type="password" name="credential" placeholder="密码" required>
                            <i class="fa fa-lock fa-fw"></i>
                        </div>
                        <input id="sign" type="submit" name="commit" value="注册" class="sign-in-button"
                               data-disable-with="注册">
                    </form>
                    <div style="height: 15px;margin: 10px 0;"></div>
                    <div class="more-sign register">
                        <h6>社交帐号注册</h6>
                        <ul>
                            <li><a class="qq qqlogin" href="${path}/users/qqLogin"><i class="fa fa-qq"></i></a></li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
<script>

    var name_reg = /^1[3|4|5|6|7|8][0-9]{9}$/;
    var handler = function (captchaObj) {
        // 登录
        $("body").on("click", "#login", function (event) {
            var result = captchaObj.getValidate();
            var _account = $("#account").val();
            var _password = $("#password").val();
            if (_account == "" || _account == null) {
                layer.tips('输入帐号', '#account', {tips: [2, '#3595CC']});
                return false;
            } else if (_password == "" || _password == null) {
                layer.tips('密码是必须的', '#password', {tips: [2, '#3595CC']});
                return false;
            } else if (!result) {
                $("#login").removeClass("disable");
                layer.tips('请先完成验证', '#geetest-area', {tips: [2, '#3595CC']});
                return false;
            }
            $("#login").addClass("disable");
        });
        // 将验证码加到id为geetest-area的元素里，同时会有三个input的值用于表单提交
        captchaObj.appendTo("#geetest-area");
        captchaObj.onReady(function () {
            $("#wait").attr("class", "hide");
        });
        // 更多接口参考：http://www.geetest.com/install/sections/idx-client-sdk.html
    };

    //急验
    $.ajax({
        url: "${path}/login/init", // 加随机数防止缓存
        type: "post",
        dataType: "json",
        success: function (data) {
            // 调用 initGeetest 初始化参数
            // 参数1：配置参数
            // 参数2：回调，回调的第一个参数验证码对象，之后可以使用它调用相应的接口
            initGeetest({
                gt: data.gt,
                challenge: data.challenge,
                new_captcha: data.new_captcha, // 用于宕机时表示是新验证码的宕机
                offline: !data.success, // 表示用户后台检测极验服务器是否宕机，一般不需要关注
                product: "float", // 产品形式，包括：float，popup
                width: "100%"
                // 更多配置参数请参见：http://www.geetest.com/install/sections/idx-client-sdk.html#config
            }, handler);
        }
    });

    //注册
    $("body").on("click", "#sign", function () {
        var signAccont = $("#signAccont").val();
        var signPassword = $("#signPassword").val();
        var signNameState = $("#signNameState").val();
        if (signNameState != "" && signNameState == "exist") {
            layer.tips('昵称已被使用', '#signName', {tips: [2, '#cc6d62'], tipsMore: true});
            return false;
        }
        if (signAccont != "" && !name_reg.test(signAccont)) {
            layer.tips('请输入正确的号码', '#signAccont', {tips: [2, '#cc6d62'], tipsMore: true});
            return false;
        }
        if (signPassword != "" && signPassword.length < 6) {
            layer.tips('密码必须大于6位数', '#signPassword', {tips: [2, '#cc6d62'], tipsMore: true});
            return false;
        }
    });

    $("#signName").blur(function () {
        var signName = $(this).val();
        if (signName != "" && signName != null) {
            checkNickName(signName, function (data) {
                if (data == "true") {
                    layer.tips('昵称已被使用', '#signName', {tips: [2, '#cc6d62'], tipsMore: true});
                    $("#signNameState").val("exist");
                } else {
                    $("#signNameState").val("");
                }
            });
        }
    });
    $("#signAccont").blur(function () {
        var signAccont = $(this).val();
        if (signAccont != "" && !name_reg.test(signAccont)) {
            layer.tips('请输入正确的号码', '#signAccont', {tips: [2, '#cc6d62'], tipsMore: true});
        }

    });

    $("#signPassword").blur(function () {
        var signPassword = $(this).val();
        if (signPassword != "" && signPassword.length < 6) {
            layer.tips('密码必须大于6位数', '#signPassword', {tips: [2, '#cc6d62'], tipsMore: true});
        }
    });

    var time = 60;
    $(".js-send-code-button").click(function () {
        var _this = $(this);
        _this.addClass("disable");
        var _phoneNum = $("#signAccont").val();
        $.ajax({
            type: "post",
            url: "${path}/verifi/sendMag",
            timeout: 20000,
            data: {phoneNum: _phoneNum},
            success: function (data) {
                if (data == "true") {
                    layer.msg("验证码发送成功，请查收", {offset: '80%'});
                    var timer = setInterval(function () {
                        _this.text("重新发送(" + time + "s)");
                        if (time == 0) {
                            clearInterval(timer);
                            _this.removeClass("disable");
                            _this.text("发送验证码");
                            time = 60;
                        } else {
                            time--;
                        }
                    }, 1000);

                } else if (data == "wait") {
                    layer.msg("请一分钟后再试", {offset: '80%'});
                } else {
                    layer.msg("验证码发送失败", {offset: '80%'});
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
                    layer.alert('短信发送失败，都是我的锅！', {
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
    $("body").on("click", ".normal-title a", function () {
        $(this).addClass("active").siblings().removeClass("active");
        var index = $(this).index();
        index = index == 2 ? 1 : index;
        var left = -index * (100) + "%";
        $(".banner").css("marginLeft", left);
    });

    /**
     * 登录回调
     * */
    $("#sub_login").ajaxForm({
        success: function (data) {
            if (data == "1") {
                $("#login").addClass("disable");
                layer.msg("登录成功", {offset: '80%', time: 1000}, function () {
                    location.reload();
                });
            } else if (data == "-3") {
                layer.msg("服务器异常", {offset: '80%'});
                $("#login").removeClass("disable");
            } else if (data == "-2") {
                layer.msg("用户名或密码错误", {offset: '80%'});
                $("#login").removeClass("disable");
            } else if (data == "-4") {
                layer.msg("该用户已被禁用", {offset: '80%'});
                $("#login").removeClass("disable");
            } else if (data == "-1") {
                layer.msg("登录失败,请重新登录", {offset: '80%'});
                $("#login").removeClass("disable");
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
                $("#login").removeClass("disable");
            } else if (status == "error") {
                layer.alert('登录失败了，都是我的锅', {
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
                $("#login").removeClass("disable");
            }
        }
    });

    /**
     * 注册回调
     * */
    $("#register").ajaxForm({
        success: function (data) {
            if (data == "true") {
                $("#sign").addClass("disable");
                layer.msg("注册成功,正在跳转", {offset: '80%', time: 1000}, function () {
                    location.reload();
                });
            } else if (data == "telError") {
                layer.msg("电话号码错误", {offset: '80%'});
            } else if (data == "timeOut") {
                layer.msg("验证码已过期，请重新获取", {offset: '80%'});
            } else if (data == "codeError") {
                layer.msg("验证码错误", {offset: '80%'});
            } else if (data == "n_exist") {
                layer.msg("该昵称已存在", {offset: '80%'});
            } else if (data == "i_exist") {
                layer.msg("该帐号已存在", {offset: '80%'});
            } else if (data == "error") {
                layer.alert('注册失败了...', {
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
                layer.alert('注册失败了，都是我的锅', {
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

    function checkNickName(signName, callback) {
        $.ajax({
            type: "post",
            url: "${path}/users/selectByNickName",
            timeout: 10000,
            data: {nickname: signName},
            success: function (data) {
                callback(data)
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
                    layer.alert('出现了点意外，请稍后再试', {
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
    }

    function checkNum(event) {
        if (event.val().length == 11) {
            $("#code").parent().removeClass("hide");
        }
        if (event.val().length == 11 && name_reg.test(event.val())) {
            $("#code").nextAll("a").removeClass("disable");
        } else {
            $("#code").nextAll("a").addClass("disable");
        }
    }
</script>