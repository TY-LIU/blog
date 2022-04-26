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
    <title>公告 - 异清轩博客管理系统</title>
    <jsp:include page="/WEB-INF/page/ini.jsp"></jsp:include>
    <style>
        .table-responsive {
            min-height: 65vh;
            overflow-x: auto;
        }
    </style>
</head>

<body class="user-select">
<section class="container-fluid">
    <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
    <div class="row">
        <jsp:include page="/WEB-INF/page/aside.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-lg-10 col-md-offset-2 main" id="main">
            <h1 class="page-header">操作</h1>
            <ol class="breadcrumb">
                <li><a href="javascript:void(0);" id="addNotice">添加公告</a></li>
            </ol>
            <form action="/Comment/checkAll" method="post">
                <h1 class="page-header">管理 <span class="badge">3</span></h1>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th><span class="glyphicon glyphicon-check"></span> <span class="visible-lg">选择</span>
                            </th>
                            <th><span class="glyphicon glyphicon-file"></span> <span class="visible-lg">标题</span></th>
                            <th><span class="glyphicon glyphicon-comment"></span> <span class="visible-lg">摘要</span>
                            </th>
                            <th><span class="glyphicon glyphicon-time"></span> <span class="visible-lg">日期</span></th>
                            <th><span class="glyphicon glyphicon-pencil"></span> <span class="visible-lg">操作</span></th>
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
                    <nav>
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
            </form>
        </div>
    </div>
</section>
<!--查看公告模态框-->
<div id="seenotice" tabindex="1" role="dialog" style="display: none">
    <table class="table" style="margin-bottom:0px;">
        <tbody>
        <tr>
            <td wdith="20%">公告ID:</td>
            <td width="80%" class="notice-id" id="notice_id"></td>
        </tr>
        <tr>
            <td wdith="20%">公告标题:</td>
            <td width="80%" class="see-notice-title" id="notice_title" rel=""></td>
        </tr>
        <tr>
            <td wdith="20%">公告内容:</td>
            <td width="80%" class="see-notice-content" id="notice_content"></td>
        </tr>
        <tr>
            <td wdith="20%" style="border-bottom: 1px #ddd solid">发布时间:</td>
            <td width="80%" style="border-bottom: 1px #ddd solid" class="see-put-time" id="put_time"></td>
        </tr>
        </tbody>
    </table>
