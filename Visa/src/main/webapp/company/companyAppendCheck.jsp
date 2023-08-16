<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/sessionCheck.inc" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.eugene.company.ctrl.CompanyCtrl" %>
<%@ page import = "com.eugene.company.item.CompanyItem" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String userPk = (String) session.getAttribute("PK");
int pk = Integer.valueOf(userPk);
String companyName = request.getParameter("companyName");
String companyCeo = request.getParameter("companyCeo");
String companyCeoPhone = request.getParameter("companyCeoPhone");
String companyPhone = request.getParameter("companyPhone");
String companyMemo = request.getParameter("companyMemo");
companyMemo = companyMemo.replace("\r\n", "□□");

System.out.println(companyName);
System.out.println(companyCeo);
System.out.println(companyCeoPhone);
System.out.println(companyPhone);
System.out.println(companyMemo);

CompanyCtrl companyCtrl = new CompanyCtrl();
CompanyItem companyItem = new CompanyItem();

companyItem.setCompanyName(companyName);
companyItem.setCompanyCeo(companyCeo);
companyItem.setCompanyCeoPhone(companyCeoPhone);
companyItem.setCompanyPhone(companyPhone);
companyItem.setCompanyMemo(companyMemo);
companyItem.setId(pk);

List<CompanyItem> companyBean = new ArrayList();
companyBean = companyCtrl.checkCompany(companyItem);

if(companyBean.size() == 0) {

	int temp = companyCtrl.insertCompany(companyItem);
	if(temp > 0)    {
		%>
		<script>
		   alert("회사 추가 성공");
		   location.href="companyInformation.jsp";
		</script>
		<%
	} else  {
		%>
		<script>
		   alert("회사 추가 실패");
		   location.href="companyAppendCheck.jsp";
		</script>
		<%
	}
}   else  {
	%>
    <script>
       alert("해당 회사가 이미 존재합니다.");
       location.href="companyAppendCheck.jsp";
    </script>
    <%
}
	%>

<!-- company에 입력 될 값들은 모두 가져왔다. company DB에 값이 있는지 저 값들로 알아보고 값 insert할 것 -->

</body>
</html>