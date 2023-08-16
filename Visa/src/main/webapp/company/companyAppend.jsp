<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/sessionCheck.inc" %>
<%@ include file="../include/top.inc" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%
String alter = request.getParameter("alter");
System.out.println("alter : " + alter);
if(alter != null) {
	System.out.println("수정");
	String companyName = request.getParameter("companyName");
	String companyCeo = request.getParameter("companyCeo");
	String companyCeoPhone = request.getParameter("companyCeoPhone");
	/*
	if(companyCeoPhone != null || companyCeoPhone != "")    {
		companyCeoPhone = companyCeoPhone.replace("-", "");
	}
	*/
	String companyPhone = request.getParameter("companyPhone");
	/*
	if(companyPhone != null || companyPhone != "")    {
	    companyPhone = companyPhone.replace("-", "");
	}
	*/
	String companyMemo = request.getParameter("companyMemo");
	String tempMemo = "";
	if(companyMemo != "" || companyMemo != null)    {
		tempMemo = companyMemo.replace("□□", "\r\n");
	} else {
		
	}
	System.out.println(tempMemo + " 1 " + companyMemo);
%>
    <body>
        <br><br><br>
        <center>
	    <form action="companyUpdateCheck.jsp">
	    <table border="1" width="700">
	        <tr align="center">
	            <td colspan="2">
	                <br><font size="5">회사 정보 편집</font><br><br>
	            </td>
	        </tr>
	        
	        <tr align="center">
	            <td>
	                <br>
	                <font size="4">회사 이름</font>
	                <br><br>
	            </td>   
	            <td>
	                <br>
	                <input type="text" name="companyName" value="<%=companyName %>" size="30" required/>
	                <br><br>
	            </td>
	        </tr>
	        
	        <tr align="center">
	            <td>
	                <br>
	                <font size="4">대표자</font>
	                <br><br>
	            </td>   
	            <td>
	                <br>
	                <input type="text" name="companyCeo" value="<%=companyCeo %>" size="30" required/>
	                <br><br>
	            </td>
	        </tr>
	      
	        
	        <tr align="center">
	            <td>
	                <br>
	                <font size="4">대표자 전화번호</font>
	                <br><br>
	            </td>   
	            <td>
	                <br>
	                
	                <script>
	                  const hypenTel = (target) => {
	                 target.value = target.value
	                   .replace(/[^0-9]/g, '')
	                   .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
	                }
	                
	                </script>
	                
	                <input type="text" name="companyCeoPhone" value="<%=companyCeoPhone %>" oninput="hypenTel(this)" maxlength="13" size="30" required/>
	
	                <br><br>
	            </td>
	        </tr>
	        
	        <tr align="center">
	            <td>
	                <br>
	                <font size="4">회사 전화번호</font>
	                <br><br>
	            </td>   
	            <td>
	                <br>
	              
	                <input type="text" name="companyPhone" value="<%=companyPhone %>" oninput="hypenTel(this)" maxlength="13" size="30" required/>
	
	                <br><br>
	            </td>
	        </tr>
	        
	        
	        <tr align="center">
	            <td>
	                <br>
	                <font size="4">메모</font>
	                <br><br>
	            </td>
	            <td>
	                <br>
	                <%if(tempMemo.equals("null"))   {%>
	                   <Textarea name="companyMemo"  rows="5" cols="30" style="font-size:20px";></Textarea>
	                <%} else {%>
	                   <Textarea name="companyMemo"  rows="5" cols="30" style="font-size:20px";><%=tempMemo %></Textarea>
	                <%} %>
	                <br><br>                
	            </td>
	        </tr>
	        
	        
	        
	    </table>
	    
	    <br>
	    <input type="submit" value="회사 수정"/>
	    <input type="button" value="취소" onclick="history.back()"/>
	    </center>
	    </form>
    <%} else {
        System.out.println("추가");%>
        <br><br><br>
        <center>
        <form action="companyAppendCheck.jsp">
        <table border="1" width="700">
            <tr align="center">
                <td colspan="2">
                    <br><font size="5">회사 추가</font><br><br>
                </td>
            </tr>
            
            <tr align="center">
                <td>
                    <br>
                    <font size="4">회사 이름</font>
                    <br><br>
                </td>   
                <td>
                    <br>
                    <input type="text" name="companyName" size="30" required/>
                    <br><br>
                </td>
            </tr>
            
            <tr align="center">
                <td>
                    <br>
                    <font size="4">대표자</font>
                    <br><br>
                </td>   
                <td>
                    <br>
                    <input type="text" name="companyCeo" size="30" required/>
                    <br><br>
                </td>
            </tr>
          
            
            <tr align="center">
                <td>
                    <br>
                    <font size="4">대표자 전화번호</font>
                    <br><br>
                </td>   
                <td>
                    <br>
                    
                    <script>
                      const hypenTel = (target) => {
                     target.value = target.value
                       .replace(/[^0-9]/g, '')
                       .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
                    }
                    
                    </script>
                    
                    <input type="text" name="companyCeoPhone" oninput="hypenTel(this)" maxlength="13" size="30" required/>
    
                    <br><br>
                </td>
            </tr>
            
            <tr align="center">
                <td>
                    <br>
                    <font size="4">회사 전화번호</font>
                    <br><br>
                </td>   
                <td>
                    <br>
                  
                    <input type="text" name="companyPhone" oninput="hypenTel(this)" maxlength="13" size="30" required/>
    
                    <br><br>
                </td>
            </tr>
            
            
            <tr align="center">
                <td>
                    <br>
                    <font size="4">메모</font>
                    <br><br>
                </td>
                <td>
                    <br>
                    <Textarea name="companyMemo" rows="5" cols="30" style="font-size:20px";></Textarea>
                    <br><br>                
                </td>
            </tr>
            
            
            
        </table>
        
        <br>
        <input type="submit" value="회사 추가"/>
        <button onclick="location.href='companyInformation.jsp'">취소</button>
        </center>
        </form>
    <%} %>
</body>
</html>