<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <jsp:include page="/WEB-INF/page/ini.jsp"></jsp:include>
    <title>Mr.L博客管理系统</title>
</head>

<body class="user-select">
<section class="container-fluid">
    <%--公共头部--%>
    <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
    <div class="row">
        <%--公共侧栏--%>
        <jsp:include page="/WEB-INF/page/aside.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-lg-10 col-md-offset-2 main" id="main">
            <h1 class="page-header">信息总览</h1>
            <div class="row placeholders">
                <div class="col-xs-6 col-sm-3 placeholder">
                    <h4>文章</h4>
                    <span class="text-muted">${statistics.get("article_num")} 条</span></div>
                <div class="col-xs-6 col-sm-3 placeholder">
                    <h4>评论</h4>
                    <span class="text-muted">${statistics.get("comment_num")} 条</span></div>
                <div class="col-xs-6 col-sm-3 placeholder">
                    <h4>友链</h4>
                    <span class="text-muted">${statistics.get("flink_num")} 条</span></div>
                <div class="col-xs-6 col-sm-3 placeholder">
                    <h4>访问量</h4>
                    <span class="text-muted">${statistics.get("visit_nun")+applicationScope.get("increaseCountMap").get("pageviews").intValue()}</span></div>
            </div>
            <h1 class="page-header">状态</h1>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <tbody>
                    <tr>
                        <td>登录者: <span>${sessionScope.get("manager").getNickname()}</span>，这是您第 <span>${loginState[0].get("login_num")}</span> 次登录</td>
                    </tr>
                    <tr>
                        <c:choose>
                            <c:when test="${loginState.size()>=2}">
                                <td>上次登录时间: <fmt:formatDate value='${loginState.get(1).get("login_time")}' pattern="yyyy-MM-dd HH:mm:ss"/> , 上次登录IP: ${loginState[1].get("login_ip")}</td>
                            </c:when>
                            <c:otherwise>
                                <td>上次登录时间: 暂无 , 上次登录IP: 暂无
                            </c:otherwise>
                        </c:choose>
                    </tr>
                    </tbody>
                </table>
            </div>
            <h1 class="page-header">系统信息</h1>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                    <tr></tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>管理员个数:</td>
                        <td>1 人</td>
                        <td>服务器软件:</td>
                        <td>${loginState[0].get("server_info")}</td>
                    </tr>
                    <tr>
                        <td>浏览器:</td>
                        <td>${loginState[0].get("login_browser")}</td>
                        <td>JAVA版本:</td>
                        <td>${loginState[0].get("java_version")}</td>
                    </tr>
                    <tr>
                        <td>操作系统:</td>
                        <td>${loginState[0].get("login_os")}</td>
                        <td>JAVA运行方式:</td>
                        <td>${loginState[0].get("java_om")}</td>
                    </tr>
                    <tr>
                        <td>登录者IP:</td>
                        <td>${loginState[0].get("login_ip")}</td>
                        <td>数据库信息:</td>
                        <td>${loginState[0].get("dbInfo")}</td>
                    </tr>
                    <tr>
                        <td>程序版本:</td>
                        <td class="version">${loginState[0].get("program_vs")} <font size="-6" color="#BBB">(${loginState[0].get("program_time")})</font></td>
                        <td>OSS状态:</td>
                        <td>${loginState[0].get("oss_state")==1?"正常":"异常"} <font size="-6" color="#BBB">(最大文件：2M ，表单：8M )</font></td>
                    </tr>
                    <tr>
                        <td>程序编码:</td>
                        <td>${loginState[0].get("program_code")}</td>
                        <td>当前时间:</td>
                        <td>2016-01-08 15:50:30</td>
                    </tr>
                    </tbody>
                    <tfoot>
                    <tr></tr>
                    </tfoot>
                </table>
            </div>
            <footer>
                <h1 class="page-header">程序信息</h1>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <tbody>
                        <tr>
                            <td><span style="display:inline-block; width:8em">版权所有</span> ${loginState[0].get("copyright")}
                            </td>
                        </tr>
                        <tr>
                            <td><span style="display:inline-block;width:8em">页面加载时间</span> PROCESSED IN 1.0835s SECONDS
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </footer>
        </div>
    </div>
</section>
<%--公共信息模态框--%>
<jsp:include page="/WEB-INF/page/modal-box.jsp"></jsp:include>
<script src="${path}/background/js/bootstrap.min.js"></script>
<script src="${path}/background/js/admin-scripts.js"></script>
</body>
</html>
