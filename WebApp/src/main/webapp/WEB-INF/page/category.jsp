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
    <title>栏目 - 异清轩博客管理系统</title>
    <jsp:include page="/WEB-INF/page/ini.jsp"></jsp:include>
</head>

<body class="user-select">
<section class="container-fluid">
    <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
    <div class="row">
        <jsp:include page="/WEB-INF/page/aside.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-lg-10 col-md-offset-2 main" id="main">
            <div class="row">
                <div class="col-md-5">
                    <h1 class="page-header">添加</h1>
                    <div class="form-group">
                        <label for="column_name">栏目名称</label>
                        <input type="text" id="column_name" name="name" class="form-control"
                               placeholder="在此处输入栏目名称" required autocomplete="off">
                        <span class="prompt-text">这将是它在站点上显示的名字。</span></div>
                    <div class="form-group">
                        <label for="column_alias">栏目别名</label>
                        <input type="text" id="column_alias" name="alias" class="form-control"
                               placeholder="在此处输入栏目别名" required autocomplete="off">
                        <span class="prompt-text">“别名”是在URL中使用的别称，它可以令URL更美观。通常使用小写，只能包含字母，数字和连字符（-）。</span></div>
                    <button class="btn btn-primary" type="submit" id="submit">添加新栏目</button>
                </div>
                <div class="col-md-7">
                    <h1 class="page-header">管理 <span class="badge">3</span></h1>
                    <div class="table-responsive">
                        <form name="form1" id="form1" action="${path}/columnInfo/updateCategory" method="post">
                            <table class="table table-striped table-hover">
                                <thead>
                                <tr>
                                    <th><span class="glyphicon glyphicon-paperclip"></span> <span
                                            class="visible-lg">ID</span></th>

                                    <th><span class="glyphicon glyphicon-file"></span> <span
                                            class="visible-lg">名称</span>
                                    </th>

                                    <th><span class="glyphicon glyphicon-list-alt"></span> <span
                                            class="visible-lg">别名</span></th>

                                    <th><span class="glyphicon glyphicon-list-alt"></span> <span
                                            class="visible-lg">添加时间</span></th>

                                    <th><span class="glyphicon glyphicon-pushpin"></span> <span
                                            class="visible-lg">总数</span>
                                    </th>

                                    <th><span class="glyphicon glyphicon-pencil"></span> <span
                                            class="visible-lg">操作</span>
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
                        </form>
                    </div>
                </div>
            </div>
        </div>
