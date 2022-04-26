<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%
    request.setAttribute("path", request.getContextPath());
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!doctype html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <base href="<%=basePath%>">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>管理用户 - 异清轩博客管理系统</title>
    <jsp:include page="/WEB-INF/page/ini.jsp"></jsp:include>
    <style>
        .table-responsive {
            min-height: 77vh;
            overflow-x: auto;
        }

        textarea::-webkit-input-placeholder { /* WebKit browsers*/
            color: #A9A9A9;
        }

        textarea::-moz-placeholder { /* Mozilla Firefox 19+ */
            color: #A9A9A9;
        }

        textarea:-ms-input-placeholder {
            color: #A9A9A9;
        }

        .layer-input {
            width: 100%;
            border: 1px #ccc solid;
            padding: 3px;
        }
    </style>
</head>

<body class="user-select">
<section class="container-fluid">
    <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
    <div class="row">
        <jsp:include page="/WEB-INF/page/aside.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-lg-10 col-md-offset-2 main" id="main">
            <h1 class="page-header">管理 <span class="badge">2</span></h1>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th style="width: 5%"><span class="glyphicon glyphicon-check"></span> <span class="visible-lg">选择</span>
                        </th>
                        <th style="width: 10%"><span class="glyphicon glyphicon-user"></span> <span class="visible-lg">用户名</span>
                        </th>
                        <th style="width: 7%"><span class="glyphicon glyphicon-picture"></span> <span
                                class="visible-lg">头像</span></th>
                        <th style="width: 18%"><span class="glyphicon glyphicon-font"></span> <span class="visible-lg">签名</span>
                        </th>
                        <th style="width: 8%"><span class="glyphicon glyphicon-flag"></span> <span class="visible-lg">QQ_ID</span>
                        </th>
                        <th style="width: 12%"><span class="glyphicon glyphicon-lock"></span> <span class="visible-lg">Token</span>
                        </th>
                        <th style="width: 8%"><span class="glyphicon glyphicon-leaf"></span> <span class="visible-lg">QQ号</span>
                        </th>
                        <th style="width: 8%"><span class="glyphicon glyphicon-phone"></span> <span class="visible-lg">电话号</span>
                        </th>
                        <th style="width: 14%"><span class="glyphicon glyphicon-time"></span> <span class="visible-lg">注册时间</span>
                        </th>
                        <th style="width: 10%"><span class="glyphicon glyphicon-pencil"></span> <span
                                class="visible-lg">操作</span></th>
                    </tr>
                    </thead>
                    <tbody id="table-content">
                    <div class="loader">
                        <div class="loader-inner line-scale">
                            <div></div>
                            <div></div>
                            <div></div>
                            <div></div>
                            <div></div>
                        </div>
                    </div>
                    </tbody>
                </table>
            </div>
            <footer class="message_footer">
                <nav style="display: none">
                    <div class="btn-toolbar operation" role="toolbar">
                        <div class="btn-group" role="group"><a class="btn btn-default" onClick="select()">全选</a> <a
                                class="btn btn-default" onClick="reverse()">反选</a> <a class="btn btn-default"
                                                                                      onClick="noselect()">不选</a>
                        </div>
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-danger batchDeleting" title="批量删除"
                                    name="checkbox_delete">
                                删除
                            </button>
                        </div>
                    </div>
                    <%--<div id="demo7"></div>--%>
                    <ul class="pagination pagenav" id="pageTool">

                    </ul>
                    <input type="hidden" value="15" id="pageSize">
                    <input type="hidden" value="1" id="pageNo">
                    <input type="hidden" value="10" id="indexPageNo">
                    <input type="hidden" value="10" id="lastPageNo">
                    <input type="hidden" value="10" id="totalPages">

                </nav>
            </footer>
        </div>
    </div>
