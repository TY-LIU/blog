<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%
    request.setAttribute("path", request.getContextPath());
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!doctype html>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="404错误界面">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="${path}/assets/i/favicon.png">
    <title>访问不鸟了</title>
    <link href="${path}/404/error.css?t=201712061512" rel="stylesheet">
</head>
<body>
<div class="wavetext">
    <div class="wavetop">
        <div class="wavelx">
            <img src="404/images/404.svg">
        </div>
        <div class="wavets">
            额，你所做的操作失败了
        </div>
    </div>
    <span class="wavecz">可能是:</span><br>
    <span class="wavecz">我的服务器炸了...</span><br>
    <span class="wavecz">你的手抖输错了....</span>
    <div class="waveqcz">
        <div class="wavegohome waveinput">
            <a href="javascript:history.back();">返回上一级页面</a>
        </div>
        <div class="waveclose waveinput">
            <a href="javascript:history.go(0);">不行，我要重试</a>
        </div>
    </div>
</div>
<div class="waveWrapper waveAnimation">
    <div class="waveWrapperInner bgTop">
        <div class="wave waveTop" style="background-image: url('404/images/wave-top.png')">
        </div>
    </div>
    <div class="waveWrapperInner bgMiddle">
        <div class="wave waveMiddle" style="background-image: url('404/images/wave-mid.png')">
        </div>
    </div>
    <div class="waveWrapperInner bgBottom">
        <div class="wave waveBottom" style="background-image: url('404/images/wave-bot.png')">
        </div>
    </div>
</div>
</body>
</html>
