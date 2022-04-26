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
    <title>修改栏目 - 异清轩博客管理系统</title>
    <jsp:include page="/WEB-INF/page/ini.jsp"></jsp:include>
</head>

<body class="user-select">
<section class="container-fluid">
    <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
    <div class="row">
        <jsp:include page="/WEB-INF/page/aside.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-lg-10 col-md-offset-2 main" id="main">
            <h1 class="page-header">修改栏目</h1>
            <div class="form-group">
                <label for="column_name">栏目名称</label>
                <input type="text" id="column_name" name="name" value="${columnInfo.column_name}" class="form-control"
                       placeholder="在此处输入栏目名称" required autocomplete="off">
                <span class="prompt-text">这将是它在站点上显示的名字。</span></div>
            <div class="form-group">
                <label for="column_alias">栏目别名</label>
                <input type="text" id="column_alias" name="alias" value="${columnInfo.alias}" class="form-control"
                       placeholder="在此处输入栏目别名" required autocomplete="off">
                <span class="prompt-text">“别名”是在URL中使用的别称，它可以令URL更美观。通常使用小写，只能包含字母，数字和连字符（-）。</span></div>
            <button class="btn btn-primary" type="button" id="submit">更新</button>
        </div>
    </div>
    <input type="hidden" value="${columnInfo.column_id}" id="column_id">
</section>
<jsp:include page="/WEB-INF/page/modal-box.jsp"></jsp:include>
<script src="${path}/background/js/bootstrap.min.js"></script>
<script src="${path}/background/js/admin-scripts.js"></script>
<script>
    $(function () {
        $("#submit").click(function () {
            var column_name = $("#column_name").val();
            var column_alias = $("#column_alias").val();
            var column_id=$("#column_id").val();
            if (column_name == "" || column_name == null) {
                layer.tips('亲，输入内容哦', '#column_name', {
                    tips: [3, '#3595CC'],
                    time: 4000
                });
                return false;
            }
            if (column_alias == "" || column_alias == null) {
                layer.tips('亲，输入内容哦', '#column_alias', {
                    tips: [3, '#3595CC'],
                    time: 4000
                });
                return false;
            }
            var loadTip = layer.load(1);
            $.ajax({
                type: "post",
                url: "${path}/columnInfo/updateColumn",
                timeout:10000,
                data: {
                    "column_name": column_name,
                    "alias": column_alias,
                    "column_id":column_id
                },
                success: function (data) {
                    if (data == "true") {
                        layer.confirm('修改成功，返回栏目列表？', {
                            icon: 1,
                            skin: 'layer-ext-moon',
                            btn: ['确认', '取消'] //按钮
                        }, function () {
                            layer.close(loadTip);
                            window.location.href = "${path}/login/toPages/category";
                        }, function () {
                            layer.close(loadTip);
                            layer.close(layer.index);
                        });
                    }
                    else if (data == "false"){
                        layer.msg("修改失败", {icon: 5, time: 1000});
                        layer.close(loadTip);
                    }
                },complete:function(XMLHttpRequest,status){
                    if(status=="timeout"){
                        layer.alert('网络异常，数据获取失败', {
                            icon: 2,
                            skin: 'layer-ext-moon'
                        }, function () {
                            layer.close(layer.index);
                            layer.close(loadTip);
                        });
                    }else if(status=="error"){
                        layer.alert('系统错误，数据获取失败', {
                            icon: 2,
                            skin: 'layer-ext-moon'
                        }, function () {
                            layer.close(layer.index);
                            layer.close(loadTip);
                        });
                    }
                }
            });
        });
    });
</script>
</body>
</html>
