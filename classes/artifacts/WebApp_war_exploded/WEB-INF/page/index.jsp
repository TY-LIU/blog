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
    <title>登录 - Mr.L博客管理系统</title>
    <link rel="stylesheet" type="text/css" href="${path}/background/css/login.css">
    <jsp:include page="/WEB-INF/page/ini.jsp"></jsp:include>
</head>

<body class="user-select">
<div class="container">
    <div class="siteIcon">
        <img src="${path}/background/images/icon/icon.png" alt="" data-toggle="tooltip" data-placement="top" title="欢迎使用异清轩博客管理系统" draggable="false"/>
    </div>
    <form action="${path}/WEB-INF/page/main.jspsp" method="post" autocomplete="off" class="form-signin">
        <h2 class="form-signin-heading">管理员登录</h2>
        <label for="userName" class="sr-only">用户名</label>
        <input type="text" id="userName" name="username" class="form-control" placeholder="请输入用户名" required autofocus
               autocomplete="off" maxlength="10">
        <label for="userPwd" class="sr-only">密码</label>
        <input type="password" id="userPwd" name="userpwd" class="form-control" placeholder="请输入密码" required
               autocomplete="off" maxlength="18">
        <a href="main.jsp">
            <button class="btn btn-lg btn-primary btn-block" type="submit" id="signinSubmit">登录</button>
        </a>
    </form>
    <div class="footer">
        <p><a href="/Home/index.jsp" data-toggle="tooltip" data-placement="left" title="不知道自己在哪?">回到异清轩博客 →</a></p>
    </div>
</div>
<script src="${path}/background/js/bootstrap.min.js"></script>
<script>
    $('[data-toggle="tooltip"]').tooltip();
    window.oncontextmenu = function () {
        //return false;
    };
    $('.siteIcon img').click(function () {
        window.location.reload();
    });
    $('#signinSubmit').click(function () {
        if ($('#userName').val() === '') {
            $(this).text('用户名不能为空');
        } else if ($('#userPwd').val() === '') {
            $(this).text('密码不能为空');
        } else {
            $(this).text('请稍后...');
        }
    });
</script>
</body>
</html>
