<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/sessionCheck.inc" %>
<%@ include file="../include/top.inc" %>
<%@ page import = "com.eugene.company.ctrl.CompanyCtrl" %>
<%@ page import = "com.eugene.company.item.CompanyItem" %>
<%@ page import = "com.eugene.employee.ctrl.EmployeeCtrl" %>
<%@ page import = "com.eugene.employee.item.EmployeeItem" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회사 정보</title>
</head>
<body>
<br><br><br><br>
<%
CompanyCtrl companyCtrl = new CompanyCtrl();
CompanyItem companyItem = new CompanyItem();
EmployeeCtrl employeeCtrl = new EmployeeCtrl();
EmployeeItem employeeItem = new EmployeeItem();

List<CompanyItem> companyBean = new ArrayList();
String search = request.getParameter("companySearch");
if(search == "" || search == null)  {
	companyBean = companyCtrl.checkAllCompany();
} else {
	companyBean = companyCtrl.selectAllByName(search);
}

%>
<center>
    <table border="1" width="1850">
        <tr align="center">
            <td colspan="8">
                <br><font size="10">회사 정보</font><br><br>
            </td>
        </tr>
        
        <tr align="center" height="50">
            <td width="100">
                <p style="font-size:25px;">
                번호
                </p>
            </td>
            <td width="250">
                <p style="font-size:25px;">
                회사이름
                </p>
            </td>
            <td width="200">
                <p style="font-size:25px;">
                대표자
                </p>
            </td>
            <td width="250">
                <p style="font-size:25px;">
                대표전화번호
                </p>
            </td>
            <td width="250">
                <p style="font-size:25px;">
                회사전화번호
                </p>
            </td>
            <td width="400">
                <p style="font-size:25px;">
                회사메모
                </p>
            </td>
            <td width="200">
                <p style="font-size:25px;">
                계약자명단
                </p>
            </td>
            <td width="200">
                <p style="font-size:25px;">
                편집
                </p>
            </td>
            
        </tr>
        
        <%for(int i = 0; i < companyBean.size(); i++)    {
            if(i % 2 == 0)  {%>
                <tr align="center" bgcolor="yellow" height="35">
            <%} else { %>
                <tr align="center" bgcolor="white" height="35">
            <%} %>
                <td>
                    <!-- 번호 -->
                    <p style="font-size:25px;">
                    <%=i+1 %>
                    </p>
                </td>
                <td>
                    <!-- 회사이름 -->
                    <p style="font-size:25px;">
                    <%=companyBean.get(i).getCompanyName() %>
                    </p>
                </td>
                <td>
                    <!-- 대표자 -->
                    <p style="font-size:25px;">
                    <%=companyBean.get(i).getCompanyCeo() %>
                    </p>
                </td>
                <td>
                    <!-- 대표자전화번호 -->
                    <p style="font-size:25px;">
                    <%=companyBean.get(i).getCompanyCeoPhone() %>
                    </p>
                </td>
                <td>
                    <!-- 회사전화번호 -->
                    <p style="font-size:25px;">
                    <%=companyBean.get(i).getCompanyPhone() %>
                    </p>
                </td>
                <td>
                    <br>
                    <!-- 회사메모 -->
                    <%
                    int companyId = companyBean.get(i).getCompanyId();
                    String tempMemo = companyBean.get(i).getCompanyMemo();
                    if(tempMemo == "" || tempMemo == null || tempMemo.equals(null))   {
	                   %>
	                   <Textarea name="contractMemo" rows="5" cols="30" style="font-size:20px; resize:none;" placeholder="메모없음"></Textarea>
                       <br>
                       <button style="font-size:20px;">저장</button>
	                   <%
                    } else  {
                    	tempMemo = tempMemo.replace("□□", "\n");
	                    %>
	                    <Textarea name="contractMemo" rows="5" cols="30" style="font-size:20px; resize:none;" placeholder="메모없음"><%=tempMemo %></Textarea>
                        <br>
                        <button style="font-size:20px;">저장</button>
	                    <%
                    }
                    %>
                    <br><br>
                </td>
                <td>
                    <!-- 계약자명단 -->
                    <%
                    List<String> employeeBean = new ArrayList();
                    employeeBean = employeeCtrl.selectAllCompanyId();
                    int idCount = 0;
                    String tempCompanyId = Integer.toString(companyBean.get(i).getCompanyId());
                    for(int j = 0; j < employeeBean.size(); j++)    {
                    	if(tempCompanyId.equals(employeeBean.get(j)))  {
                    		idCount++;
                    	}
                    }
                    %>
                    <button style="width:70px; font-size:25px;" onclick="location.href='../employee/signup.jsp?empCompanyId=<%=companyBean.get(i).getCompanyId()%>'"><%=idCount %>명</button>
                </td>
                <td>
                    <!-- 편집 버튼 -->
                    <form action="companyAppend.jsp">
                    <input type="hidden" name="alter" value="1">
                    <input type="hidden" name="companyName" value="<%=companyBean.get(i).getCompanyName() %>">
                    <input type="hidden" name="companyCeo" value="<%=companyBean.get(i).getCompanyCeo() %>">
                    <input type="hidden" name="companyCeoPhone" value="<%=companyBean.get(i).getCompanyCeoPhone() %>">
                    <input type="hidden" name="companyPhone" value="<%=companyBean.get(i).getCompanyPhone() %>">
                    <input type="hidden" name="companyMemo" value="<%=companyBean.get(i).getCompanyMemo() %>">
                    <input type="submit" style="width:70px; font-size:25px;" value="편집">
                    </form>
                </td>
            </tr>
            <%
        }%>
        
        
        
        
    </table>
    <br><br>
    <form action="companyInformation.jsp">
    <input type="text" name="companySearch" placeholder="회사 이름 입력" style="width:300px; height:30px; font-size:20px;">&nbsp;<input type="submit" value="검색" style="width:80px; height:35px; font-size:20px;">
    </form>
    <br><br>
	<input type="button" value="회사추가" style="padding : 10px 10px 10px 10px; font-size:20px;" onclick="location.href='companyAppend.jsp'"/>
    <input type="button" value="취소" style="padding : 10px 10px 10px 10px; font-size:20px;" onclick="location.href='../employee/signup.jsp'"/>
</center>
</body>
</html>