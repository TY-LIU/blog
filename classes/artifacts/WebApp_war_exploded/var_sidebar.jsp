<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%
    request.setAttribute("path", request.getContextPath());
%>
<!--侧栏样式-->
<div class="sidebar">
    <div class="sidebar-container">
        <!--头像,昵称,签名-->
        <div class="sidebar-container-head">
            <!--头像-->
            <div class="sidebar-container-head-tx">
                <img src="${path}/img/touxiang.png" alt="头像">
                <div class="sidebar-container-head-tx-mask">点击修改</div>
                <input type="file" id="file"
                       style="cursor: pointer;opacity: 0;filter: alpha(opacity=0);width: 100%;height: 100%;position: relative;top: -170px;">
            </div>
            <!--昵称，签名-->
            <div class="sidebar-container-head-nn">
                <div class="sideber-user-name">
                    <em>

                    </em>
                    <i class="fa fa-edit"></i>
                </div>
                <div class="sideber-user-ag">
                    <input type="text" placeholder="说点什么" data-ag="" value="">
                </div>
            </div>
            <!--注销-->
            <div class="sidebar-container-head-out">
                <a class="loginOut" href="javascript:void(0);"><i class="fa fa-sign-out"></i>注销</a>
                <a class="back" href="javascript:void(0);"><i class="fa fa-sign-out"></i>返回</a>
            </div>
        </div>
        <!--个人评论区-->
        <div class="user-comment">
            <ul class="user-comment-label">
                <li class="active">
                    <div class="user-comment-label-item message">
                        留言
                    </div>
                </li>
                <li>
                    <div class="user-comment-label-item reply">
                        回复
                    </div>
                </li>
            </ul>
            <div class="user-tab-active-bar" style="margin-left: 83px;"></div>
            <div class="user-comment-container">
                <ul class="user-tab-active-banner">
                    <!--评论-->
                    <li class="user-tab-banner-sub message">
                        <div class="user-page user-comment-page active" style="height: 780px">
                            <ul class="user-comment-list">

                            </ul>
                        </div>
                    </li>
                    <!--回复-->
                    <li class="user-tab-banner-sub reply">
                        <div class="user-page user-comment-page" style="height: 780px">
                            <ul class="user-comment-list">
                                
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <%--截图内容--%>
    <div class="cover-wrap">
        <div class="cover-wrap-content">
            <div class="clipArea" id="clipArea"></div>
            <div class="options">
                <button class="options-btn" id="clipBtn">
                    确认
                </button>
                <button class="options-btn" id="cancelBtn">
                    取消
                </button>
            </div>
        </div>
    </div>
    <div id="view" style="width:214px;height:160.5px;" title="请上传 350*350 的封面图片"></div>
</div>
<script src="${path}/assets/js/plugins/cover_js/iscroll-zoom.js" type="text/javascript" charset="utf-8"></script>
<script src="${path}/assets/js/plugins/cover_js/hammer.js" type="text/javascript" charset="utf-8"></script>
<script src="${path}/assets/js/plugins/cover_js/lrz.all.bundle.js" type="text/javascript" charset="utf-8"></script>
<script src="${path}/assets/js/plugins/cover_js/jquery.photoClip.min.js" type="text/javascript"
        charset="utf-8"></script>