</section>
<jsp:include page="/WEB-INF/page/modal-box.jsp"></jsp:include>
<script src="${path}/background/js/bootstrap.min.js"></script>
<script src="${path}/background/js/admin-scripts.js"></script>
<script>
    //是否确认删除
    $(function () {
        load();

        function load() {
            $("#table-content").find("tr").remove();
            $("#table-content").parents().find(".prompt-text").remove();
            $(".loader").show();
            $.ajax({
                type: "post",
                url: "${path}/columnInfo/selectColumn",
                timeout: 10000,
                success: function (data) {
                    if (data == "" || data == null) {
                        layer.alert('系统错误，数据获取失败', {
                            icon: 2,
                            skin: 'layer-ext-moon'
                        }, function () {
                            layer.close(layer.index);
                            $("#table-content").append("<tr><td style='text-align: center' colspan=6>数据获取失败，请稍后再试！</td></tr>");
                            $(".loader").hide();
                        });
                        return false;
                    }
                    if(data.length==0){
                        $("#table-content").append("<tr><td style='text-align: center' colspan=6>暂无数据！</td></tr>");
                        $(".loader").hide();
                        return false;
                    }
                    $(".loader").hide();
                    $.each(data, function (index, item) {
                        $("#table-content").append("<tr>" +
                            "<td>" + item.column_id + "</td>" +
                            "<td>" + item.column_name + "</td>" +
                            "<td>" + item.alias + "</td>" +
                            "<td>" + item.set_time + "</td>" +
                            "<td>" + item.articleNum + "</td>" +
                            "<td><a>修改</a><input name='column_id' type='hidden' value='" + item.column_id + "'> <a rel=" + item.column_id + ">删除</a></td></tr>");
                    });
                    $("#table-content").parent().after("<span class='prompt-text'><strong>注：</strong>删除一个栏目也会删除栏目下的文章和子栏目,请谨慎删除!</span> </div>");

                    $("#table-content tr td").find("a").click(function () {
                        if (event.srcElement.outerText === "删除") {
                            /*删除*/
                            deleteCol($(this));
                        } else {
                            /*修改*/
                            location.href = $("#form1").attr("action") + "/" + $(this).next().val();
                        }
                    });
                }, complete: function (XMLHttpRequest, status) {
                    if (status == "timeout") {
                        layer.alert('网络异常，数据获取失败', {
                            icon: 2,
                            skin: 'layer-ext-moon'
                        }, function () {
                            layer.close(layer.index);
                            $("#table-content").append("<tr><td style='text-align: center' colspan=6>数据获取失败，请稍后再试！</td></tr>");
                            $(".loader").hide();
                        });
                    } else if (status == "error") {
                        layer.alert('系统错误，数据获取失败', {
                            icon: 2,
                            skin: 'layer-ext-moon'
                        }, function () {
                            layer.close(layer.index);
                            $("#table-content").append("<tr><td style='text-align: center' colspan=6>数据获取失败，请稍后再试！</td></tr>");
                            $(".loader").hide();
                        });
                    }
                }
            });
        }

        $("#submit").click(function () {
            var column_name = $("#column_name").val();
            var column_alias = $("#column_alias").val();
            if (column_name == "" || column_name == null) {
                layer.tips('亲，输入内容哦', '#column_name', {
                    tips: [2, '#3595CC'],
                    time: 4000
                });
                return false;
            }
            if (column_alias == "" || column_alias == null) {
                layer.tips('亲，输入内容哦', '#column_alias', {
                    tips: [2, '#3595CC'],
                    time: 4000
                });
                return false;
            }
            var loadTip = layer.load(1);
            $.ajax({
                type: "post",
                url: "${path}/columnInfo/saveColumn",
                timeout: 10000,
                data: {
                    "column_name": column_name,
                    "alias": column_alias
                },
                success: function (data) {
                    if (data == "true") {
                        $("#column_name").val("");
                        $("#column_alias").val("");
                        layer.close(loadTip);
                        layer.msg("添加成功", {icon: 6, time: 1000});
                        load();
                    }
                    else if (data == "false") {
                        layer.msg("添加失败", {icon: 5, time: 1000});
                        layer.close(loadTip);
                    }
                }, complete: function (XMLHttpRequest, status) {
                    if (status == "timeout") {
                        layer.alert('网络异常，数据获取失败', {
                            icon: 2,
                            skin: 'layer-ext-moon'
                        }, function () {
                            layer.close(layer.index);
                            layer.close(loadTip);
                        });
                    } else if (status == "error") {
                        layer.alert('系统错误，数据获取失败', {
                            icon: 2,
                            skin: 'layer-ext-moon'
                        }, function () {
                            layer.close(layer.index);
                            layer.close(loadtip);
                        });
                    }
                }
            });
        });

        function deleteCol(even) {
            var btn = $(even);
            var id = btn.attr("rel"); //对应id
            layer.confirm('此操作不可逆，确认删除？', {
                anim: 6,
                btn: ['确认', '取消'] //按钮
            }, function () {
                $.ajax({
                    type: "post",
                    url: "${path}/columnInfo/deleteColumn",
                    data: {
                        "column_id": id,
                    },
                    success: function (data) {
                        if (data == "true") {
                            layer.msg("删除成功", {icon: 6, time: 1000});
                            load();
                        }
                        else if (data == "false")
                            layer.msg("删除失败", {icon: 5, time: 1000});
                        else if (data == "error") {
                            layer.alert('系统错误，数据获取失败', {
                                anim: 6,
                                icon: 2,
                                skin: 'layer-ext-moon'
                            }, function () {
                                layer.close(layer.index);
                            });
                        }

                    }, error: function () {
                        layer.alert('系统错误，数据获取失败', {
                            anim: 6,
                            icon: 2,
                            skin: 'layer-ext-moon'
                        }, function () {
                            layer.close(layer.index);
                        });
                    }
                });
            }, function () {
                layer.close(layer.index);
            });
        }
    });
</script>
</body>
</html>
