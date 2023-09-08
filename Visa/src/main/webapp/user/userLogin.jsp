
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.eugene.common.db.SqlSessionCtrl" %>
<%@ page import="com.eugene.user.ctrl.UserCtrl" %>
<%@ page import="com.eugene.user.item.UserItem" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<!-- VISA -->
<head>
<meta charset="UTF-8">
<title>Visa Program</title>
</head>
<body>
<br><br><br><br>
<center><p style="font-size:70px;">Visa Program</p></center>
        <%
         UserCtrl userCtrl = new UserCtrl();
         request.setCharacterEncoding("UTF-8");
         if(request.getMethod().equalsIgnoreCase("POST"))    {
                String subtype = request.getParameter("subtype");
                if(subtype.equals("login"))   {
                    String id = request.getParameter("uID");
                    String pw = request.getParameter("uPW");
                    String checkpw = userCtrl.checkPw(id);
                    if(pw.equals(checkpw))   {
                        session.setAttribute("iid", id);
                        %>
                        <script type = "text/javascript">
                        location.href="../employee/signup.jsp";
                        </script>
                        <%
                    } else {
                %>
                <script type = "text/javascript">
                   alert("로그인 실패...")
                </script>
                <%
                }
            }
        }
    %>
    
        <script>
            function checkValue()
            {
                var form = document.login;

                if(!form.uID.value){
                    alert("아이디를 입력하세요!");
                    document.login.uID.focus();
                    return false;
                }

                if(!form.uPW.value){
                    alert("비밀번호를 입력하세요!");
                    document.login.uPW.focus();
                    return false;
                }
            }
        </script>
        <fieldset>
            <center>
                <form name="login" onSubmit="return checkValue();" method="post">
                <input type="hidden" name="subtype" value="login"/>
                    <table border="2" width = "800" cellspacing = "0" cellpadding = "2">
                        
                        <tr>
                            <td colspan = "2" bgcolor = "lightgray" height = "30" class = "style1"><h1><center>로그인</center></h1></td>                   
                        </tr>
                        
                        <tr height="50" align="center">
                            <td width = "130" bgcolor = "lightgray" class = "style2">아이디</td>
                            
                            <td  width = "300">
                                <input type="text" name="uID" size = "40" maxlength = "50"  class = "input_style1" />
                            </td>
                        </tr>
                        
                        
                        
                        <tr height="50" align="center">
                            <td width = "130" bgcolor = "lightgray" class = "style2">비밀번호</td>
                            <td  width = "300" >
                                <input type="password" name="uPW" size = "40" maxlength = "50"  class = "input_style1" />
                            </td>
                        </tr>
                    </table>
                
                    
                    <br><br>
                    <center>
                        <input type = "submit"  value="로그인">&nbsp;&nbsp;
                        <input type = "button" onclick = "location.href='createUser.jsp'" value="회원가입"/>&nbsp;&nbsp;
                        <input type = "button"  onclick = "location.href='findUser.jsp'" value="아이디/비밀번호 찾기"/>&nbsp;&nbsp;
                    </center>
                </form>
            </center>
        </fieldset>
</body>
</html>