</section>
<!--查看用户详情-->
<div id="seeUserDetail" tabindex="1" role="dialog" style="display: none">
    <table class="table" style="margin-bottom:0px;">
        <tbody>

        <tr>
            <td wdith="20%">头像:</td>
            <td width="80%" class="update-input" id="portrait"><img src="" alt="" height='50px' width='50px' style='border-radius: 50%;background-size: cover'></td>
        </tr>
        <tr>
            <td wdith="20%">帐号编号:</td>
            <td width="80%" class="see-user-id" id="auths_id"></td>
        </tr>
        <tr>
            <td wdith="20%">用户编号:</td>
            <td width="80%" class="see-user-id" id="user_id"></td>
        </tr>
        <tr>
            <td wdith="20%">昵称:</td>
            <td width="80%" class="update-input" id="nickname"></td>
        </tr>
        <tr>
            <td wdith="20%">签名:</td>
            <td width="80%" class="update-input" id="autograph"></td>
        </tr>
        <tr>
            <td wdith="20%">QQ_ID:</td>
            <td width="80%" class="update-input" id="qq_id"></td>
        </tr>
        <tr>
            <td wdith="20%">Access_token:</td>
            <td width="80%" class="update-input" id="access_token"></td>
        </tr>
        <tr>
            <td wdith="20%">QQ号:</td>
            <td width="80%" class="update-input" id="qq_number"></td>
        </tr>
        <tr>
            <td wdith="20%">电话号:</td>
            <td width="80%" class="update-input" id="identifier"></td>
        </tr>
        <tr>
            <td wdith="20%">注册时间:</td>
            <td width="80%" class="see-register_time" id="register_time"></td>
        </tr>
        <tr>
            <td wdith="20%" style="border-bottom: 1px #ddd solid">状态:</td>
            <td width="80%" style="border-bottom: 1px #ddd solid" class="see-enable" id="enable"></td>
        </tr>
        </tbody>
    </table>
