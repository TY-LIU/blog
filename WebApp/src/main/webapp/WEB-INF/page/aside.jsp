<%--公共侧栏--%>
<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%
    String pageName= String.valueOf(request.getRequestURL());
%>
<aside class="col-sm-3 col-md-2 col-lg-2 sidebar">
    <ul class="nav nav-sidebar">
        <li class="main"><a class="jumpPage" href="javaScript:void(0);" name="main">报告</a></li>
    </ul>
    <ul class="nav nav-sidebar">
        <li class="article add-article update-article loadTempArticle"><a class="jumpPage" href="javaScript:void(0);"
                                                                          name="article">文章</a>
        </li>
        <li class="notice add-notice"><a class="jumpPage" href="javaScript:void(0);" name="notice">公告</a></li>
        <li class="comment"><a class="jumpPage" href="javaScript:void(0);" name="comment">评论</a></li>
        <li class="messages"><a class="jumpPage" href="javaScript:void(0);" name="messages">留言</a></li>
    </ul>
    <ul class="nav nav-sidebar">
        <li class="category update-category"><a class="jumpPage" href="javaScript:void(0);" name="category">栏目</a></li>
        <li class="flink record">
            <a class="dropdown-toggle" id="otherMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">其他</a>
            <ul class="dropdown-menu" aria-labelledby="otherMenu">
                <li class="flink"><a class="jumpPage" href="javaScript:void(0);" name="flink">友情链接</a></li>
                <li class="record"><a class="jumpPage" href="javaScript:void(0);" name="record">每日访问量</a>
                </li>
            </ul>
        </li>
    </ul>
    <ul class="nav nav-sidebar">
        <li class="manage-user loginlog"><a class="dropdown-toggle" id="userMenu" data-toggle="dropdown" aria-haspopup="true"
               aria-expanded="false">用户</a>
            <ul class="dropdown-menu" aria-labelledby="userMenu">
                <li class="manage-user"><a class="jumpPage" href="javaScript:void(0);" name="manage-user" title="管理用户">管理用户</a>
                </li>
                <li role="separator" class="divider"></li>
                <li class="loginlog"><a class="jumpPage" href="javaScript:void(0);" name="loginlog" title="管理登录日志">管理登录日志</a>
                </li>
            </ul>
        </li>
        <li class="setting">
            <a class="jumpPage" href="javaScript:void(0);" name="setting" title="管理用户">设置</a>
        </li>
    </ul>
</aside>
<script>
    $(function () {
        var _url="<%=pageName%>";
        var pathname = _url.substring(_url.lastIndexOf("/") + 1, _url.indexOf("."));
        $("li").removeClass("active").parents().find(".nav-sidebar >li." + pathname + "").addClass("active");

        $(".jumpPage").click(function () {
            var page = $(this).attr("name");
            window.location.href = "${path}/login/toPages/" + page + "";
        });
    });
</script>
