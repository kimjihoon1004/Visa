
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.eugene.common.db.SqlSessionCtrl" %>
<%@ page import="com.eugene.user.ctrl.UserCtrl"%>
<%@ page import="com.eugene.user.item.UserItem" %>

<%@ page import="org.apache.ibatis.session.*" %>
<%@ page import="java.util.*" %>

<html>
<!-- VISA -->
<%
int check = 0;
int length = 0;
int pwcheck = 0;
request.setCharacterEncoding("UTF-8");
UserCtrl userCtrl = new UserCtrl();
if(request.getMethod().equalsIgnoreCase("POST"))    {
    try {
        String subtype = request.getParameter("subtype");
        if(subtype.equals("create"))   {        	
            UserItem item = new UserItem();
            String email = request.getParameter("user_id") + "@" + request.getParameter("email");
            String birth = request.getParameter("signupYear") + "-" + request.getParameter("signupMonth") + "-" + request.getParameter("signupDate");
            item.setUserName(request.getParameter("user_name"));
            item.setUserId(email);
            item.setUserPw(request.getParameter("user_pw"));
            item.setUserPhone(request.getParameter("user_phone"));
            item.setUserDate(birth);           
            userCtrl.insertUser(item);
        }
    } finally {
       %>
       <script type = "text/javascript">
       alert("회원 가입 성공");
       location.href="userLogin.jsp";
       </script>
       <%
    }
}
%>
    <head>
        <meta charset="UTF-8">
        <title>회원 가입</title>
        <header>
            <center>
                <h1>Visa Program</h1>
                <hr>
            </center>
        </header>
    </head>
    <body>
        <script type = "text/javascript">
            function newWindow(){
                window.open("userIdCheck.jsp", "userIdCheck", "width=600, height=500, top=50, left=50");
            }
            
            function pwcheck(a, b){
                if(a.value != b.value)  {
                    alert("비밀번호가 일치하지 않습니다!");
                }
                else if(a.value.length < 4 || b.value.length < 4)   {
                    alert("비밀번호는 4자리 이상이어야 합니다.")
                }
                else    {
                    alert("비밀번호가 일치합니다!");
                }
            }

            function lastcheck(a, b){
                var form = document.create;

                if(a.value != b.value)  {
                    alert("비밀번호가 서로 다릅니다!");
                    return false;
                }
                else    {
                    <%
                    pwcheck = 1;
                    %>
                    return true;
                }
            }

            function email_change() {
                //선택하세요
                if(document.create.user_id_mail.options[document.create.user_id_mail.selectedIndex].value == "")  {
                    document.create.email.value = "";
                    document.create.email.readOnly = true;
                }
                //직접입력
                else if(document.create.user_id_mail.options[document.create.user_id_mail.selectedIndex].value == "9")  {
                    document.create.email.readOnly = false;
                    document.create.email.value = "";
                    document.create.email.focus();
                }
                else{
                    document.create.email.value = document.create.user_id_mail.options[document.create.user_id_mail.selectedIndex].value;
                    document.create.email.readOnly=true;
                }
            }

            function check_length(a){
                var size_chk = a.value;
                
                if(size_chk.toString().length < 4)  {
                    alert("비밀번호는 최소 4글자 이상이어야 합니다.");
                    document.create.user.pw.focus();
                    return false;
                }
                else if(size_chk.toString().length > 3)    {
                    <%
                    length = 1;
                    %>
                    return true;
                }
            }
            
            
            
            function value_check() {
                if(!document.create.user_id.value)    {
                    alert("아이디(메일)을 입력하세요!");
                    document.create.user_id.focus();
                    return false;
                }
                else if(!document.create.user_pw.value)   {
                    alert("비밀번호를 입력하세요!");
                    document.create.user_pw.focus();
                    return false;
                }
                else if(!document.create.user_name.value)   {
                    alert("이름을 입력하세요!");
                    document.create.user_name.focus();
                    return false;
                }
                else if(!document.create.user_phone.value)   {
                    alert("전화번호를 입력하세요!");
                    document.create.user_phone.focus();
                    return false;
                }
                else if(!document.create.email.value)   {
                    alert("메일을 완성하세요!");
                    document.create.email.focus();
                    return false;
                }
                else    {
                    <%
                    check = 1;
                    %>
                    return true;
                }
            }
            

        </script>
        <br>
        <fieldset>
            <center>
                <form name="create" onSubmit='return !!(value_check() & lastcheck(user_pw, user_pwcheck) & check_length(user_pw));' method="post">
                    <input type="hidden" name="subtype" value="create"/>                    
                    <table border="2" width="800" cellspacing="0" cellpadding="2">
                        <tr>
                                <td colspan = "2" bgcolor = "lightgray" height = "30" class = "style1"><h2><center>회원 가입</center></h2></td>                    
                        </tr>
                        
                        <tr>
                            <td width = "130" bgcolor = "lightgray" class = "style2"><center>아이디(메일)</center></td>
                            <td  width = "500">
                                <input type="text" name="user_id" id="id" size = "20" maxlength = "20" class = "input_style1" /> @
                                <input type="text" name="email" id="mail" readOnly = true required>
                                <select name="user_id_mail" onchange="email_change()">
                                    <option value = "" selected="selected">선택하세요</option>
                                    <option value = "9">직접입력</option>
                                    <option value = "naver.com">naver.com</option>
                                    <option value = "gmail.com">gmail.com</option>
                                    <option value = "kakao.com">kakao.com</option>
                                </select>
                                
                                
                                <input type="button" style="WIDTH: 50pt; HEIGHT: 20pt" onClick="newWindow()" value="중복확인"/>
                                
                            </td>
                        </tr>
                    
                        <tr>
                            <td width = "130" bgcolor = "lightgray" class = "style2"><center>비밀번호</center></td>
                            <td  width = "500">
                                <input type="password" placeholder="4글자 이상 입력하세요." name="user_pw" size = "20" maxlength = "20" class = "input_style1" />
                            </td>
                        </tr>
                        
                                
                        <tr>
                            <td width = "130" bgcolor = "lightgray" class = "style2"><center>비밀번호확인</center></td>
                            <td  width = "500">
                                <input type="password" placeholder="4글자 이상 입력하세요." name="user_pwcheck" size = "20" maxlength = "20" class = "input_style1" />&nbsp;
                                <input type="button" style="WIDTH: 80pt; HEIGHT: 20pt" onclick="pwcheck(user_pw, user_pwcheck);" value="비밀번호 확인"/>
                            </td>
                        </tr>

                        <tr>
                            <td width = "130" bgcolor = "lightgray" class = "style2"><center>이름</center></td>
                            <td  width = "500">
                                <input type="text" name="user_name" size = "20" maxlength = "20" class = "input_style1" />
                            </td>
                        </tr>

                        <tr>
                            <td width = "130" bgcolor = "lightgray" class = "style2"><center>생년월일</center></td>
                            <td  width = "500">
                                <select id="signupYear" name="signupYear" value="년도">
                                    <%
                                    for (int i = 2023; i >= 1950; i--)
                                    {
                                    %>
                                        <option value="<%=i%>"><%=i%></option>
                                    <%
                                    } 
                                    %>
                                                                    
                                    
                                  </select>
                                  <select id="signupMonth" name="signupMonth" value="월">
                                    <option value="01">1</option>
                                    <option value="02">2</option>
                                    <option value="03">3</option>
                                    <option value="04">4</option>
                                    <option value="05">5</option>
                                    <option value="06">6</option>
                                    <option value="07">7</option>
                                    <option value="08">8</option>
                                    <option value="09">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                  </select>
                                  <select id="signupDate" name="signupDate" value="일">
                                    <option value="01">1</option>
                                    <option value="02">2</option>
                                    <option value="03">3</option>
                                    <option value="04">4</option>
                                    <option value="05">5</option>
                                    <option value="06">6</option>
                                    <option value="07">7</option>
                                    <option value="08">8</option>
                                    <option value="09">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                    <option value="13">13</option>
                                    <option value="14">14</option>
                                    <option value="15">15</option>
                                    <option value="16">16</option>
                                    <option value="17">17</option>
                                    <option value="18">18</option>
                                    <option value="19">19</option>
                                    <option value="20">20</option>
                                    <option value="21">21</option>
                                    <option value="22">22</option>
                                    <option value="23">23</option>
                                    <option value="24">24</option>
                                    <option value="25">25</option>
                                    <option value="26">26</option>
                                    <option value="27">27</option>
                                    <option value="28">28</option>
                                    <option value="29">29</option>
                                    <option value="30">30</option>
                                    <option value="31">31</option>
                                  </select>
                            </td>
                        </tr>

                       

                        <tr>
                            <td width = "130" bgcolor = "lightgray" class = "style2"><center>전화번호</center></td>
                            <td  width = "500">
                                <input type="text" name="user_phone" placeholder="- 빼고 입력하세요." size = "20" maxlength = "20" class = "input_style1" />
                            </td>
                        </tr>
                        
                        
                        
                    </table>
                    <br>
                    <input type = "submit" value="회원가입">&nbsp;
                    <input type = "button" onclick="location.href='userLogin.jsp'" value="뒤로가기">                    
                </form>
            </center>
        </fieldset>
    </body>
</html>