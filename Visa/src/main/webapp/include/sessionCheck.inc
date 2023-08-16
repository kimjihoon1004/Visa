<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
    <title>JavaScript in HTML Example</title>
</head>
<body>
    <%
    request.setCharacterEncoding("UTF-8");
    String iidCheck = (String) session.getAttribute("iid");
    
    if(iidCheck == null || iidCheck == "")  {
        %>
        <script>
        alert("로그인 후 사용하세요.");
        location.href="../user/userLogin.jsp"
        </script>
        <%
    }
 %>
    
</body>
</html>
    