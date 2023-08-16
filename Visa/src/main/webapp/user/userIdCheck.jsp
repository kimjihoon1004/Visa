
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.eugene.common.db.SqlSessionCtrl" %>
<%@ page import="com.eugene.user.ctrl.UserCtrl" %>
<%@ page import="com.eugene.user.item.UserItem" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<!-- VISA -->
<head>
<meta charset="EUC-KR">
    <title>Child</title>
    
</head>
<body>
    
    <script type="text/javascript">
	    var result = 0;
	    var iiid = window.opener.document.getElementById("id").value;
	    var mmmail = window.opener.document.getElementById("mail").value;
	    if(iiid == "") {
	    	alert("아이디가 공백입니다. 다시 입력하세요.");
	    	window.close();
	    }
	    if(mmmail == "") {
            alert("이메일이 공백입니다. 다시 입력하세요.");
            window.close();
        }
	    var tcId = iiid + "@" + mmmail;
    </script>
    <%
    UserItem userItem = new UserItem();
    UserCtrl userCtrl = new UserCtrl();
    List<UserItem> userBean = new ArrayList<UserItem>();
    userBean = userCtrl.selectAllUser();
   
    for(int k = 0; k < userBean.size(); k++)  {
    	String temp = userBean.get(k).getUserId();
    	
    %>
	    <script>
	    if(tcId == "<%=temp%>")    {
	    	result += 1;
	    }
	    </script>
    <%} %>
    <br>
    
    <script type="text/javascript">
    if(result > 0)  {
    	alert("중복입니다. 다시 입력하세요.");
    	opener.document.getElementById("id").value = "";
    	opener.document.getElementById("mail").value = "";
    	window.close();
    } else{
    	alert("아이디 사용 가능");
        window.close();
    }
    </script>
    
</body>
</html>
