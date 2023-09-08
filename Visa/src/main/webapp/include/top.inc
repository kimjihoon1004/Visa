<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
    <title>JavaScript in HTML Example</title>
</head>
<body>
    <script>
       function logout()    {
            location.href="../user/userLogout.jsp";
       }
    </script>
    
    <input type="button" value="로그아웃"  onClick="logout()" style="font-size:20px; padding : 10px 10px 10px 10px;float:left;"/>&nbsp;&nbsp;
    <input type="button" value="인적사항" onClick="location.href='../employee/signup.jsp'" style="font-size:20px; padding : 10px 10px 10px 10px;float:left;"/>&nbsp;&nbsp;
    <input type="button" value="회사정보" onClick="location.href='../company/companyInformation.jsp'" style="font-size:20px; padding : 10px 10px 10px 10px;float:left;"/>&nbsp;&nbsp;
    
    
</body>
</html>
