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
    <title>友情链接 - 异清轩博客管理系统</title>
    <jsp:include page="/WEB-INF/page/ini.jsp"></jsp:include>
    <style>
        input::-webkit-input-placeholder { /* WebKit browsers*/
            color: #A9A9A9;
        }

        input::-moz-placeholder { /* Mozilla Firefox 19+ */
            color: #A9A9A9;
        }

        input:-ms-input-placeholder {
            color: #A9A9A9;
        }
        .table-responsive {
            min-height: 65vh;
            overflow-x: auto;
        }

        .input-div:empty::before {
            color: #A9A9A9;
            content: attr(placeholder);
        }

        .layer-input {
            width: 100%;
            border: 1px #ccc solid;
            padding: 3px;
        }

        .add-input{
            width: 100%;
            border: 1px #ccc solid;
            padding: 6px 12px;
            border-radius: 2px;
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
                <li><a href="javascript:void(0);" id="addFlink">添加友链</a></li>
            </ol>
            <form action="/Comment/checkAll" method="post">
                <h1 class="page-header">管理 <span class="badge">3</span></h1>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th><span class="glyphicon glyphicon-check"></span> <span class="visible-lg">选择</span>
                            </th>
                            <th><span class="glyphicon glyphicon-bookmark"></span> <span class="visible-lg">名称</span>
                            </th>
                            <th><span class="glyphicon glyphicon-link"></span> <span class="visible-lg">URL</span>
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
<!--查看友链模态框-->
<div id="seeFlink" tabindex="1" role="dialog" style="display: none">
    <table class="table" style="margin-bottom:0px;">
        <tbody>
        <tr>
            <td wdith="14%">友链ID:</td>
            <td width="86%" class="flink-id" id="flink_id"></td>
        </tr>
        <tr>
            <td wdith="20%">友链名称:</td>
            <td width="80%" class="update-input" id="flink_name" rel=""></td>
        </tr>
        <tr>
            <td wdith="20%">友链logo:</td>
            <td width="80%" class="update-input" id="flink_icon"><img src="" alt="" height='18px' width='18px'></td>
        </tr>
        <tr>
            <td wdith="20%">友链URL:</td>
            <td width="80%" class="update-input" id="flink_url"></td>
        </tr>
        <tr>
            <td wdith="20%">友链描述:</td>
            <td width="80%" class="update-input" id="describe"></td>
        </tr>
        <tr>
            <td wdith="20%" style="border-bottom: 1px #ddd solid">添加时间:</td>
            <td width="80%" style="border-bottom: 1px #ddd solid" class="put-time" id="put_time"></td>
        </tr>
        </tbody>
    </table>
</div>
<!--修改内容模态框-->
<div id="updateFlink" tabindex="1" role="dialog" style="display: none">
    <div class="col-md-12" style="margin: 10px 0px;">
        <div class="form-group">
            <label>友链名称</label>
            <input type="text" class="add-input" placeholder="在此处输入友链名称" id="update_flink_name">
        </div>
        <div class="form-group">
            <label>友链Logo</label>
            <input type="text" class="add-input" placeholder="在此处输入友链图标URL" id="update_flink_icon">
        </div>
        <div class="form-group">
            <label>友链URL</label>
            <input type="text" class="add-input" placeholder="在此处输入友链URL" id="update_flink_url">
        </div>
        <div class="form-group">
            <label>友链描述</label>
            <input type="text" class="add-input" placeholder="在此处输入友链描述" id="update_flink_describe">
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
                url: "${path}/flink/selectFlink",
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
                        var content = item.flink_url;
                        content = content.length > 50 ? content.substring(0, 50) + "..." : content;
                        $("#table-content").append("<tr>" +
                            "<td><input type='checkbox' class='input-control' name='checkbox[]' value='" + item.flink_id + "'/></td>" +
                            "<td class='flink-name'>" + item.flink_name + "</td>" +
                            "<td class='flink-url'><img src='" + item.flink_icon + "' alt='网站logo' width='18px' height='18px'>" + content + "</td>" +
                            "<td>" + item.put_time + "</td>" +
                            "<td><a class='detailFlink' rel='" + item.flink_id + "' title='查看详情'>查看</a> <a class='deleteFlink' rel=" + item.flink_id + ">删除</a></td></tr>");
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
                url: "${path}/flink/selectFlink",
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
                        var content = item.flink_url;
                        content = content.length > 50 ? content.substring(0, 50) + "..." : content;
                        $("#table-content").append("<tr>" +
                            "<td><input type='checkbox' class='input-control' name='checkbox[]' value='" + item.flink_id + "'/></td>" +
                            "<td class='flink-name'>" + item.flink_name + "</td>" +
                            "<td class='flink-url'><img src='" + item.flink_icon + "' alt='网站logo' width='18px' height='18px'>" + content + "</td>" +
                            "<td>" + item.put_time + "</td>" +
                            "<td><a class='detailFlink' rel='" + item.flink_id + "' title='查看详情'>查看</a> <a class='deleteFlink' rel=" + item.flink_id + ">删除</a></td></tr>");
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
         * 添加
         *
         * */
        $("body").on('click', '#addFlink', function () {
            openAdd();
        });

        /**
         * 查看友链详情
         *
         * */
        $("body").on('click', '.detailFlink', function () {
            var event = $(this);
            if (event.attr("data-flink") == 1)
                return false;
            event.attr("data-flink", '1');
            var flink_id = event.attr("rel");
            var title = event.parent().parent().find('.flink-name').text();
            title = title.length > 10 ? title.substring(0, 10) + "..." : title;
            $.ajax({
                type: "post",
                url: "${path}/flink/detailFlink",
                timeout: 10000,
                data: {flink_id: flink_id},
                success: function (data) {
                    $.each(data, function (index, item) {
                        if (index == "flink_icon")
                            $("#" + index + "").find("img").replaceWith("<img src='" + item + "' alt='友链logo' width='18px' height='18px'>");
                        else
                            $("#" + index + "").text(item);
                    });
                    seeFlink(event, title);
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
         * 删除友链
         *
         * */
        $("body").on('click', '.deleteFlink', function () {
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
                ajaxDelete(id, '${path}/flink/deleteFlink');
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
                ajaxDelete(ids, '${path}/flink/deleteFlink');
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
         * 打开友链详情方法
         *
         * */
        function seeFlink(event, title) {
            var seeFlink = $("#seeFlink").html();
            var p_index = layer.open({
                type: 1
                , content: seeFlink
                , title: '查看友链(' + title + ')'
                , area: ['600px', '330px']
                , shade: 0
                , maxmin: true
                , btn: ['修改', '知道了']
                , yes: function (index, layero) {
                    var _type = layero.find(".layui-layer-btn0").attr("data-type");
                    if (_type == "save") {
                        var data = new Map();
                        data.set('flink_id', layero.find("#flink_id").text());
                        data.set('flink_name', layero.find("#flink_name").children(".layer-input").val());
                        data.set('flink_icon', layero.find("#flink_icon").children(".layer-input").val());
                        data.set('flink_url', layero.find("#flink_url").children(".layer-input").val());
                        data.set('describe', layero.find("#describe").children(".layer-input").val());
                        updateFlink(data, p_index);
                    } else {
                        $.each(layero.find(".update-input"), function (_index, _item) {
                            if ($(_item).attr("id") == "flink_icon") {
                                $(_item).html("<input type='text' class='layer-input' placeholder='友链图标url' data-backup='" + $(_item).find("img").attr("src") + "' value='" + $(_item).find("img").attr("src") + "'/>")
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
                            if ($(_item).attr("id") == "flink_icon") {
                                $(_item).html("<img height='18px' width='18px' src='" + $(_item).find("input").attr("data-backup") + "' alt='友链logo'>");
                            } else {
                                $(_item).text("" + $(_item).find("input").attr("data-backup") + "");
                            }

                        });
                        layero.find(".layui-layer-btn0").text("修改").attr("data-type", "");
                        layero.find(".layui-layer-btn1").text("知道了").attr("data-type", "");
                        return false;
                    } else {
                        layer.close(p_index);
                        event.attr("data-flink", "0");
                    }
                }
                , zIndex: layer.zIndex //重点1
                , success: function (layero) {
                    layer.setTop(layero); //重点2
                }
                , end: function () {
                    event.attr("data-flink", "0");
                }
            });
        }


        /**
         * 修改
         *
         * */
        function updateFlink(data, p_index) {
            var param = {};
            param.flink_id = data.get("flink_id");
            param.flink_name = data.get("flink_name");
            param.flink_icon = data.get("flink_icon");
            param.flink_url = data.get("flink_url");
            param.describe = data.get("describe");
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
                layer.msg('正在修改', {
                    icon: 16,
                    shade: 0.01,
                    time: 10000,
                    zIndex: layer.zIndex,
                    success: function (layero) {
                        layer.setTop(layero);
                    }
                });
                updateNotice(param, p_index);
            }, function () {
                layer.close(layer.index);
            });
        }

        /**
         * 打开添加模态框
         *
         * */
        function openAdd() {
            $("#update_flink_name").val("");
            $("#update_flink_icon").val("");
            $("#update_flink_url").val("");
            $("#update_flink_describe").val("");
            var addFlink = $("#updateFlink").html();
            var o_index = layer.open({
                type: 1
                , content: addFlink
                , title: '添加友链'
                , area: ['600px', '420px']
                , shade: 0
                , maxmin: true
                , btn: ['确认添加', '取消']
                , yes: function (index, layero) {
                    var flink_title = layero.find("#update_flink_name").val();
                    var flink_icon = layero.find("#update_flink_icon").val();
                    var flink_url = layero.find("#update_flink_url").val();
                    var flink_describe = layero.find("#update_flink_describe").val();
                    if (flink_title == "" || flink_title == null) {
                        layer.tips('友链标题不能为空', layero.find("#update_flink_name"), {
                            tips: [3, '#3399CC'],
                            time: 2000,
                            zIndex: layer.zIndex,
                            success: function (layero) {
                                layer.setTop(layero);
                            }
                        });
                        return false;
                    }
                    if (flink_url == "" || flink_url == null) {
                        layer.tips('友链URL不能为空', layero.find("#update_flink_url"), {
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
                        param.flink_name = flink_title;
                        param.flink_icon = flink_icon;
                        param.flink_url = flink_url;
                        param.describe = flink_describe;
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
         * 修改友链
         *
         * */
        function updateNotice(param, p_index) {
            $.ajax({
                type: "post",
                url: "${path}/flink/updateFlink",
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
         * 添加友链
         *
         * */
        function save(param, index) {
            $.ajax({
                type: "post",
                url: "${path}/flink/save",
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
