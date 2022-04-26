<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/11/1
  Time: 14:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("path", request.getContextPath());
%>
<link rel="apple-touch-icon-precomposed" href="${path}/background/images/icon/icon.png">
<link rel="shortcut icon" href="${path}/background/images/icon/favicon.ico">
<link rel="stylesheet" type="text/css" href="${path}/assets/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${path}/background/css/style.css">
<link rel="stylesheet" type="text/css" href="${path}/background/css/font-awesome.min.css">
<script src="${path}/assets/js/jquery-1.12.2.js" type="text/javascript"></script>
<script src="${path}/assets/js/jquery.cookie.js" type="text/javascript"></script>
<script src="${path}/assets/layer/layer.js" type="text/javascript"></script>
<!--[if gte IE 9]>
<script src="${path}/background/js/html5shiv.min.js" type="text/javascript"></script>
<script src="${path}/background/js/respond.min.js" type="text/javascript"></script>
<script src="${path}/background/js/selectivizr-min.js" type="text/javascript"></script>
<![endif]-->
<!--[if lt IE 9]>
<script>window.location.href = 'upgrade-browser.html';</script>
<![endif]-->
