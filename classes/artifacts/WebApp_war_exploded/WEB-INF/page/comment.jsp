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
    <title>评论 - 异清轩博客管理系统</title>
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
    </style>
</head>

<body class="user-select">
<section class="container-fluid">
    <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
    <div class="row">
        <jsp:include page="/WEB-INF/page/aside.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-lg-10 col-md-offset-2 main" id="main">
            <form action="/Comment/checkAll" method="post">
                <h1 class="page-header">管理 <span class="badge">4</span></h1>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th style="width: 8%"><span class="glyphicon glyphicon-check"></span> <span
                                    class="visible-lg">选择</span>
                            </th>
                            <th style="width: 54%"><span class="glyphicon glyphicon-file"></span> <span
                                    class="visible-lg">摘要</span></th>
                            <th style="width: 8%"><span class="glyphicon glyphicon-book"></span> <span
                                    class="visible-lg">文章</span></th>
                            <th style="width: 8%"><span class="glyphicon glyphicon-comment"></span> <span
                                    class="visible-lg">回复</span>
                            </th>
                            <th style="width: 12%"><span class="glyphicon glyphicon-time"></span> <span
                                    class="visible-lg">日期</span></th>
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
            </form>
        </div>
    </div>
</section>
<!--查看评论模态框-->
<div id="seeComment" tabindex="1" role="dialog" style="display: none">
    <table class="table" style="margin-bottom:0px;">
        <tbody>
        <tr>
            <td wdith="20%">评论ID:</td>
            <td width="80%" class="see-comment-id" id="comment_id"></td>
        </tr>
        <tr>
            <td wdith="20%">评论用户:</td>
            <td width="80%" class="see-comment-id" id="nickname" rel=""></td>
        </tr>
        <tr>
            <td wdith="20%">评论文章:</td>
            <td width="80%" class="see-comment-page" id="article_title"></td>
        </tr>
        <tr>
            <td wdith="20%">评论内容:</td>
            <td width="80%" class="see-comment-content" id="comment_content"></td>
        </tr>
        <tr>
            <td wdith="20%">IP:</td>
            <td width="80%" class="see-comment-ip" id="comment_ip"></td>
        </tr>
        <tr>
            <td wdith="20%">所在地:</td>
            <td width="80%" class="see-comment-address" id="comment_adds"></td>
        </tr>
        <tr>
            <td wdith="20%">系统:</td>
            <td width="80%" class="see-comment-system" id="comment_os"></td>
        </tr>
        <tr>
            <td wdith="20%">浏览器:</td>
            <td width="80%" class="see-comment-browser" id="comment_browser"></td>
        </tr>
        <tr>
            <td wdith="20%" style="border-bottom: 1px #ddd solid">评论时间:</td>
            <td width="80%" style="border-bottom: 1px #ddd solid" class="see-comment-browser" id="comment_time"></td>
        </tr>
        </tbody>
    </table>
</div>
<!--查看回复详情-->
<div id="seeReplyDetail" tabindex="1" role="dialog" style="display: none">
    <table class="table" style="margin-bottom:0px;">
        <tbody>
        <tr>
            <td wdith="20%">回复ID:</td>
            <td width="80%" class="see-comment-id" id="reply_id" rel=""></td>
        </tr>
        <tr>
            <td wdith="20%">回复者:</td>
            <td width="80%" class="see-comment-id" id="user_name" rel=""></td>
        </tr>
        <tr>
            <td wdith="20%">回复内容:</td>
            <td width="80%" class="see-comment-content" id="reply_content"></td>
        </tr>
        <tr>
            <td wdith="20%">回复对象:</td>
            <td width="80%" class="see-comment-id" id="to_name"></td>
        </tr>
        <tr>
            <td wdith="20%">IP:</td>
            <td width="80%" class="see-comment-ip" id="reply_ip"></td>
        </tr>
        <tr>
            <td wdith="20%">所在地:</td>
            <td width="80%" class="see-comment-address" id="reply_adds"></td>
        </tr>
        <tr>
            <td wdith="20%">系统:</td>
            <td width="80%" class="see-comment-system" id="reply_os"></td>
        </tr>
        <tr>
            <td wdith="20%">浏览器:</td>
            <td width="80%" class="see-comment-browser" id="reply_browser"></td>
        </tr>
        <tr>
            <td wdith="20%" style="border-bottom: 1px #ddd solid">评论时间:</td>
            <td width="80%" style="border-bottom: 1px #ddd solid" class="see-comment-browser" id="reply_time"></td>
        </tr>
        </tbody>
    </table>
