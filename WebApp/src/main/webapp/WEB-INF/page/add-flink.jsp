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
    <title>增加友情链接 - 异清轩博客管理系统</title>
    <jsp:include page="/WEB-INF/page/ini.jsp"></jsp:include>
</head>

<body class="user-select">
<section class="container-fluid">
    <%--公共头部--%>
    <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
    <div class="row">
        <jsp:include page="/WEB-INF/page/aside.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-lg-10 col-md-offset-2 main" id="main">
            <div class="row">
                <form action="/Flink/add" method="post" class="add-flink-form" autocomplete="off" draggable="false">
                    <div class="col-md-9">
                        <h1 class="page-header">增加友情链接</h1>
                        <div class="add-article-box">
                            <h2 class="add-article-box-title"><span>名称</span></h2>
                            <div class="add-article-box-content">
                                <input type="text" id="flink-name" name="name" class="form-control"
                                       placeholder="在此处输入名称" required autofocus autocomplete="off">
                                <span class="prompt-text">例如：异清轩技术博客</span></div>
                        </div>
                        <div class="add-article-box">
                            <h2 class="add-article-box-title"><span>WEB地址</span></h2>
                            <div class="add-article-box-content">
                                <input type="text" id="flink-url" name="url" class="form-control"
                                       placeholder="在此处输入URL地址" required autocomplete="off">
                                <span class="prompt-text">例子：<code>http://www.ylsat.com/</code>——不要忘了<code>http://</code></span>
                            </div>
                        </div>
                        <div class="add-article-box">
                            <h2 class="add-article-box-title"><span>图像地址</span></h2>
                            <div class="add-article-box-content">
                                <input type="text" id="flink-imgurl" name="imgurl" class="form-control"
                                       placeholder="在此处输入图像地址" required autocomplete="off">
                                <span class="prompt-text">图像地址是可选的，可以为网站LOGO地址等</span></div>
                        </div>
                        <div class="add-article-box">
                            <h2 class="add-article-box-title"><span>描述</span></h2>
                            <div class="add-article-box-content">
                                <textarea class="form-control" name="describe" autocomplete="off"></textarea>
                                <span class="prompt-text">描述是可选的手工创建的内容总结</span></div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <h1 class="page-header">操作</h1>
                        <div class="add-article-box">
                            <h2 class="add-article-box-title"><span>保存</span></h2>
                            <div class="add-article-box-content">
                                <p>
                                    <label>状态：</label>
                                    <span class="article-status-display">未增加</span></p>
                                <p><label>target：</label><input type="radio" name="target" value="0" checked/>_blank&nbsp;&nbsp;<input
                                        type="radio" name="target" value="1"/>_self&nbsp;&nbsp;<input type="radio"
                                                                                                      name="target"
                                                                                                      value="2"/>_top
                                </p>
                                <p><label>rel：</label><input type="radio" name="rel" value="0" checked/>nofollow&nbsp;&nbsp;<input
                                        type="radio" name="rel" value="1"/>none</p>
                                <p>
                                    <label>增加于：</label>
                                    <span class="article-time-display">
                  <input style="border: none;" type="datetime" name="time" value="2016-01-09 17:29:37"/>
                  </span></p>
                            </div>
                            <div class="add-article-box-footer">
                                <button class="btn btn-primary" type="submit" name="submit">增加</button>
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
</body>
</html>