</div>
<!--修改内容模态框-->
<div id="updateNotice" tabindex="1" role="dialog" style="display: none">
    <div style="width: 100%;padding: 20px 15px 0">
        <input type="hidden" id="update_notice_id" value="">
        <div>
            <span>公告标题:</span>
            <textarea id="update_notice_title" style="width: 100%;height: 80px;padding: 5px 10px;margin: 5px 0;border-color: #ddd"
                      autofocus
                      placeholder="说点什么吧"></textarea>
            <span style="float:right;font-size: 12px;color: gray;">500</span>
        </div>
        <div style="height: 20px"></div>
        <div>
            <span>公告内容:</span>
            <textarea id="update_notice_content" style="width: 100%;height: 140px;padding: 5px 10px;margin: 5px 0;border-color: #ddd"
                      autofocus
                      placeholder="说点什么吧"></textarea>
            <span style="float:right;font-size: 12px;color: gray;">1000</span>
        </div>
    </div>
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
            $.ajax({
                type: "post",
                url: "${path}/notice/selectNotice",
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
                    if (data.totalRecords == 0) {
                        $("#table-content").append("<tr><td style='text-align: center' colspan=5>暂无数据！</td></tr>");
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
                        var content = item.notice_content;
                        content = content.length > 50 ? content.substring(0, 50) + "..." : content;
                        $("#table-content").append("<tr>" +
                            "<td><input type='checkbox' class='input-control' name='checkbox[]' value='" + item.notice_id + "'/></td>" +
                            "<td class='notice-title'>" + item.notice_title + "</td>" +
                            "<td class='notice-content'>" + content + "</td>" +
                            "<td>" + item.put_time + "</td>" +
                            "<td><a class='detailNotice' rel='" + item.notice_id + "' title='查看详情'>查看</a> <a class='deleteNotice' rel=" + item.notice_id + ">删除</a></td></tr>");
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
            $.ajax({
                type: "post",
                url: "${path}/notice/selectNotice",
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
                        var content = item.notice_content;
                        content = content.length > 50 ? content.substring(0, 50) + "..." : content;
                        $("#table-content").append("<tr>" +
                            "<td><input type='checkbox' class='input-control' name='checkbox[]' value='" + item.notice_id + "'/></td>" +
                            "<td class='notice-title'>" + item.notice_title + "</td>" +
                            "<td class='notice-content'>" + content + "</td>" +
                            "<td>" + item.put_time + "</td>" +
                            "<td><a class='detailNotice' rel='" + item.notice_id + "' title='查看详情'>查看</a> <a class='deleteNotice' rel=" + item.notice_id + ">删除</a></td></tr>");
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
         * 添加公告
         *
         * */
        $("body").on('click', '#addNotice', function () {
            openAdd();
        });
        /**
         * 查看公告详情
         *
         * */
        $("body").on('click', '.detailNotice', function () {
            var event = $(this);
            if (event.attr("data-notice") == 1)
                return false;
            event.attr("data-notice", '1');
            var notice_id = event.attr("rel");
            var title = event.parent().parent().find('.notice-content').text();
            title = title.length > 10 ? title.substring(0, 10) + "..." : title;
            $.ajax({
                type: "post",
                url: "${path}/notice/detailNotice",
                timeout: 10000,
                data: {notice_id: notice_id},
                success: function (data) {
                    $.each(data, function (index, item) {
                        $("#" + index + "").text(item);
                    });
                    seeNotice(event, title);
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
                        });
                    }
                }
            });


        });


        /**
         * 删除公告
         *
         * */
        $("body").on('click', '.deleteNotice', function () {
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
                ajaxDelete(id, '${path}/notice/deleteNotice');
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
                ajaxDelete(ids, '${path}/notice/deleteNotice');
            }, function () {
                layer.close(layer.index);
            });
        });

        /**
         *删除方法封装
         *
         * */
        function ajaxDelete(param, url) {
            $.ajax({
                type: "post",
                url: url,
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

        /**
         * 打开公告详情方法
         *
         * */
        function seeNotice(event, title) {
            var seeNotice = $("#seenotice").html();
            var p_index = layer.open({
                type: 1
                , content: seeNotice
                , title: '查看公告(' + title + ')'
                , area: ['600px', '300px']
                , shade: 0
                , maxmin: true
                , btn: ['修改', '知道了']
                , yes: function (index, layero) {
                    var data = new Map();
                    data.set('notice_id', layero.find("#notice_id").text());
                    data.set('notice_title', layero.find("#notice_title").text());
                    data.set('notice_content', layero.find("#notice_content").text());
                    openUpdate(data,title,p_index);
                }
                , btn2: function () {
                    layer.close(p_index);
                    event.attr("data-notice", "0");
                }
                , zIndex: layer.zIndex //重点1
                , success: function (layero) {
                    layer.setTop(layero); //重点2
                }
            });
        }


        /**
         * 打开修改复模态框
         *
         * */
        function openUpdate(data,title,p_index) {
            $("#update_notice_id").val(data.get("notice_id"));
            $("#update_notice_title").text(data.get("notice_title"));
            $("#update_notice_content").text(data.get("notice_content"));
            var notice = $("#updateNotice").html();
            var o_index = layer.open({
                type: 1
                , content: notice
                , title: '修改('+title+')'
                , area: ['550px', '440px']
                , shade: 0
                , maxmin: true
                , btn: ['确认修改']
                , yes: function (index, layero) {
                    var notice_title = layero.find("#update_notice_title").val();
                    var notice_content =layero.find("#update_notice_content").val();
                    if (notice_title == "" || notice_title == null) {
                        layer.tips('公告标题不能为空', layero.find("#update_notice_title"), {
                            tips: [3, '#3399CC'],
                            time: 2000,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                        return false;
                    }
                    if (notice_content == "" || notice_content == null) {
                        layer.tips('公告内容不能为空', layero.find("#update_notice_content"), {
                            tips: [3, '#3399CC'],
                            time: 2000,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                        return false;
                    }
                    layer.confirm('确认修改？', {
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
                        var param = {};
                        param.notice_id = layero.find("#update_notice_id").val();
                        param.notice_title = layero.find("#update_notice_title").val();
                        param.notice_content = layero.find("#update_notice_content").val();
                        layer.msg('正在修改', {
                            icon: 16,
                            shade: 0.01,
                            time: 10000,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                        updateNotice(param, o_index,p_index);
                    }, function () {
                        layer.close(layer.index);
                    });
                }
                , zIndex: layer.zIndex //重点1
                , success: function (layero) {
                    layer.setTop(layero); //重点2
                }
            });
        }

        /**
         * 打开添加模态框
         *
         * */
        function openAdd() {
            $("#update_notice_id").val("");
            $("#update_notice_title").text("");
            $("#update_notice_content").text("");
            var addNotice = $("#updateNotice").html();
            var o_index = layer.open({
                type: 1
                , content: addNotice
                , title: '添加公告'
                , area: ['550px', '440px']
                , shade: 0
                , maxmin: true
                , btn: ['确认添加']
                , yes: function (index, layero) {
                    var notice_title = layero.find("#update_notice_title").val();
                    var notice_content =layero.find("#update_notice_content").val();
                    if (notice_title == "" || notice_title == null) {
                        layer.tips('公告标题不能为空', layero.find("#update_notice_title"), {
                            tips: [3, '#3399CC'],
                            time: 2000,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                        return false;
                    }
                    if (notice_content == "" || notice_content == null) {
                        layer.tips('公告内容不能为空', layero.find("#update_notice_content"), {
                            tips: [3, '#3399CC'],
                            time: 2000,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                        return false;
                    }
                    layer.confirm('确认添加？', {
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
                        var param = {};
                        param.notice_title = layero.find("#update_notice_title").val();
                        param.notice_content = layero.find("#update_notice_content").val();
                        layer.msg('正在添加', {
                            icon: 16,
                            shade: 0.01,
                            time: 10000,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                        save(param, o_index);
                    }, function () {
                        layer.close(layer.index);
                    });
                }
                , zIndex: layer.zIndex //重点1
                , success: function (layero) {
                    layer.setTop(layero); //重点2
                }
            });
        }

        /**
         * 修改公告
         *
         * */
        function updateNotice(param, index,p_index) {
            $.ajax({
                type: "post",
                url: "${path}/notice/updateNotice",
                timeout: 10000,
                data: param,
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
                            layer.close(index);
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
                        layer.alert('网络异常，修改失败', {
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

        /**
         * 添加公告
         *
         * */
        function save(param, index) {
            $.ajax({
                type: "post",
                url: "${path}/notice/save",
                timeout: 10000,
                data: param,
                success: function (data) {
                    if (data == "true") {
                        layer.msg("添加成功", {
                            icon: 1,
                            time: 1000,
                            shade: 0.01,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        }, function () {
                            load();
                            layer.close(index);
                            layer.close(layer.index);
                        });
                    } else {
                        layer.alert('添加失败', {
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
                        layer.alert('网络异常，添加失败', {
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