</div>
<jsp:include page="/WEB-INF/page/modal-box.jsp"></jsp:include>
<script src="${path}/background/js/bootstrap.min.js"></script>
<script src="${path}/background/js/admin-scripts.js"></script>
<script src="${path}/background/js/loadPage.js"></script>
<script>
    $(function () {
        $(".loader").show();
        load();

        function load() {
            var hash_page = window.location.hash.split("=")[1];
            hash_page = hash_page == undefined ? 1 : hash_page;
            $("#table-content").find("tr").remove();
            $(".loader").show();
            //封装请求参数
            var param = {};//定义值，后台获取
            param.pattern = $("#search").val();
            param.pageSize = $("#pageSize").val();//data.length获取初始化条数
            param.pageNo = hash_page;//当前页码
            param.sort = "user_id desc";//排序方式
            $.ajax({
                type: "post",
                url: "${path}/users/selectUsers",
                timeout: 10000,
                data: param,
                success: function (data) {
                    if (data == "" || data == null) {
                        layer.alert('系统错误，数据获取失败', {
                            icon: 2,
                            skin: 'layer-ext-moon',
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        }, function () {
                            layer.close(layer.index);
                            $("#table-content").append("<tr><td style='text-align: center' colspan=10>数据获取失败，请稍后再试！</td></tr>");
                            $(".loader").hide();
                        });
                        return false;
                    }
                    if (data.totalRecords == 0) {
                        $("#table-content").append("<tr><td style='text-align: center' colspan=10>暂无数据！</td></tr>");
                        $(".loader").hide();
                        return false;
                    }
                    $(".loader").hide();
                    $(".message_footer nav").hide();
                    $.pageInit({
                        totalPages: data.totalPages,
                        totalRecords: data.totalRecords,
                        pageNo: data.pageNo,
                        pageSize: data.pageSize,
                        jumpPage: 1,
                        nextPageNo: data.nextPageNo,
                        previousPageNo: data.previousPageNo,
                        callback: loadData
                    });
                    $.each(data.data, function (index, item) {
                        var autograph = item.autograph, enable = "";
                        autograph = autograph.length > 50 ? autograph.substring(0, 50) + "..." : autograph;
                        enable = item.enable == 1 ? "<a class='switch' rel=" + item.user_id + " data-type='disableUser'>禁用</a>" : "<a class='switch' rel=" + item.user_id + " data-type='enableUser'>启用</a>";
                        $("#table-content").append("<tr>" +
                            "<td><input type='checkbox' class='input-control' name='checkbox[]' value='" + item.user_id + "'/></td>" +
                            "<td class='user-nickname'>" + item.nickname + "</td>" +
                            "<td><img height='50px' width='50px' style='border-radius: 50%;background-size: cover' src='"+item.portrait+"' alt='头像'></td>" +
                            "<td>" + autograph + "</td>" +
                            "<td>" + item.qq_id + "</td>" +
                            "<td>" + item.access_token + "</td>" +
                            "<td>" + item.qq_number + "</td>" +
                            "<td>" + item.identifier + "</td>" +
                            "<td>" + item.register_time + "</td>" +
                            "<td><a class='detailUser' rel='" + item.user_id + "' title='查看详情'>查看</a> <a class='deleteUser' rel=" + item.user_id + ">删除</a> " + enable + "</td></tr>");
                    });
                    $("#pageNo").val(data.pageNo);
                    $("#indexPageNo").val(data.indexPageNo);
                    $("#lastPageNo").val(data.lastPageNo);
                    $("#totalPages").val(data.totalPages);
                    /*改变每页浏览条数*/
                    $("#selectNum").change(function () {
                        $("#pageSize").val($(this).val());
                        load();
                    });
                }, complete: function (XMLHttpRequest, status) {
                    if (status == "timeout") {
                        layer.alert('网络异常，数据获取失败', {
                            icon: 2,
                            skin: 'layer-ext-moon',
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        }, function () {
                            layer.close(layer.index);
                            $("#table-content").append("<tr><td style='text-align: center' colspan=10>数据获取失败，请稍后再试！</td></tr>");
                            $(".loader").hide();
                        });
                    } else if (status == "error") {
                        layer.alert('系统错误，数据获取失败', {
                            icon: 2,
                            skin: 'layer-ext-moon',
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        }, function () {
                            layer.close(layer.index);
                            $("#table-content").append("<tr><td style='text-align: center' colspan=10>数据获取失败，请稍后再试！</td></tr>");
                            $(".loader").hide();
                        });
                    }
                }
            });
        }

        /**
         * 加载数据(不重置分页条)
         *
         * @method loadData
         * @param search 模糊查询内容
         * @param pageNo 当前页码每也浏览条数
         * @param pageSize
         * */
        function loadData(search, pageNo, pageSize) {
            $("#table-content").find("tr").remove();
            $(".loader").show();
            //封装请求参数
            var param = {};//定义值，后台获取
            param.pattern = search;
            param.pageSize = pageSize;//data.length获取初始化条数
            param.pageNo = pageNo;//当前页码
            param.sort = "user_id desc";//排序方式
            $.ajax({
                type: "post",
                url: "${path}/users/selectUsers",
                timeout: 10000,
                data: param,
                success: function (data) {
                    if (data == "" || data == null) {
                        layer.alert('系统错误，数据获取失败', {
                            icon: 2,
                            skin: 'layer-ext-moon',
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        }, function () {
                            layer.close(layer.index);
                            $("#table-content").append("<tr><td style='text-align: center' colspan=5>数据获取失败，请稍后再试！</td></tr>");
                            $(".loader").hide();
                        });
                        return false;
                    }
                    if (data.length == 0) {
                        $("#table-content").append("<tr><td style='text-align: center' colspan=5>暂无数据！</td></tr>");
                        $(".loader").hide();
                        return false;
                    }
                    $(".loader").hide();
                    $.each(data.data, function (index, item) {
                        var autograph = item.autograph, enable = "";
                        autograph = autograph.length > 50 ? autograph.substring(0, 50) + "..." : autograph;
                        enable = item.enable == 1 ? "<a class='switch' rel=" + item.user_id + " data-type='disableUser'>禁用</a>" : "<a class='switch' rel=" + item.user_id + " data-type='enableUser'>启用</a>";
                        $("#table-content").append("<tr>" +
                            "<td><input type='checkbox' class='input-control' name='checkbox[]' value='" + item.user_id + "'/></td>" +
                            "<td class='user-nickname'>" + item.nickname + "</td>" +
                            "<td><img height='50px' width='50px' style='border-radius: 50%;background-size: cover' src='"+item.portrait+"' alt='头像'></td>" +
                            "<td>" + autograph + "</td>" +
                            "<td>" + item.qq_id + "</td>" +
                            "<td>" + item.access_token + "</td>" +
                            "<td>" + item.qq_number + "</td>" +
                            "<td>" + item.identifier + "</td>" +
                            "<td>" + item.register_time + "</td>" +
                            "<td><a class='detailUser' rel='" + item.user_id + "' title='查看详情'>查看</a> <a class='deleteUser' rel=" + item.user_id + ">删除</a> " + enable + "</td></tr>");
                    });
                    $(".prevPage").attr("rel", data.previousPageNo);
                    $(".nextPage").attr("rel", data.nextPageNo);
                    $("#pageNo").val(data.pageNo);
                    $("#indexPageNo").val(data.indexPageNo);
                    $("#lastPageNo").val(data.lastPageNo);
                    $("#totalPages").val(data.totalPages);
                    if (data.pageNo == data.indexPageNo) {
                        $(".prevPage").parent().addClass("disabled");
                    } else {
                        $(".prevPage").parent().removeClass("disabled");
                    }
                    if (data.pageNo == data.lastPageNo) {
                        $(".nextPage").parent().addClass("disabled");
                    } else {
                        $(".nextPage").parent().removeClass("disabled");
                    }

                }, complete: function (XMLHttpRequest, status) {
                    if (status == "timeout") {
                        layer.alert('网络异常，数据获取失败', {
                            icon: 2,
                            skin: 'layer-ext-moon',
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        }, function () {
                            layer.close(layer.index);
                            $("#table-content").append("<tr><td style='text-align: center' colspan=5>数据获取失败，请稍后再试！</td></tr>");
                            $(".loader").hide();
                        });
                    } else if (status == "error") {
                        layer.alert('系统错误，数据获取失败', {
                            icon: 2,
                            skin: 'layer-ext-moon',
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        }, function () {
                            layer.close(layer.index);
                            $("#table-content").append("<tr><td style='text-align: center' colspan=5>数据获取失败，请稍后再试！</td></tr>");
                            $(".loader").hide();
                        });
                    }
                }
            });
        }

        /**
         * [禁用][启用]
         *
         * */
        $('body').on('click', '.switch', function () {
            var event = $(this);
            var user_id = $(this).attr("rel"), data_type = $(this).attr("data-type"), title = "", url = "";
            if (data_type == "disableUser") {
                title = "禁用";
                url = "${path}/users/disEnableUser";
            } else if (data_type == "enableUser") {
                title = "启用";
                url = "${path}/users/enableUser";
            }
            layer.confirm('确认' + title + '该用户？', {
                icon: 3,
                title: '警告',
                skin: 'layer-ext-moon',
                btn: ['确认', '取消'],
                shade: 0.01,
                zIndex: layer.zIndex,
                success: function (layero) {
                    layer.setTop(layero);
                }
            }, function () {
                layer.msg('正在' + title + '', {
                    icon: 16,
                    shade: 0.1,
                    time: 10000,
                    shade: 0.01,
                    zIndex: layer.zIndex,
                    success: function (layero) {
                        layer.setTop(layero);
                    }
                });
                ajaxEnable(title, user_id, url, event);
            }, function () {
                layer.close(layer.index);
            });

        });

        /**
         *启用/禁用方法封装
         *
         * */
        function ajaxEnable(title, param, url, event) {
            $.ajax({
                type: "post",
                url: url,
                timeout: 10000,
                data: {user_id: param},
                success: function (data) {
                    if (data == "true") {
                        if (event.attr("data-type") == "disableUser") {
                            event.text("启用").attr("data-type", "enableUser");
                        } else if (event.attr("data-type") == "enableUser") {
                            event.text("禁用").attr("data-type", "disableUser");
                        }
                        layer.msg("" + title + "成功", {
                            icon: 1,
                            time: 1000,
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        }, function () {
                            layer.closeAll();
                        });
                    } else {
                        layer.alert('' + title + '失败', {
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
                        layer.alert('系统错误，' + title + '失败', {
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

        /**
         * 删除用户
         *
         * */
        $("body").on('click', '.deleteUser', function () {
            var id = $(this).attr("rel");
            layer.confirm('确认删除？', {
                icon: 3,
                title: '警告',
                skin: 'layer-ext-moon',
                btn: ['确认', '取消'], //按钮
                shade: 0.01,
                zIndex: layer.zIndex,
                success: function (layero) {
                    layer.setTop(layero);
                }
            }, function () {
                layer.msg('正在删除', {
                    icon: 16,
                    shade: 0.1,
                    time: 10000,
                    shade: 0.01,
                    zIndex: layer.zIndex,
                    success: function (layero) {
                        layer.setTop(layero);
                    }
                });
                ajaxDelete(id);
            }, function () {
                layer.close(layer.index);
            });
        });

        /**
         * 批量删除
         *
         * */
        $("body").on('click', '.batchDeleting', function () {
            var event = $("input[type='checkbox'][class='input-control']:checked");
            var ids = "";
            if (event.length == 0) {
                layer.msg("请选择删除项", {time: 1000});
                return false;
            }
            layer.confirm('确认删除？', {
                icon: 3,
                title: '警告',
                skin: 'layer-ext-moon',
                btn: ['确认', '取消'],
                shade: 0.01,
                zIndex: layer.zIndex,
                success: function (layero) {
                    layer.setTop(layero);
                }
            }, function () {
                layer.msg('正在删除', {
                    icon: 16,
                    shade: 0.1,
                    time: 10000,
                    shade: 0.01,
                    zIndex: layer.zIndex,
                    success: function (layero) {
                        layer.setTop(layero);
                    }
                });
                $.each(event, function (index, item) {
                    ids += ($(item).val()) + ",";
                });
                ajaxDelete(ids);
            }, function () {
                layer.close(layer.index);
            });
        });

        /**
         *删除方法封装
         *
         * */
        function ajaxDelete(param) {
            $.ajax({
                type: "post",
                url: '${path}/users/deleteUsers',
                timeout: 10000,
                data: {ids: param},
                success: function (data) {
                    if (data == "true") {
                        layer.msg("删除成功", {
                            icon: 1,
                            time: 1000,
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        }, function () {
                            load();
                            layer.closeAll();
                        });
                    } else {
                        layer.alert('删除失败', {
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
                        layer.alert('系统错误，删除失败', {
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

        $('body').on('click', '.detailUser', function () {
            var event = $(this);
            if (event.attr("data-user") == 1)
                return false;
            event.attr("data-user", '1');
            var user_id = event.attr("rel");
            var title = event.parent().parent().find('.user-nickname').text();
            title = title.length > 10 ? title.substring(0, 10) + "..." : title;
            $.ajax({
                type: "post",
                url: "${path}/users/seeUser",
                timeout: 10000,
                data: {users_id: user_id},
                success: function (data) {
                    $.each(data[0], function (index, item) {
                        if (index == "enable" && item == "1")
                            $("#" + index + "").text("已开启");
                        else if (index == "enable" && item == "0")
                            $("#" + index + "").text("已禁用");
                        else if (index == "portrait")
                            $("#" + index + "").find("img").attr("src", item).attr("alt", "头像");
                        else
                            $("#" + index + "").text(item);
                    });
                    seeUser(event, title);
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
                            $("#reply-content").append("<tr><td style='text-align: center' colspan=5>数据获取失败，请稍后再试！</td></tr>");
                            $(".loader").hide();
                        });
                    } else if (status == "error") {
                        layer.alert('系统错误，查看失败', {
                            icon: 2,
                            skin: 'layer-ext-moon',
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        }, function () {
                            layer.close(layer.index);
                            $("#reply-content").append("<tr><td style='text-align: center' colspan=5>数据获取失败，请稍后再试！</td></tr>");
                            $(".loader").hide();
                        });
                    }
                }
            });
        });

        /**
         * 打开用户详情方法
         *
         * */
        function seeUser(event, title) {
            var seeMessage = $("#seeUserDetail").html(), layer_info;
            var p_index = layer.open({
                type: 1
                , content: seeMessage
                , title: '查看用户(' + title + ')'
                , area: ['620px', '470px']
                , shade: 0
                , maxmin: true
                , btn: ['修改', '知道了']
                , yes: function (index, layero) {
                    var _type = layero.find(".layui-layer-btn0").attr("data-type");
                    if (_type == "save") {
                        var data = new Map();
                        data.set('auths_id', layero.find("#auths_id").text());
                        data.set('user_id', layero.find("#user_id").text());
                        data.set('nickname', layero.find("#nickname").children(".layer-input").val());
                        data.set('portrait', layero.find("#portrait").children(".layer-input").val());
                        data.set('autograph', layero.find("#autograph").children(".layer-input").val());
                        data.set('qq_id', layero.find("#qq_id").children(".layer-input").val());
                        data.set('access_token', layero.find("#access_token").children(".layer-input").val());
                        data.set('qq_number', layero.find("#qq_number").children(".layer-input").val());
                        data.set('identifier', layero.find("#identifier").children(".layer-input").val());
                        updateUser(data, p_index);
                    } else {
                        layer_info = layero;
                        $.each(layero.find(".update-input"), function (_index, _item) {
                            if ($(_item).attr("id") == "portrait") {
                                $(_item).html("<input type='text' class='layer-input' placeholder='不能为空' data-backup='" + $(_item).find("img").attr("src") + "' value='" + $(_item).find("img").attr("src") + "'/>")
                            } else {
                                $(_item).html("<input type='text' class='layer-input' placeholder='不能为空' data-backup='" + $(_item).text() + "' value='" + $(_item).text() + "'/>")
                            }

                        });
                        layero.find(".layui-layer-btn0").text("保存").attr("data-type", "save");
                        layero.find(".layui-layer-btn1").text("取消").attr("data-type", "cancel");
                    }
                }
                , btn2: function (index, layero) {
                    var _type = layero.find(".layui-layer-btn1").attr("data-type");
                    if (_type == "cancel") {
                        $.each(layero.find(".update-input"), function (_index, _item) {
                            if ($(_item).attr("id") == "portrait") {
                                $(_item).html("<img height='50px' width='50px' style='border-radius: 50%;background-size: cover' src='" + $(_item).find("input").attr("data-backup") + "' alt='头像'>");
                            } else {
                                $(_item).text("" + $(_item).find("input").attr("data-backup") + "");
                            }

                        });
                        layero.find(".layui-layer-btn0").text("修改").attr("data-type", "");
                        layero.find(".layui-layer-btn1").text("知道了").attr("data-type", "");
                        return false;
                    } else {
                        layer.close(p_index);
                        event.attr("data-message", "0");
                    }
                }
                , zIndex: layer.zIndex //重点1
                , success: function (layero) {
                    layer.setTop(layero); //重点2
                }
                , end: function () {
                    event.attr("data-user", "0");
                }
            });
        }

        /**
         * 修改用户
         *
         * */
        function updateUser(param, p_index) {
            var _param = {};
            _param.user_id = param.get("user_id");
            _param.nickname = param.get("nickname");
            _param.portrait = param.get("portrait");
            _param.autograph = param.get("autograph");
            _param.auths_id = param.get("auths_id");
            _param.qq_id = param.get("qq_id");
            _param.access_token = param.get("access_token");
            _param.qq_number = param.get("qq_number");
            _param.identifier = param.get("identifier");
            layer.msg('正在修改', {
                icon: 16,
                shade: 0.01,
                time: 10000,
                zIndex: layer.zIndex,
                success: function (layero) {
                    layer.setTop(layero);
                }
            });
            $.ajax({
                type: "post",
                url: "${path}/users/updateUser",
                timeout: 10000,
                data: _param,
                success: function (data) {
                    if (data == "true") {
                        layer.msg("修改成功", {
                            icon: 1,
                            time: 1000,
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        }, function () {
                            load();
                            layer.close(layer.index);
                            layer.close(p_index);
                        });
                    } else {
                        layer.alert('修改失败', {
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
                        layer.alert('网络异常，回复失败', {
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
                        layer.alert('系统错误，数据获取失败', {
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

    });
</script>
</body>
</html>