</div>
<!--查看回复模态框-->
<div id="seeReply" tabindex="1" role="dialog" style="display: none">
    <table class="table table-striped table-hover">
        <thead>
        <tr>
            <th style="width: 75%"><span class="glyphicon glyphicon-comment"></span> <span
                    class="visible-lg">摘要</span></th>
            </th>
            <th style="width: 14%"><span class="glyphicon glyphicon-time"></span> <span
                    class="visible-lg">日期</span></th>
            <th style="width: 11%"><span class="glyphicon glyphicon-pencil"></span> <span
                    class="visible-lg">操作</span></th>
        </tr>
        </thead>
        <tbody id="reply-content">
        </tbody>
    </table>
</div>
<!--回复模态框-->
<div id="replyComment" tabindex="1" role="dialog" style="display: none">
    <div style="width: 100%;padding: 20px 15px 0">
        <input type="hidden" id="reply_comment_id" value="">
        <input type="hidden" id="reply_user_id" value="">
        <textarea id="reply_content_info" style="width: 100%;height: 140px;padding: 5px 10px;border-color: #ddd"
                  autofocus
                  placeholder="回复 xxxxx："></textarea>
        <span style="float:right;font-size: 12px;color: gray;">500</span>
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
                url: "${path}/commentInfo/selectComment",
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
                            $("#table-content").append("<tr><td style='text-align: center' colspan=7>数据获取失败，请稍后再试！</td></tr>");
                            $(".loader").hide();
                        });
                        return false;
                    }
                    if (data.totalRecords == 0) {
                        $("#table-content").append("<tr><td style='text-align: center' colspan=7>暂无数据！</td></tr>");
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
                        var comment = item.comment_content;
                        comment = comment.length > 50 ? comment.substring(0, 50) + "..." : comment;
                        $("#table-content").append("<tr>" +
                            "<td><input type='checkbox' class='input-control' name='checkbox[]' value='" + item.comment_id + "'/></td>" +
                            "<td class='comment-content'>" + comment + "</td>" +
                            "<td>" + item.article_id + "</td>" +
                            "<td><a class='seeReply' rel='" + item.comment_id + "' data-reply='0' title='查看回复'>" + item.reply_num + "</a></td>" +
                            "<td>" + item.comment_time + "</td>" +
                            "<td><a class='detailComment' rel='" + item.comment_id + "'>查看</a> <a class='deleteComment' rel=" + item.comment_id + ">删除</a></td></tr>");
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
                            $("#table-content").append("<tr><td style='text-align: center' colspan=7>数据获取失败，请稍后再试！</td></tr>");
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
                            $("#table-content").append("<tr><td style='text-align: center' colspan=7>数据获取失败，请稍后再试！</td></tr>");
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
                url: "${path}/commentInfo/selectComment",
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
                            $("#table-content").append("<tr><td style='text-align: center' colspan=7>数据获取失败，请稍后再试！</td></tr>");
                            $(".loader").hide();
                        });
                        return false;
                    }
                    if (data.length == 0) {
                        $("#table-content").append("<tr><td style='text-align: center' colspan=7>暂无数据！</td></tr>");
                        $(".loader").hide();
                        return false;
                    }
                    $(".loader").hide();
                    $.each(data.data, function (index, item) {
                        var comment = item.comment_content;
                        icomment = comment.length > 110 ? comment.substring(0, 110) + "..." : comment;
                        $("#table-content").append("<tr>" +
                            "<td><input type='checkbox' class='input-control' name='checkbox[]' value='" + item.comment_id + "'/></td>" +
                            "<td class='comment-content'>" + item.comment_content + "</td>" +
                            "<td>" + item.article_id + "</td>" +
                            "<td><a class='seeReply' rel='" + item.comment_id + "' data-reply='0' title='查看回复'>" + item.reply_num + "</a></td>" +
                            "<td>" + item.comment_time + "</td>" +
                            "<td><a class='detailComment' rel='" + item.comment_id + "'>查看</a> <a class='deleteComment' rel=" + item.comment_id + ">删除</a></td></tr>");
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
                            $("#table-content").append("<tr><td style='text-align: center' colspan=7>数据获取失败，请稍后再试！</td></tr>");
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
                            $("#table-content").append("<tr><td style='text-align: center' colspan=7>数据获取失败，请稍后再试！</td></tr>");
                            $(".loader").hide();
                        });
                    }
                }
            });
        }

        /**
         * 查看评论详情
         *
         * */
        $("body").on('click', '.detailComment', function () {
            var event = $(this);
            if (event.attr("data-show") == 1)
                return false;
            event.attr("data-show", '1');
            var comment_id = event.attr("rel");
            var title=event.parent().parent().find('.comment-content').text();
            title = title.length > 10 ? title.substring(0, 10) + "..." : title;
            $.ajax({
                type: "post",
                url: "${path}/commentInfo/seeComment",
                timeout: 10000,
                data: {comment_id: comment_id},
                success: function (data) {
                    $.each(data, function (index, item) {
                        if (index == "articleInfo") {
                            $("#article_title").text(data.articleInfo.title);
                        } else if (index == "users") {
                            $("#nickname").text(data.users.nickname);
                            $("#nickname").attr("rel", data.user_id);
                        } else {
                            $("#" + index + "").text(item);
                        }
                    });
                    seeComment(event,title);
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
         * 查看回复
         *
         * */
        $("body").on('click', '.seeReply', function () {
            var event = $(this);
            if (event.attr("data-reply") == 1)
                return false;
            event.attr("data-reply", '1');
            var comment_id = event.attr("rel");
            var title=event.parent().parent().find('.comment-content').text();
            title = title.length > 10 ? title.substring(0, 10) + "..." : title;
            $.ajax({
                type: "post",
                url: "${path}/commentInfo/seeReply",
                timeout: 10000,
                data: {comment_id: comment_id},
                success: function (data) {
                    $("#reply-content").find("tr").remove();
                    $.each(data, function (index, item) {
                        var reply_content = item.reply_content;
                        reply_content = reply_content.length > 50 ? reply_content.substring(0, 50) + "..." : reply_content;
                        $("#reply-content").append("<tr>" +
                            "<td><span style='color: #3399CC'>" + item.user_name + "</span>回复<span style='color: #3399CC'>" + item.to_name + "：</span>" + reply_content + "</td>" +
                            "<td>" + new Date(item.reply_time).toLocaleString() + "</td>" +
                            "<td><a class='detailReply' rel='" + item.reply_id + "'>查看</a> <a class='deleteReply' rel=" + item.reply_id + ">删除</a></td></tr>");
                    });
                    seeReply(event,title);
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
         * 查看回复详情
         *
         * */
        $("body").on('click', '.detailReply', function () {
            var b_index=$(this).parents().eq(5).attr("times");
            var reply_id = $(this).attr("rel");
            $.ajax({
                type: "post",
                url: "${path}/replyInfo/seeReply",
                timeout: 10000,
                data: {reply_id: reply_id},
                success: function (data) {
                    $.each(data[0], function (index, item) {
                        if (index == "comment_id")
                            $("#reply_id").attr("rel", item);
                        else if (index == "reply_time")
                            $("#" + index + "").text(new Date(item).toLocaleString());
                        else if (index == "user_id")
                            $("#user_name").attr("rel", item);
                        else
                            $("#" + index + "").text(item);
                    });
                    seeReplyDetail(b_index);
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
         * 删除评论
         *
         * */
        $("body").on('click', '.deleteComment', function () {
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
                ajaxDelete(id,'${path}/commentInfo/deleteComment');
            }, function () {
                layer.close(layer.index);
            });
        });

        /**
         * 删除回复
         *
         * */
        $("body").on('click', '.deleteReply', function () {
            var id = $(this).attr("rel");
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
                ajaxDelete(id,'${path}/replyInfo/deleteReply');
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
                ajaxDelete(ids,'${path}/commentInfo/deleteComment');
            }, function () {
                layer.close(layer.index);
            });
        });

        /**
         *删除方法封装
         *
         * */
        function ajaxDelete(param,url) {
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
         * 打开评论详情方法
         *
         * */
        function seeComment(event,title) {
            var seeComment = $("#seeComment").html();
            var p_index = layer.open({
                type: 1
                , content: seeComment
                , title: '查看评论('+title+')'
                , area: ['600px', '430px']
                , shade: 0
                , maxmin: true
                , btn: ['回复', '知道了']
                , yes: function (index, layero) {
                    var data = new Map();
                    data.set('comment_id', layero.find("#comment_id").text());
                    data.set('user_id', layero.find("#nickname").attr("rel"));
                    data.set('user_name', layero.find("#nickname").text());
                    replyComment(data,p_index);

                }
                , btn2: function () {
                    layer.close(p_index);
                    event.attr("data-show", "0");
                }
                , zIndex: layer.zIndex //重点1
                , success: function (layero) {
                    layer.setTop(layero); //重点2
                }
                , end: function(){
                    event.attr("data-show", "0");
                }
            });
        }

        /**
         * 打开回复详情方法
         *
         * */
        function seeReplyDetail(b_index) {
            var seeReplyDetail = $("#seeReplyDetail").html();
            var p_index = layer.open({
                type: 1
                , content: seeReplyDetail
                , title: '回复详情'
                , area: ['600px', '430px']
                , shade: 0
                , maxmin: true
                , btn: ['回复', '知道了']
                , yes: function (index, layero) {
                    var data = new Map();
                    data.set('comment_id', layero.find("#reply_id").attr("rel"));
                    data.set('user_id', layero.find("#user_name").attr("rel"));
                    data.set('user_name', layero.find("#user_name").text());
                    replyComment(data,p_index,b_index);
                }
                , btn2: function () {
                    layer.close(p_index);
                }
                , zIndex: layer.zIndex //重点1
                , success: function (layero) {
                    layer.setTop(layero); //重点2
                }
            });
        }

        /**
         * 打开评论回复方法
         *
         * */
        function seeReply(event,title) {
            var seeReply = $("#seeReply").html();
            var index = layer.open({
                type: 1
                , content: seeReply
                , title: '查看回复列表('+title+')'
                , area: ['750px', '430px']
                , shade: 0
                , maxmin: true
                , btn: ['知道了', '全部关闭']
                , yes: function () {
                    layer.close(index);
                    event.attr("data-reply", "0");
                }
                , btn2: function () {
                    layer.closeAll();
                    $("#table-content tr").find("a[data-reply='1']").attr("data-reply", '0');
                }
                , zIndex: layer.zIndex //重点1
                , success: function (layero) {
                    layer.setTop(layero); //重点2
                }
                , end: function(){
                    event.attr("data-reply", "0");
                }
            });
        }

        /**
         * 回复
         *
         * */
        function replyComment(data,p_index,b_index) {
            $("#reply_comment_id").val(data.get("comment_id"));
            $("#reply_user_id").val(data.get("user_id"));
            $("#reply_content_info").attr("placeholder", "回复 " + data.get("user_name") + ":");
            var replyComment = $("#replyComment").html();
            var o_index = layer.open({
                type: 1
                , content: replyComment
                , title: '评论'
                , area: ['550px', '280px']
                , shade: 0
                , maxmin: true
                , btn: ['评 论']
                , yes: function (index, layero) {
                    var reply_content_info = layero.find("#reply_content_info").val();
                    if(reply_content_info==""||reply_content_info==null){
                        layer.tips('内容不能为空', layero.find("#reply_content_info"), {
                            tips: [3, '#3399CC'],
                            time: 2000,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                        return false;
                    }
                    var param = {};
                    param.comment_id = layero.find("#reply_comment_id").val();
                    param.reply_content = reply_content_info;
                    param.to_uid = layero.find("#reply_user_id").val();
                    param.user_id = "${sessionScope.get("manager").getUser_id()}";
                    layer.msg('正在回复', {
                        icon: 16,
                        shade: 0.01,
                        time: 10000,
                        zIndex: layer.zIndex,
                        success: function (layero) {
                            layer.setTop(layero);
                        }
                    });
                    addReply(param, o_index,p_index,b_index);
                }
                , zIndex: layer.zIndex //重点1
                , success: function (layero) {
                    layer.setTop(layero); //重点2
                }
            });
        }

        /**
         * 添加回复
         *
         * */
        function addReply(param, index,p_index,b_index) {
            $.ajax({
                type: "post",
                url: "${path}/replyInfo/addReply",
                timeout: 10000,
                data: param,
                success: function (data) {
                    if (data == "true") {
                        layer.msg("回复成功", {
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
                            layer.close(b_index);
                        });
                    } else {
                        layer.alert('回复失败', {
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
