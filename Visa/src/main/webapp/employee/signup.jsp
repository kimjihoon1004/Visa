<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/sessionCheck.inc" %>
<%@ include file="../include/top.inc" %>
<%@ page import = "com.eugene.employee.ctrl.EmployeeCtrl" %>
<%@ page import = "com.eugene.employee.item.EmployeeItem" %>
<%@ page import = "com.eugene.user.item.UserItem" %>
<%@ page import = "com.eugene.user.ctrl.UserCtrl" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계약자 인적사항 관리</title>
</head>
<body>
<br><br><br><br>
<center>

<%
/*로그인 성공 시 아이디를 세션에 설정한 후 user에 있는 id(=PK)를 조회하여 iid변수에 대입*/
String iid = (String) session.getAttribute("iid");
UserCtrl userCtrl = new UserCtrl();
String id = userCtrl.selectId(iid);

/*companyInformation.jsp에서 계약자명단 버튼 클릭시 empCompanyId 변수에 값이 생긴다.*/
String empCompanyId = request.getParameter("empCompanyId");
/*id(=PK)를 세션에 저장하여 user의 pk를 세션에서 가져다 사용한다.*/
session.setAttribute("PK", id);

EmployeeItem empItem = new EmployeeItem();
EmployeeCtrl empCtrl = new EmployeeCtrl();

/*밑에 employeeSearch 입력창에서 이름을 입력받아 해당 값이 있으면 그 값만 테이블에 조회하는 코드*/
List<EmployeeItem> empBean = new ArrayList();
String search = request.getParameter("employeeSearch");
if(empCompanyId == null || empCompanyId == "") {
	if(search == null || search == "")  {
	    empBean = empCtrl.checkAllEmployee();
	}
	else   {
		empBean = empCtrl.selectAllByName(search);
		
		if(empBean.size() == 0){
			%>
			<script>
		        alert("일치하는 데이터가 없습니다.")
		        location.href='signup.jsp';
			</script>
			<%
		}
	}
} else  {
	/*companyInformation.jsp에서 계약자명단 버튼 클릭 후 계약자 인적사항 페이지*/
	empItem.setCompanyId(Integer.valueOf(empCompanyId));
	if(search == null || search == "")  {
		/*계약자 인적사항 페이지에서 이름을 검색하지 않은 경우*/
        empBean = empCtrl.selectAllByCompanyId(empItem);
    }
	else   {
		/*계약자 인적사항 페이지에서 이름을 검색한 경우*/
		empItem.setEmpName(search);
		empBean = empCtrl.selectAllByCompanyIdAndName(empItem);
		
		if(empBean.size() == 0){
            %>
            <script>
                alert("일치하는 데이터가 없습니다.")
                location.href='signup.jsp?empCompanyId=<%=empCompanyId%>';
            </script>
            <%
        }
	}
}

%>
<table border="1" width="1900">
    <tr align="center">
        <td colspan="12 ">
            <br><font size="6">계약자 인적사항</font><br><br>
        </td>
    </tr>
    
    <tr align="center">
        <td width="60">
            순번
        </td>
        <td width="300">
            이름
        </td>
        <td width="120">
            국적
        </td>
        <td width="200">
            전화번호
        </td>
        <td width="200">
            등록번호
        </td>
        <td width="150">
            비자타입
        </td>
        <td width="150">
            체류만료일
        </td>
        <td width="350">
            메모
        </td>
        
        <td width="150">
            회사정보
        </td>
        <td width="100">
            심사표
        </td>
        <td width="100">
            편집
        </td> 
    </tr>
    
    <%for(int i = 0; i < empBean.size(); i++)    {%>
    <%if(i % 2 == 0)    {%>
        <tr bgcolor="yellow" align="center" height="40">
    <%} else { %>
        <tr bgcolor="white" align="center" height="40">
    <%} %>
            <td>
                <!-- 순번 -->
                <%=i+1 %>
            </td>
            <td>
                <!-- 이름 -->
                <%=empBean.get(i).getEmpName() %>
            </td>            
            <td>
                <!-- 국적 -->
                <%=empBean.get(i).getEmpNation() %>
            </td>
            <td>
                <!-- 전화번호 -->
                <%=empBean.get(i).getEmpPhone() %>
            </td>
            <td>
                <!-- 등록번호 -->
                <%=empBean.get(i).getEmpNumber() %>
            </td>
            <td>
                <!-- 비자타입 -->
                <%=empBean.get(i).getEmpVisa() %>
            </td>
            <td>
                <!-- 체류만료일 -->
                <%=empBean.get(i).getEmpDate() %>
            </td>
            <td>
                <!-- 메모 -->
                <br>
                <%if(empBean.get(i).getEmpMemo() == " " || empBean.get(i).getEmpMemo() == null) {%>
	                <Textarea name="contractMemo" rows="5" cols="30" resize:none;" placeholder="메모없음"></Textarea>
	                <br>
	                <button>저장</button>
                <%} else {%>
                    <Textarea name="contractMemo" rows="5" cols="30" resize:none;"><%=empBean.get(i).getEmpMemo().replace("□□", "\n") %></Textarea>
                    <br>
                    <button>저장</button>
                <%} %>
                <br><br>
            </td>
           
            <td>
                <!-- 회사정보 버튼 -->
                <button onClick="location.href='../contract/companyEmployeeContract.jsp?employeeId=<%=empBean.get(i).getEmpId()%>&companyId=<%=empBean.get(i).getCompanyId()%>'">회사정보</button>
            </td>
            <td>
                <!-- 심사표 진입 버튼 -->
                <button onClick="location.href='../judgement/temp.jsp?id=<%=empBean.get(i).getEmpId()%>'">심사표</button>
            </td>
            <td>
                <!-- 계약자 인적사항 편집 -->
                <button>편집</button>
            </td>
        </tr>
    <%}%>
</table>
<br><br>
<form action="signup.jsp">
<input type="text" name="employeeSearch" placeholder="이름 검색" style="font-size:18px; width:300px; height:30px;">&nbsp;<input type="submit" style="font-size:18px; height:33px; width:80px;" value="검색">
</form>
<br>
<input type="button" value="연습장" style="font-size:18px; padding : 10px 10px 10px 10px;" onclick="location.href='temp.jsp'"/>
<input type="button" value="계약자 추가" style="font-size:18px; padding : 10px 10px 10px 10px;" onclick="location.href='employeeAppend.jsp'"/>
</center>
</body>
</html>