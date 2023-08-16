<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.eugene.company.ctrl.CompanyCtrl" %>
<%@ page import = "com.eugene.company.item.CompanyItem" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
/*cpyId를 이용하여 company테이블에서 회사 정보 조회*/
/*cpyId와 empId를 이용하여 contract테이블에서 계약 정보 조회*/
String employeeId = request.getParameter("employeeId");
String companyId = request.getParameter("companyId");
out.print(companyId + "<br>");
CompanyCtrl companyCtrl = new CompanyCtrl();
CompanyItem companyItem = new CompanyItem();

List<CompanyItem> companyBean = new ArrayList<CompanyItem>();
companyBean = companyCtrl.selectAllById(companyId);
if(companyBean.size() > 0)  {
	String companyCeo = companyBean.get(0).getCompanyCeo();
	String companyCeoPhone = companyBean.get(0).getCompanyCeoPhone();
	String companyName = companyBean.get(0).getCompanyName();
	String companyPhone = companyBean.get(0).getCompanyPhone();
	int comId = companyBean.get(0).getCompanyId();
	if(companyBean.get(0).getCompanyMemo() == "" || companyBean.get(0).getCompanyMemo() == null)   {
		out.print("");
	}
	else{
		String memo = companyBean.get(0).getCompanyMemo();
		memo = memo.replace("□□", "<br>");
		out.print(memo+"<br>");
	}
%>
<table border="1" width="700" style="margin-right: 30px;">
    <tr align="center">
        <td colspan="2">
            <br><font size="5">회사 정보</font><br><br>
        </td>
    </tr>
    
    <tr align="center">
        <td>
            <br>
            <font size="4">회사 이름</font>
            <br><br>
        </td>   
        <td>
            <%= companyName%>
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
            <input type="text" name="empNation" size="30" required/>
            <br><br>
        </td>
    </tr>
  
    
    <tr align="center">
        <td>
            <br>
            <font size="4">대표전화번호</font>
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
            
            <input type="text" name="empPhone" oninput="hypenTel(this)" maxlength="13" size="30" required/>

            <br><br>
        </td>
    </tr>
    
    <tr align="center">
        <td>
            <br>
            <font size="4">회사전화번호</font>
            <br><br>
        </td>   
        <td>
            <br>
            <input type="text" name="frontEmpNum" size="15" required/>
            -
            <input type-"text" name="backEmpNum" size="15" required/>
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
            <Textarea name="empMemo" rows="5" cols="30" style="font-size:20px";></Textarea>
            <br><br>                
        </td>
    </tr>
</table>
<%} %>
</body>
</html>