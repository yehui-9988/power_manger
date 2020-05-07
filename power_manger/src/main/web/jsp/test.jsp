<%--
  Created by IntelliJ IDEA.
  User: YEHUI
  Date: 2019/10/8
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
   <h1>欢迎您！</h1>
<h1>${sessionScope.manager.managerName}</h1>
   <h1>您的IP地址是:${sessionScope.IP}</h1>
   <h1>日志已记录</h1>
</body>
</html>
