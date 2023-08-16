<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/sessionCheck.inc" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "com.eugene.employee.ctrl.EmployeeCtrl" %>
<%@ page import = "com.eugene.employee.item.EmployeeItem" %>
<%@ page import = "com.eugene.contract.ctrl.ContractCtrl" %>
<%@ page import = "com.eugene.contract.item.ContractItem" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 추가 실행</title>
</head>
<body>
<!-- 
2023-08-02 02:00
회사 계약 테이블까지 모두 만들었고 값을 불러와서 변수로 만들 것
메모는 employee메모와 동일하게 줄 내림 처리 할 것 
 -->


<!-- 직원추가 -->
<%
/*employee테이블에 넣을 값들 세팅*/
request.setCharacterEncoding("UTF-8");
EmployeeCtrl empCtrl = new EmployeeCtrl();
EmployeeItem empItem = new EmployeeItem();

String name = request.getParameter("empName");
String nation = request.getParameter("empNation");
String phone = request.getParameter("empPhone");
String number = request.getParameter("frontEmpNum") + "-" + request.getParameter("backEmpNum");
String companyId = request.getParameter("companyId");
String visa = request.getParameter("empVisa");
String date = request.getParameter("empDate");
String memo = request.getParameter("empMemo");
/*입력된 메모에서 줄 바꿈을 □□ 로 치환하는 방법(1시간소요)*/
memo = memo.replace("\r\n", "□□");
/*DB에 있던 메모 내용에서 □□ 부분을 다시 줄 내림을 치환하는 방법*/
/*
String temptemp = memo.replace("□□", "<br>");
System.out.println("temptemp : " + temptemp);
*/

empItem.setEmpName(name);
empItem.setEmpNation(nation);
empItem.setEmpPhone(phone);
empItem.setEmpNumber(number);
empItem.setEmpVisa(visa);
empItem.setEmpDate(date);
empItem.setEmpMemo(memo);
empItem.setCompanyId(Integer.valueOf(companyId));

/*contract테이블에 넣을 값들 세팅*/
String contractDate = request.getParameter("contractDate");
String contractRevenue = request.getParameter("contractRevenue");
String contractPayment = request.getParameter("contractPayment");
String contractDepositeDate = request.getParameter("contractDepositeDate");
String contractInsurance = request.getParameter("contractInsurance");
String contractBalance = request.getParameter("contractBalance");
String contractMemo = request.getParameter("contractMemo");
contractMemo = contractMemo.replace("\r\n", "□□");

List<EmployeeItem> empList = new ArrayList<EmployeeItem>();
empList = empCtrl.checkEmployee(empItem);

if(empList.size() == 0){
	/*empList는 이름과 등록번호로 정보를 찾는 리스트로 찾는다 따라서 tempList에 값이 있으면 해당 직원이 있는 것이다.*/
	/*해당 직원이 없는 경우*/
	int temp = empCtrl.insertEmployee(empItem);
	if(temp > 0)   {
		/*회원가입 성공 후 contract에도 해당 정보를 추가한다.*/
		empList = empCtrl.checkEmployee(empItem);
		int empId = empList.get(0).getEmpId();
		int cpyId = Integer.valueOf(companyId);
		ContractItem contractItem = new ContractItem();
		ContractCtrl contractCtrl = new ContractCtrl();
		contractItem.setCompanyId(Integer.toString(cpyId));
		contractItem.setEmployeeId(Integer.toString(empId));
		contractItem.setContractDate(contractDate);
		contractItem.setContractRevenue(contractRevenue);
		contractItem.setContractPayment(contractPayment);
		contractItem.setContractDepositeDate(contractDepositeDate);
		contractItem.setContractInsurance(contractInsurance);
		contractItem.setContractBalance(contractBalance);
		contractItem.setContractMemo(contractMemo);
		int insertContract = contractCtrl.insertContract(contractItem);
		
		if(insertContract > 0)    {
		    System.out.println("직원 추가 및 계약 추가 성공");
		%>          
		    <script type = "text/javascript">
	            alert("회원 가입 성공");
	            location.href="signup.jsp";
	        </script>
			<%
		}
		else{
			System.out.println("직원 추가 성공, 계약 추가 실패");%>
	        <script type = "text/javascript">
	            alert("회원 가입 실패");
	            location.href="signup.jsp";
	        </script>
	        <%
		}
	}
	else   {
		System.out.println("직원 추가 실패");
		%>
        <script type = "text/javascript">
            alert("회원 가입 실패");
            location.href="signup.jsp";
        </script>
        <%
	}
}
else{
	%>
    <script type = "text/javascript">
        alert("직원이 이미 존재합니다.");
        location.href="employeeAppend.jsp";
    </script>
    <%
}

%>

</body>
</html>