<script>
    var loadReplyFlag=0;
    var userId = "${sessionScope.get("users").getUser_id()}";
    var pageNo = 0;
    var pageSize = 50;
    var param = {};//定义值
    param.pageSize = pageSize;
    param.pageNo = pageNo;//当前页码
    param.userId = userId;
    $.ajax({
        type: "post",
        url: "${path}/messageInfo/selectByUser",
        timeout: 20000,
        data: param,
        success: function (data) {
            $(".sidebar-container-head-tx img").attr("src", data.list[0].portrait);
            $(".sideber-user-name em").text(data.list[0].nickname);
            $(".sideber-user-ag input").val(data.list[0].autograph);
            $(".sideber-user-ag input").attr("data-ag", data.list[0].autograph);
            $(".user-comment-label .message").text(""+data.pageModel.totalRecords+" 评论");
            var _comment = "";
            if (data.pageModel.data == "" || data.pageModel.data == null) {
                _comment = "<li class='user-comment-list-sub'><div class='message_null'></div></li>";
                $(".message .user-comment-list").append(_comment);
                $(".message .user-comment-list").after("<div class='loadFlag'>暂无数据</div>");
                return false;
            }
            $.each(data.pageModel.data, function (index, item) {
                _comment += "<li class='user-comment-list-sub' id='sub-" + item.message_id + "'>" +
                    " <div class='my-comment-photo'>" +
                    "     <img src='" + item.portrait + "' alt='头像'>" +
                    " </div>" +
                    " <div class='user-my-comment-container'>" +
                    "     <div class='user-my-comment-username'>" + item.nickname + "" +
                    "         <span class='del' data-userid='" + item.user_id + "' data-id='" + item.message_id + "'><i class='fa fa-trash-o'></i>删除</span>" +
                    "     </div>" +
                    "     <p class='user-my-comment-detail'>" + item.message_content + "</p>" +
                    "     <a class='user-my-comment-detail-rec' href='"+item.message_url+"'>"+item.urlTitle+"</a>" +
                    "     <div class='user-my-comment-info'>" +
                    "         <span class='user-my-comment-from'>ltycv.com</span>" +
                    "         <span class='user-my-comment-puttime'>" +
                    "     <i class='fa fa-clock-o'></i>" +
                    "     <span>" + item.message_time + "</span>" +
                    " </span>" +
                    "     </div>" +
                    " </div>" +
                    "</li>";
            });

            $(".message .user-comment-list").append(_comment);
            $(".message .user-comment-list").after("<div class='loadFlag'>加载完成</div>");
            /*$(".normal-comment-list").append(_comment);
            $(".normal-comment-list").find(".comments-placeholder").css("display", "none");
            $("#pageTool").show();
            $(".prevPage").attr("rel", pageModel.previousPageNo);
            $(".nextPage").attr("rel", pageModel.nextPageNo);
            $("#pageNo").val(pageModel.pageNo);*/
        }, complete: function (XMLHttpRequest, status) {
            if (status == "timeout") {
                layer.msg('网络异常，请稍后再试', {
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
                layer.msg('出现了意外，请重试', {
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

    var clipArea = new bjj.PhotoClip("#clipArea", {
        size: [350, 350],// 截取框的宽和高组成的数组。默认值为[260,260]
        outputSize: [350, 350], // 输出图像的宽和高组成的数组。默认值为[0,0]，表示输出图像原始大小
        //outputType: "jpg", // 指定输出图片的类型，可选 "jpg" 和 "png" 两种种类型，默认为 "jpg"
        file: "#file", // 上传图片的<input type="file">控件的选择器或者DOM对象
        view: "#view", // 显示截取后图像的容器的选择器或者DOM对象
        ok: "#clipBtn", // 确认截图按钮的选择器或者DOM对象
        loadStart: function () {
            // 开始加载的回调函数。this指向 fileReader 对象，并将正在加载的 file 对象作为参数传入
            $('.cover-wrap').fadeIn();
            layer.msg('图片读取中', {
                icon: 16,
                shade: 0.001,
                time: 10000,
                shade: 0.01,
                zIndex: layer.zIndex,
                success: function (layero) {
                    layer.setTop(layero);
                }
            });
        },
        loadComplete: function () {
            // 加载完成的回调函数。this指向图片对象，并将图片地址作为参数传入
            layer.closeAll();
        },
        loadError: function (event) {
            layer.closeAll();
            layer.msg('修改失败', {
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
        }, // 加载失败的回调函数。this指向 fileReader 对象，并将错误事件的 event 对象作为参数传入
        clipFinish: function (dataURL) {
            // 裁剪完成的回调函数。this指向图片对象，会将裁剪出的图像数据DataURL作为参数传入
            $('.cover-wrap').fadeOut();
            $('#view').css('background-size', '100% 100%');
            $(".sidebar-container-head-tx img").attr("src", dataURL);
            var param = {};//定义值
            param.user_id = userId;
            param.portrait = dataURL;
            param.nickname = "";
            param.autograph = "";
            editUser(param);

        }
    });

    //更改昵称
    $("body").find(".sideber-user-name i").off("click").on("click", function () {
        var _class = $(this).attr("class");
        var _name = $(this).prev("em").text();
        if (_class == "fa fa-edit") {
            $(this).attr("class", "fa fa-check");
            $(this).prev("em").html("<input type='text' data-name='" + _name + "' value='" + _name + "'/>");
        } else {
            var _input = $(this).prev("em").find("input");
            $(this).prev("em").html($(this).prev("em").find("input").val());
            $(this).attr("class", "fa fa-edit");
            if ($.trim(_input.val()) != $.trim(_input.attr("data-name"))) {
                var param = {};//定义值
                param.user_id = userId;
                param.nickname = $.trim(_input.val());
                param.portrait = "";
                param.autograph = "";
                editUser(param);
            }
        }
    });

    //删除
    $("body").on("click", ".user-page .user-comment-list .del",fn =function () {
        if ("${sessionScope.get("users").getUser_id()}" == "") {
            layer.msg('你还没有登录嗷', {
                offset: '80%', icon: 7,
                skin: 'layer-ext-moon',
                shade: 0.001, time: 1500
            });
        } else {
            var _userId = $(this).attr("data-userid");
            var _messageId = $(this).attr("data-id");
            layer.confirm('确认删除？', {
                btn: ['确认', '取消'] //按钮
            }, function () {
                delFunByUser("${path}/messageInfo/delMessage", _userId, _messageId, "message");
            }, function () {
                layer.close(layer.index);
            });
        }
        console.log($(this));
    });

    //注销
    $("body").find(".sidebar-container-head-out .loginOut").off("click").on("click", function () {
        layer.confirm('确认退出登录？', {
            btn: ['确认', '取消'] //按钮
        }, function () {
            window.location.href = "${path}/users/signOut";
        }, function () {
            layer.close(layer.index);
        });
    });

    // 签名
    $("body").find(".sideber-user-ag input").off("blur").on("blur", function () {
        if ("${sessionScope.get("users").getUser_id()}" == "") {
            layer.msg('你还没有登录嗷', {
                offset: '80%', icon: 7,
                skin: 'layer-ext-moon',
                shade: 0.001, time: 1500
            });
        } else {
            var _val = $(this).val();
            var _autograph = $(this).attr("data-ag");
            if (_val == "" || _val == null) {
                _val = "什么也没有";
            }
            if ($.trim(_val) != $.trim(_autograph)) {
                var param = {};//定义值
                param.user_id = userId;
                param.nickname = "";
                param.portrait = "";
                param.autograph = _val;
                editUser(param);
            }
        }
    });

    //取消图片截取
    $("body").find("#cancelBtn").off("click").on("click", function () {
        $('.cover-wrap').fadeOut();
    });

    //侧栏banner滑动
    $("body").find(".user-comment-label-item").off("click").on("click", function () {
        var offset = $(this)[0].offsetLeft;
        $(this).parent().addClass("active").siblings().removeClass("active");
        $(".user-tab-active-bar").css("margin-left", "" + offset + "px");
        var index = $(this).parent().index();
        index = index == 2 ? 1 : index;
        var left = -index * (100) + "%";
        $(".user-tab-active-banner").css("marginLeft", left);
        if(index==1){
            if(loadReplyFlag==0){
                loadReply(param);
                loadReplyFlag++;
            }
        }

    });

    /**
     * 查询用户被回复数据
     * */
    function loadReply(param) {
        $.ajax({
            type: "post",
            url: "${path}/m_replyInfo/selectByUser",
            timeout: 20000,
            data: param,
            success: function (data) {
                var _comment = "";
                if (data.data == "" || data.data == null) {
                    _comment = "<li class='user-comment-list-sub'><div class='message_null'></div></li>";
                    $(".reply .user-comment-list").append(_comment);
                    $(".reply .user-comment-list").after("<div class='loadFlag'>暂无数据</div>");
                    return false;
                }
                $.each(data.data, function (index, item) {
                    _comment += "<li class='user-comment-list-sub'>" +
                        "<div class='my-comment-photo'>" +
                        "<img src='"+item.portrait+"' alt='头像'>" +
                        "</div>" +
                        "<div class='user-my-comment-container'>" +
                        "<div class='user-my-comment-username' data-name='"+item.nickname+"'>" +
                        ""+item.nickname+"<p>回复了你：</p>" +
                        "</div>" +
                        "<p class='user-my-comment-detail'>"+item.reply_content+"</p>" +
                        "<div class='user-my-comment-detail-from'>" +
                        "<span>查看原消息：</span><a class='user-my-comment-detail-rec' href='"+item.message_url+"'>"+item.message_content+"</a></div>" +
                        "<div class='user-my-comment-info'>" +
                        "<span class='user-my-comment-from'>ltycv.com</span>" +
                        "<span class='user-my-comment-puttime'>" +
                        "<i class='fa fa-clock-o'></i> " +
                        "<span>"+item.reply_time+"</span>" +
                        "</span>" +
                        "</div>" +
                        "<div class='tool-group'>" +
                        /*"<a href='javascript:void(0);' class=''>" +
                        "<i class='fa fa-thumbs-o-up'></i>" +
                        "<span>1人赞</span>" +
                        "</a>" +*/
                        "<a href='javascript:void(0);' class='reply' data-id='"+item.message_id+"' data-userid='"+item.user_id+"'>" +
                        "<i class='fa fa-comment-o'></i>" +
                        "<span>回复</span>" +
                        "</a>" +
                        "</div>" +
                        "</div>" +
                        "</li>";
                });

                $(".reply .user-comment-list").append(_comment);
                $(".reply .user-comment-list").after("<div class='loadFlag'>加载完成</div>");
                /*$(".normal-comment-list").append(_comment);
                $(".normal-comment-list").find(".comments-placeholder").css("display", "none");
                $("#pageTool").show();
                $(".prevPage").attr("rel", pageModel.previousPageNo);
                $(".nextPage").attr("rel", pageModel.nextPageNo);
                $("#pageNo").val(pageModel.pageNo);*/
            }, complete: function (XMLHttpRequest, status) {
                if (status == "timeout") {
                    layer.msg('网络异常，请稍后再试', {
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
                    layer.msg('出现了意外，请重试', {
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
     * @method editUser 修改用户个人信息
     * @param 传入参数
     * */
    function editUser(param) {
        $.ajax({
            type: "post",
            url: "${path}/users/editByUser",
            timeout: 20000,
            data: param,
            success: function (data) {
                if (data == "" || data == null) {
                    layer.msg('修改失败', {
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
                } else if (data == "longName") {
                    layer.msg('用户名不能超过8个字', {
                        icon: 7,
                        offset: '80%',
                        time: 1500,
                        skin: 'layer-ext-moon',
                        shade: 0.01,
                        zIndex: layer.zIndex,
                        success: function (layero) {
                            layer.setTop(layero);
                        }
                    });
                } else if (data == "longAuto") {
                    layer.msg('签名不能超过50个字', {
                        icon: 7,
                        offset: '80%',
                        time: 1500,
                        skin: 'layer-ext-moon',
                        shade: 0.01,
                        zIndex: layer.zIndex,
                        success: function (layero) {
                            layer.setTop(layero);
                        }
                    });
                } else if (data == "exist") {
                    layer.msg('修改的用户名已经存在', {
                        icon: 7,
                        offset: '80%',
                        time: 1500,
                        skin: 'layer-ext-moon',
                        shade: 0.01,
                        zIndex: layer.zIndex,
                        success: function (layero) {
                            layer.setTop(layero);
                        }
                    });
                } else {
                    if (param.autograph != "") {
                        return false;
                    }
                    layer.msg('修改成功', {
                        icon: 1,
                        offset: '80%',
                        time: 1500,
                        skin: 'layer-ext-moon',
                        shade: 0.01,
                        zIndex: layer.zIndex,
                        success: function (layero) {
                            layer.setTop(layero);
                        }
                    }, function () {
                        window.location.reload();
                    });
                }
            }, complete: function (XMLHttpRequest, status) {
                if (status == "timeout") {
                    layer.msg('网络异常，请稍后再试', {
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
                    layer.msg('出现了意外，请重试', {
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
    function delFunByUser(url, userId, entityId, type) {
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
                    $("#comment-" + entityId + "").slideUp("fast", function () {
                        $(this).remove();
                    });
                    $("#sub-" + entityId + "").slideUp("fast", function () {
                        $(this).remove();
                        if ($(".message .user-comment-list").find("li").length == 0) {
                            $(".message .user-comment-list").append("<li class='user-comment-list-sub'><div class='message_null'></div></li>");
                            $(".message").find(".loadFlag").text("暂无数据");
                        }
                    });
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
                    layer.msg('出现了意外，删除失败', {
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
</script>