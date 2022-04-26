<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/1/4
  Time: 20:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("path", request.getContextPath());
%>
<html>
<head>
    <title>注销</title>
    <script>
        top.location="${path}/login";
    </script>
</head>
<body>

</body>
</html>
