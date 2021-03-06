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
    <title>写公告 - 异清轩博客管理系统</title>
    <jsp:include page="/WEB-INF/page/ini.jsp"></jsp:include>
</head>

<body class="user-select">
<section class="container-fluid">
    <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
    <div class="row">
        <jsp:include page="/WEB-INF/page/aside.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-lg-10 col-md-offset-2 main" id="main">
            <div class="row">
                <form action="test.php" method="post" class="add-article-form">
                    <div class="col-md-9">
                        <h1 class="page-header">撰写新公告</h1>
                        <div class="form-group">
                            <label for="article-title" class="sr-only">标题</label>
                            <input type="text" id="article-title" name="title" class="form-control"
                                   placeholder="在此处输入标题" required autofocus autocomplete="off">
                        </div>
                        <div class="form-group">
                            <label for="article-content" class="sr-only">内容</label>
                            <textarea id="article-content" name="content" class="form-control"></textarea>
                        </div>
                        <div class="add-article-box">
                            <h2 class="add-article-box-title"><span>关键字</span></h2>
                            <div class="add-article-box-content">
                                <input type="text" class="form-control" placeholder="请输入关键字" name="keywords"
                                       autocomplete="off">
                                <span class="prompt-text">多个标签请用英文逗号,隔开。</span>
                            </div>
                        </div>
                        <div class="add-article-box">
                            <h2 class="add-article-box-title"><span>描述</span></h2>
                            <div class="add-article-box-content">
                                <textarea class="form-control" name="describe" autocomplete="off"></textarea>
                                <span class="prompt-text">描述是可选的手工创建的内容总结，并可以在网页描述中使用</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <h1 class="page-header">操作</h1>
                        <div class="add-article-box">
                            <h2 class="add-article-box-title"><span>发布</span></h2>
                            <div class="add-article-box-content">
                                <p><label>状态：</label><span class="article-status-display">未发布</span></p>
                                <p><label>公开度：</label><input type="radio" name="visibility" value="0" checked/>公开 <input
                                        type="radio" name="visibility" value="1"/>加密</p>
                                <p><label>发布于：</label><span class="article-time-display"><input style="border: none;"
                                                                                                type="datetime"
                                                                                                name="time"
                                                                                                value="2016-01-09 17:29:37"/></span>
                                </p>
                            </div>
                            <div class="add-article-box-footer">
                                <button class="btn btn-primary" type="submit" name="submit">发布</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>
<jsp:include page="/WEB-INF/page/modal-box.jsp"></jsp:include>
<script src="${path}/background/js/bootstrap.min.js"></script>
<script src="${path}/background/js/admin-scripts.js"></script>
<!--summernote富文本编辑器-->
<link rel="stylesheet" type="text/css" href="../../background/lib/summernote/summernote.css">
<script src="../../background/lib/summernote/summernote.js"></script>
<script src="../../background/lib/summernote/lang/summernote-zh-CN.js"></script>
<script>
    $('#article-content').summernote({
        lang: 'zh-CN'
    });
</script>
</body>
</html>