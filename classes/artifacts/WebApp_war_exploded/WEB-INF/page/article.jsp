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
    <title>文章 - 异清轩博客管理系统</title>
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
            <form name="form1" id="form1" action="${path}/articleInfo/updateArticle" method="post">
                <h1 class="page-header">操作</h1>
                <ol class="breadcrumb">
                    <li><a href="${path}/articleInfo/addArticle">增加文章</a></li>
                </ol>
                <h1 class="page-header">管理 <span class="badge">7</span></h1>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th style="width: 8%"><span class="glyphicon glyphicon-check"></span> <span
                                    class="visible-lg">选择</span>
                            </th>
                            <th style="width: 40%"><span class="glyphicon glyphicon-file"></span> <span class="visible-lg">标题</span>
                            </th>
                            <th style="width: 10%"><span class="glyphicon glyphicon-list"></span> <span class="visible-lg">栏目</span>
                            </th>
                            <th style="width: 12%" class="hidden-sm"><span class="glyphicon glyphicon-tag"></span> <span
                                    class="visible-lg">标签</span></th>
                            <th style="width: 8%" class="hidden-sm"><span class="glyphicon glyphicon-comment"></span> <span
                                    class="visible-lg">评论</span></th>
                            <th style="width: 12%"><span class="glyphicon glyphicon-time"></span> <span class="visible-lg">日期</span>
                            </th>
                            <th style="width: 10%"><span class="glyphicon glyphicon-pencil"></span> <span class="visible-lg">操作</span>
                            </th>
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
                                <button type="button" class="btn btn-danger batchDeleting" title="批量删除" name="checkbox_delete">
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
                url: "${path}/articleInfo/selectArticle",
                timeout: 10000,
                data: param,
                success: function (data) {
                    if (data == "" || data == null) {
                        layer.alert('系统错误，数据获取失败', {
                            icon: 2,
                            skin: 'layer-ext-moon'
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
                        $("#table-content").append("<tr>" +
                            "<td><input type='checkbox' class='input-control' name='checkbox[]' value='" + item.article_id + "'/></td>" +
                            "<td class='article-title'>" + item.title + "</td>" +
                            "<td>" + item.columnInfo.column_name + "</td>" +
                            "<td class='hidden-sm'>" + item.label + "</td>" +
                            "<td class='hidden-sm'>" + item.commentNum + "</td>" +
                            "<td>" + item.update_time + "</td>" +
                            "<td><a class='editArticle' rel='" + item.article_id + "'>修改</a> <a class='deleteArticle' rel=" + item.article_id + ">删除</a></td></tr>");
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
                            skin: 'layer-ext-moon'
                        }, function () {
                            layer.close(layer.index);
                            $("#table-content").append("<tr><td style='text-align: center' colspan=7>数据获取失败，请稍后再试！</td></tr>");
                            $(".loader").hide();
                        });
                    } else if (status == "error") {
                        layer.alert('系统错误，数据获取失败', {
                            icon: 2,
                            skin: 'layer-ext-moon'
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
                url: "${path}/articleInfo/selectArticle",
                timeout: 10000,
                data: param,
                success: function (data) {
                    if (data == "" || data == null) {
                        layer.alert('系统错误，数据获取失败', {
                            icon: 2,
                            skin: 'layer-ext-moon'
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
                        $("#table-content").append("<tr>" +
                            "<td><input type='checkbox' class='input-control' name='checkbox[]' value='" + item.article_id + "'/></td>" +
                            "<td class='article-title'>" + item.title + "</td>" +
                            "<td>" + item.columnInfo.column_name + "</td>" +
                            "<td class='hidden-sm'>" + item.label + "</td>" +
                            "<td class='hidden-sm'>" + item.commentNum + "</td>" +
                            "<td>" + item.update_time + "</td>" +
                            "<td><a class='editArticle' rel='" + item.article_id + "'>修改</a> <a class='deleteArticle' rel=" + item.article_id + ">删除</a></td></tr>");
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
                            skin: 'layer-ext-moon'
                        }, function () {
                            layer.close(layer.index);
                            $("#table-content").append("<tr><td style='text-align: center' colspan=7>数据获取失败，请稍后再试！</td></tr>");
                            $(".loader").hide();
                        });
                    } else if (status == "error") {
                        layer.alert('系统错误，数据获取失败', {
                            icon: 2,
                            skin: 'layer-ext-moon'
                        }, function () {
                            layer.close(layer.index);
                            $("#table-content").append("<tr><td style='text-align: center' colspan=7>数据获取失败，请稍后再试！</td></tr>");
                            $(".loader").hide();
                        });
                    }
                }
            });
        }

        //修改
        $("body").on('click', '.editArticle', function () {
            location.href = $("#form1").attr("action") + "/" + $(this).attr("rel");
        });
        //删除
        $("body").on('click', '.deleteArticle', function () {
            var id=$(this).attr("rel");
            layer.confirm('确认删除？', {
                icon: 3,
                title: '警告',
                skin: 'layer-ext-moon',
                btn: ['确认', '取消'] //按钮
            }, function () {
                ajaxDelete(id);
            }, function () {
                layer.close(layer.index);
            });
        });
        //批量删除
        $("body").on('click', '.batchDeleting', function () {
            var event = $("input[type='checkbox'][class='input-control']:checked");
            var ids = "";
            if(event.length==0){
                layer.msg("请选择删除项",{ time: 1000});
                return false;
            }
            layer.confirm('确认删除？', {
                icon: 3,
                title: '警告',
                skin: 'layer-ext-moon',
                btn: ['确认', '取消'] //按钮
            }, function () {
                $.each(event, function (index, item) {
                    ids += ($(item).val()) + ",";
                });
                ajaxDelete(ids);
            }, function () {
                layer.close(layer.index);
            });
        });

        function ajaxDelete(param){
            $.ajax({
                type: "post",
                url: "${path}/articleInfo/deleteArticle",
                timeout: 10000,
                data: {ids: param},
                success: function (data) {
                    if (data == "true") {
                        layer.msg("删除成功",{icon: 1,time: 1000},function(){
                            load();
                            layer.close(layer.index);
                        });
                    } else {
                        layer.alert('删除失败', {
                            icon: 2,
                            skin: 'layer-ext-moon'
                        }, function () {
                            layer.close(layer.index);
                        });
                    }
                }, complete: function (XMLHttpRequest, status) {
                    if (status == "timeout") {
                        layer.alert('网络异常，请检查网络', {
                            icon: 2,
                            skin: 'layer-ext-moon'
                        }, function () {
                            layer.close(layer.index);
                        });
                    } else if (status == "error") {
                        layer.alert('系统错误，删除失败', {
                            icon: 2,
                            skin: 'layer-ext-moon'
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
