<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import = "com.eugene.code.item.CodeItem" %>
<%@ page import = "com.eugene.code.ctrl.CodeCtrl" %>
<%@ page import = "com.eugene.employee.ctrl.EmployeeCtrl" %>
<%@ page import = "com.eugene.employee.item.EmployeeItem" %>
<%@ page import = "com.eugene.company.ctrl.CompanyCtrl" %>
<%@ page import = "com.eugene.company.item.CompanyItem" %>
<%@ page import = "com.eugene.judgement.ctrl.JudgementCtrl" %>
<%@ page import = "com.eugene.judgement.item.JudgementItem" %>
<%@ page import= "java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>항목별 심사표</title>
</head>
<body>
<%
LocalDate today = LocalDate.now();
int todayYear = today.getYear();
EmployeeItem employeeItem = new EmployeeItem();
EmployeeCtrl employeeCtrl = new EmployeeCtrl();
CompanyItem companyItem = new CompanyItem();
CompanyCtrl companyCtrl = new CompanyCtrl();
JudgementItem judgementItem = new JudgementItem();
JudgementCtrl judgementCtrl = new JudgementCtrl();
CodeItem codeItem = new CodeItem();
CodeCtrl codeCtrl = new CodeCtrl();

String id = request.getParameter("id");
System.out.println("id : " + id);

List<EmployeeItem> empBean = new ArrayList<EmployeeItem>();
empBean = employeeCtrl.checkAllEmployee();
%>

<center><h1>점수제 숙련기능인력 전환(E-7-4) 항목별 심사표</h1></center>


<!-- 금액 입력시 3번째자리마다 쉼표 입력 -->
    <script>
    var sumValueName = [];
    var sumValuePoint = [];

    function sumValue(a,b)  {
        if(sumValueName.includes(a))   {
            var deleteIndex = sumValueName.indexOf(a);
            sumValueName.splice(deleteIndex, 1);
            sumValuePoint.splice(deleteIndex,1);
        } 
        
        sumValueName.push(a);
        sumValuePoint.push(b);
        
        alert(sumValueName + "\n" + sumValuePoint);
        
        let sumAllValue = 0;
        
        for(let i = 0; i < sumValuePoint.length; i++)   {
            sumAllValue += parseInt(sumValuePoint[i]);
        }
        
        document.getElementById("totalValue").innerText = sumAllValue;
    }

    var selectBox = document.getElementById("selectBox");
    var inputField = document.getElementById("inputField");
    selectBox.addEventListener("change", function() {
        var selectedValue = selectBox.options[selectBox.selectedIndex].value;  // 선택한 값을 가져옴
        var aaa = "temp.jsp?" + "id=" + selectedValue;
        window.location.href=aaa;     
    });
    
    function printAgeValue(age, nameString, valueString, ageListSize)    {
    	var nameList = nameString.split(",");
    	var valueList = valueString.split(",");
    	var age = parseInt(age) + 10;
    	
    	for(var i = 0; i < parseInt(ageListSize); i++)  {
    		if(age <= parseInt(nameList[i]))   {
    			alert(document.getElementById("ageValueResult"));
    			alert(document.getElementById("selectBox"));
    			document.getElementById("ageValueResult").innerText = 99;
    			//document.getElementById('ageValueResult').innerText = valueList[i];
    			alert("#");
    			break;
    		}
    	}
    }


    // 값이 들어왔는지 확인하는 함수
    function checkSelectValue(a, b, c)   {
        const temp = document.getElementById(a).value;
        // temp[0] 점수, temp[1] 심사내용(서류), temp[2] 이름 index
        const tempString = temp.split(","); 
        
        
        if(tempString[1] == "" || tempString[1] == "null")   {
            document.getElementById(b).innerText = tempString[0];
            document.getElementById(c).innerText = "";
        } else {
            document.getElementById(b).innerText = tempString[0];
            document.getElementById(c).innerText = tempString[1];
            if(parseInt(tempString[0]) == 25 && b == "koreanValueResult")  {
                document.getElementById("sipValueResult").innerText = 5;
                sumValue("sipValueResult", 5);
            } else if(parseInt(tempString[0]) != 25 && b == "koreanValueResult"){
                document.getElementById("sipValueResult").innerText = 0;
                sumValue("sipValueResult", 0);
            }
        }

        
        sumValue(a,tempString[0]);
        
    }

    function checkInputValue(name, value, judgement, size, inputValueId, inputValueResultId, inputValueResultJudgementId)  {
        var sizeValue = parseInt(size);
        var inputValue = parseInt(document.getElementById(inputValueId).value.replace(/,/g, ""));
        
        var nameToList = name.split(",");
        var valueToList = value.split(",");
        var judgementToList = judgement.split(",");
        
        // 입력한 값이 그대로 평가점수에 들어가는 경우
        if(inputValueId == "longevityValue")    {
            if(isNaN(inputValue)) {
                inputValue = 0;
                document.getElementById(inputValueResultId).innerText = inputValue;
                document.getElementById(inputValueResultJudgementId).innerText = "";
            } else {
                for(var i = 0; i < sizeValue; i++)   {
                    if(inputValue >= parseInt(nameToList[i]))    {
                        document.getElementById(inputValueResultId).innerText = inputValue;
                        document.getElementById(inputValueResultJudgementId).innerText = "";
                        if(inputValue > 0){
                            document.getElementById(inputValueResultJudgementId).innerText = judgementToList[i];
                        }
                        break;
                    } else {
                        document.getElementById(inputValueResultId).innerText = 0;
                        document.getElementById(inputValueResultJudgementId).innerText = "";
                        break;
                    }
                }
            }
            sumValue("longevityValue", inputValue);
        }
        // 입력한 값에 따라 정해져 있는 평가점수가 부여되는 경우
        else {
            var score = 0;
            for(var i = 0; i < sizeValue; i++)   {
                if(inputValue >= parseInt(nameToList[i]))    {
                    document.getElementById(inputValueResultId).innerText = valueToList[i];
                    score = valueToList[i];
                    
                    if(judgementToList[i] == "null"){
                        document.getElementById(inputValueResultJudgementId).innerText = "";
                    } else {
                        document.getElementById(inputValueResultJudgementId).innerText = judgementToList[i];
                    }
                    break;
                } else {
                    document.getElementById(inputValueResultId).innerText = 0;
                    document.getElementById(inputValueResultJudgementId).innerText = "";
                }
            }
            
            sumValue(inputValueId, score);
        }
    }
    
    function inputNumberFormat(obj) {
        obj.value = comma(uncomma(obj.value));
    }
    
    function comma(str) {
        str = String(str);
        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    }
    
    function uncomma(str) {
        str = String(str);
        return str.replace(/[^\d]+/g, '');
    }
    </script>
<%
if(id == "" || id == null)  {
	System.out.println("-------------");
    System.out.println("id의 값이 없다.");
    System.out.println("id : " + id);
    System.out.println("-------------");
%>
   
	<table border="1" width="1000" align="center">
	    <tr>
	        <td colspan="6">
	            <font color="red">(주의) 신청인 또는 근무처가 점수제 숙련기능인력 전환에 관한 각종 신청 시 허위 서류를 제출하거나 
	            허위 사실을 기재·진술한 경우 비자 신청 제한 등 불이익을 받을 수 있으며, 관계 법령에 따라 형사처벌을 받을 수 있음</font>
	        </td>
	    </tr>
	    <tr align="center">
	        <td style="background-color:#E2E2E2">
	            성 명
	        </td>
	        <td>
	            <!-- 계약자 이름 -->
	            <select id="selectBox" name="employeeName">
	                <option value="" selected>이름선택</option>
	                <%               
	                int i = 0;
	                for(; i < empBean.size(); i++)   {%>
	                    <option value=<%=empBean.get(i).getEmpId() %>><%=empBean.get(i).getEmpName() %></option>
	                <%} %>
	            </select>
	        </td>
	        <td style="background-color:#E2E2E2">
	            등록번호
	        </td>
	        <td>
	            X
	        </td>
	        <td rowspan="2" style="background-color:#E2E2E2">
	            신 청<br>
	            유 형
	        </td>
	        <td rowspan="2">
	           <!-- 신청유형 -->
	            정기<input type="radio" name="applicationType" value="1"/><br>
	            수시<input type="radio" name="applicationType" value="0"/>
	        </td>
	    </tr>
	    
	    <tr align="center">
	        <td style="background-color:#E2E2E2">
	            회사명
	        </td>
	        <td>
	            X
	        </td>
	        <td style="background-color:#E2E2E2">
	            국적
	        </td>
	        <td>
	            X
	        </td>
	    </tr>
	    
	    <tr>
	        <td align="center" >
	            기본<br>요건
	        </td>
	        <td colspan="5" >
	            <!-- 기본요건 -->
	            ① 최근 10년 이내 5년 이상 E-9, E-10, H-2 자격으로 국내 정상 최업한 자<input type="radio" name="basicRequirement" value="1"/><br>
	            <font color="blue">② 최근 10년 이내 4년 이상 E-9,E-10,H-2 자격으로 국내 정상 취업한 자 중 사회통합<input type="radio" name="basicRequirement" value="2"/></font>
	        </td>
	    </tr>
	    
	    <tr>
	        <td align="center" >
	            점수<br>요건
	        </td>
	        <td colspan="5">
	            <!-- 점수요건 -->
	            ① 산업기여가치 ‘연간소득’ 10점 이상 총 득점 52점 이상<input type="radio" name="scoreRequirement" value="1"/><br>
	            ② 미래기여가치 합계점수가 35점 이상 총 득점 72점 이상<input type="radio" name="scoreRequirement" value="2"/>
	        </td>
	    </tr>
	    
	</table>
	
	
	<table border="1" width="1000" align="center">
	    <tr align="center">
	        <td colspan="4" width="500" style="background-color:#E2E2E2">
	            구분
	        </td>
	        <td width="100" style="background-color:#E2E2E2">
	            평가<br>점수
	        </td>
	        <td width="200" style="background-color:#E2E2E2">
	            심사내용(입증서류 등)
	        </td>
	        <td width="200" style="background-color:#E2E2E2">
	           입력값 설정
	        </td>
	    </tr>
	    <tr align="center">
	        <td rowspan="6" style="background-color:#E2E2E2">
	            기본<br>항목
	        </td>
	        <td colspan="3" style="background-color:#E2E2E2">
	            산업기여가치(연간소득)
	        </td>
	        <td>
	           <!-- 산업기여가치(연간소득) 평가점수 입력칸 -->
	            
	        </td>
	        <td>
	           <!-- 산업기여가치(연간소득) 심사내용 입력칸 -->
	        
	        </td>
	        <td>
	           <!-- 산업기여가치(연간소득) 입력값 입력칸 -->
	        
	        </td>
	    </tr>
	    <tr align="center">
	        <td rowspan="5" style="background-color:#E2E2E2">
	            미래 기여 가치
	        </td>
	        <td rowspan="2" style="background-color:#E2E2E2">
	            숙련도
	        </td>
	        <td style="background-color:#E2E2E2">
	            자격증 소지
	        </td>
	        <td>
	           <!-- 자격증소지 평가점수 입력칸 -->
	        
	        </td>
	        <td>
	           <!-- 자격증소지 심사내용 입력칸 -->
	        
	        </td>
	        <td>
	           <!-- 자격증소지 입력값 입력칸 -->
	           
	        </td>
	    </tr>
	    <tr align="center">
	        <td style="background-color:#E2E2E2">
	            기량검증
	        </td>
	        <td>
	           <!-- 기량검증 평가점수 입력칸 -->
	        
	        </td>
	        <td>
	           <!-- 기량검증 심사내용 입력칸 -->
	        
	        </td>
	        <td>
                <!-- 기량검증 입력값 입력칸 -->
                
            </td>
	    </tr>
	    <tr align="center">
	        <td colspan="2" style="background-color:#E2E2E2">
	            학력 
	        </td>
	        <td>
	           <!-- 학력 평가점수 입력칸 -->
	           
	        </td>
	        <td>
	           <!-- 학력 심사내용 입력칸 -->
	           
	        </td>
	        <td>
                <!-- 학력 입력값 입력칸 -->
                
            </td>
	    </tr>
	    <tr align="center">
	        <td colspan="2" style="background-color:#E2E2E2">
	            연령
	        </td>
	        <td>
               <!-- 학력 평가점수 입력칸 -->
               
            </td>
            <td>
               <!-- 연령 심사내용 입력칸 -->
               
            </td>
            <td>
                <!-- 연령 입력값 입력칸 -->
                
            </td>
	    </tr>
	    <tr align="center">
	        <td colspan="2" style="background-color:#E2E2E2">
	            한국어능력
	        </td>
	        <td>
               <!-- 한국어능력 평가점수 입력칸 -->
               
            </td>
            <td>
               <!-- 한국어능력 심사내용 입력칸 -->
               
            </td>
            <td>
                <!-- 한국어능력 입력값 입력칸 -->
                
            </td>
	    </tr>
	    <tr align="center">
	        <td rowspan="7" style="background-color:#E2E2E2">
	            선택<br>항목
	        </td>
	        <td colspan="3" style="background-color:#E2E2E2">
	            근속기간
	        </td>
	        <td>
               <!-- 근속기간 평가점수 입력칸 -->
               
            </td>
            <td>
               <!-- 근속기간 심사내용 입력칸 -->
               
            </td>
            <td>
                <!-- 근속기간 입력값 입력칸 -->
                
            </td>
	    </tr>
	    <tr align="center">
	        <td rowspan="2" style="background-color:#E2E2E2">
	            보유 자산
	        </td>
	        <td colspan="2" style="background-color:#E2E2E2">
	            정기적금
	        </td>
	        <td>
               <!-- 정기적금 평가점수 입력칸 -->
               
            </td>
            <td>
               <!-- 정기적금 심사내용 입력칸 -->
               
            </td>
            <td>
                <!-- 정기적금 입력값 입력칸 -->
                
            </td>
	    </tr>
	    <tr align="center">
	        <td colspan="2" style="background-color:#E2E2E2">
	            국내자산
	        </td>
	        <td>
               <!-- 국내자산 평가점수 입력칸 -->
               
            </td>
            <td>
               <!-- 국내자산 심사내용 입력칸 -->
               
            </td>
            <td>
                <!-- 국내자산 입력값 입력칸 -->
                
            </td>
	    </tr>
	    <tr align="center">
	        <td rowspan="2" style="background-color:#E2E2E2">
	            근무 경력
	        </td>
	        <td colspan="2" style="background-color:#E2E2E2">
	            뿌리산업분야
	        </td>
	        <td>
               <!-- 뿌리산업분야 평가점수 입력칸 -->
               
            </td>
            <td>
               <!-- 뿌리산업분야 심사내용 입력칸 -->
               
            </td>
            <td>
                <!-- 뿌리산업분야 입력값 입력칸 -->
                
            </td>
	    </tr>
	    <tr align="center">
	        <td colspan="2" style="background-color:#E2E2E2">
	            일반제조업 등
	        </td>
	        <td>
               <!-- 일반제조업 평가점수 입력칸 -->
               
            </td>
            <td>
               <!-- 일반제조업 심사내용 입력칸 -->
               
            </td>
            <td>
                <!-- 일반제조업 입력값 입력칸 -->
                
            </td>
	    </tr>
	    <tr align="center">
	        <td rowspan="2" style="background-color:#E2E2E2">
	            교육,<br>연수
	        </td>
	        <td colspan="2" style="background-color:#E2E2E2">
	            교육경험
	        </td>
	        <td>
               <!-- 교육경험 평가점수 입력칸 -->
               
            </td>
            <td>
               <!-- 교육경험 심사내용 입력칸 -->
               
            </td>
            <td>
                <!-- 교육경험 입력값 입력칸 -->
                
            </td>
	    </tr>
	    <tr align="center">
	        <td colspan="2" style="background-color:#E2E2E2">
	            연수경험
	        </td>
	        <td>
               <!-- 연수경험 평가점수 입력칸 -->
               
            </td>
            <td>
               <!-- 연수경험 심사내용 입력칸 -->
               
            </td>
            <td>
                <!-- 연수경험 입력값 입력칸 -->
                
            </td>
	    </tr>
	    <tr align="center">
	        <td colspan="2" rowspan="7" style="background-color:#E2E2E2">
	            가점
	        </td>
	        <td colspan="2" style="background-color:#E2E2E2">
	            국내유학경험
	        </td>
	        <td>
               <!-- 국내유학경험 평가점수 입력칸 -->
               
            </td>
            <td>
               <!-- 국내유학경험 심사내용 입력칸 -->
               
            </td>
            <td>
                <!-- 국내유학경험 입력값 입력칸 -->
                
            </td>
	    </tr>
	    <tr align="center">
	        <td colspan="2" style="background-color:#E2E2E2">
	            부처 추천
	        </td>
	        <td>
               <!-- 부처추천 평가점수 입력칸 -->
               
            </td>
            <td>
               <!-- 부처추천 심사내용 입력칸 -->
               
            </td>
            <td>
                <!-- 부처추천 입력값 입력칸 -->
                
            </td>
	    </tr>
	    <tr align="center">
	        <td colspan="2" style="background-color:#E2E2E2">
	            읍면지역 근무
	        </td>
	        <td>
               <!-- 읍면지역근무 평가점수 입력칸 -->
               
            </td>
            <td>
               <!-- 읍면지역근무 심사내용 입력칸 -->
               
            </td>
            <td>
                <!-- 읍면지역근무 입력값 입력칸 -->
                
            </td>
	    </tr>
	    <tr align="center">
	        <td colspan="2" style="background-color:#E2E2E2">
	            사회공헌
	        </td>
	        <td>
               <!-- 사회공헌 평가점수 입력칸 -->
               
            </td>
            <td>
               <!-- 사회공헌 심사내용 입력칸 -->
               
            </td>
            <td>
                <!-- 사회공헌 입력값 입력칸 -->
                
            </td>
	    </tr>
	    <tr align="center">
	        <td colspan="2" style="background-color:#E2E2E2">
	            납세실적
	        </td>
	        <td>
               <!-- 납세실적 평가점수 입력칸 -->
               
            </td>
            <td>
               <!-- 납세실적 심사내용 입력칸 -->
               
            </td>
            <td>
                <!-- 납세실적 입력값 입력칸 -->
                
            </td>
	    </tr>
	    <tr align="center">
	        <td colspan="2" style="background-color:#E2E2E2">
	            <font color="blue">사회통합프로그램 이수</font>
	        </td>
	        <td>
               <!-- 사회통합프로그램 평가점수 입력칸 -->
               
            </td>
            <td>
               <!-- 사회통합프로그램 심사내용 입력칸 -->
               
            </td>
            <td>
                <!-- 사회통합프로그램 입력값 입력칸 -->
                
            </td>
	    </tr>
	    <tr align="center">
	        <td colspan="2" style="background-color:#E2E2E2">
	            <font color="blue">인구감소지역 근무</font>
	        </td>
	        <td>
               <!-- 인구감소지역 근무 평가점수 입력칸 -->
               
            </td>
            <td>
               <!-- 인구감소지역 근무 심사내용 입력칸 -->
               
            </td>
            <td>
                <!-- 인구감소지역 근무 입력값 입력칸 -->
                
            </td>
	    </tr>
	    <tr align="center">
	        <td colspan="2" rowspan="2" style="background-color:#E2E2E2">
	            감점
	        </td>
	        <td colspan="2" style="background-color:#E2E2E2">
	            출입국관리법 위반
	        </td>
	        <td>
               <!-- 출입국관리법 위반 평가점수 입력칸 -->
               
            </td>
            <td>
               <!-- 출입국관리법 위반 심사내용 입력칸 -->
               
            </td>
            <td>
                <!-- 출입국관리법 위반 입력값 입력칸 -->
                
            </td>
	    </tr>
	    <tr align="center">
	        <td colspan="2" style="background-color:#E2E2E2">
	            기타 국내법 위반
	        </td>
	        <td>
               <!-- 기타 국내법 위반 평가점수 입력칸 -->
               
            </td>
            <td>
               <!-- 기타 국내법 위반 심사내용 입력칸 -->
               
            </td>
            <td>
                <!-- 기타 국내법 위반 입력값 입력칸 -->
                
            </td>
	    </tr> 
	    <tr align="center">
	        <td colspan="4" width="600" style="background-color:#E2E2E2">
	            총   점
	        </td>
	        <td width="100" style="background-color:yellow">
	            <!-- 총점 -->
	            
	        </td>
	        <td colspan="2" width="500">
	           <!-- 합격여부 -->
	           
	        </td>
	    </tr>
	</table>
<%} else {
    System.out.println("-------------");
    System.out.println("id의 값이 있다.");
    System.out.println("id : " + id);
    System.out.println("-------------");
    List<EmployeeItem> tempEmployeeBean = new ArrayList<EmployeeItem>();
    List<CompanyItem> tempCompanyBean = new ArrayList<CompanyItem>();
    List<JudgementItem> tempJudgementBean = new ArrayList<JudgementItem>();
    
    /**
    id의 값, 즉 해당 계약자의 id를 이용하여 employee 테이블에서 모든 값을 조회한다. 
    **/
    tempEmployeeBean = employeeCtrl.selectAllById(id);
    /**
    tempEmployeeBean에서 언급한 계약자의 id(=id) 값으로 해당 계악자의 정보를 모두 조회하여 id를 얻어 해당 계약자의 회사 정보를 조회한다.
    **/
    tempCompanyBean = companyCtrl.selectAllById(Integer.toString(tempEmployeeBean.get(0).getCompanyId()));
    
    /**
    tempEmployeeBean에서 언급한 계약자의 id(=id) 값으로 해당 계약자의 id를 이용하여 심사정보를 모두 조회한다.
    **/
    tempJudgementBean = judgementCtrl.selectAllByEmpId(Integer.toString(tempEmployeeBean.get(0).getEmpId()));
    
    %>   
    <form action="insertJudgement.jsp">
    <input type="hidden" name="id" value="<%=id %>">
    <table border="1" width="1000" align="center">
        <tr>
            <td colspan="6">
                <font color="red">(주의) 신청인 또는 근무처가 점수제 숙련기능인력 전환에 관한 각종 신청 시 허위 서류를 제출하거나 
                허위 사실을 기재·진술한 경우 비자 신청 제한 등 불이익을 받을 수 있으며, 관계 법령에 따라 형사처벌을 받을 수 있음</font>
            </td>
        </tr>
        <tr align="center">
            <td style="background-color:#E2E2E2">
                성 명
            </td>
            <td>
                <!-- 계약자 이름 -->
                <select id="selectBox" name="employeeName">
                    <%               
                    int nameIndex = 0;
                    for(int i = 0; i < empBean.size(); i++)   {
                        if(empBean.get(i).getEmpName().equals(tempEmployeeBean.get(0).getEmpName())) {
                            nameIndex = i;%>
                            <option value=<%=empBean.get(i).getEmpId() %> selected><%=empBean.get(i).getEmpName() %></option>
                            
                        <%} else {
                        	%>
                            <option value=<%=empBean.get(i).getEmpId() %>><%=empBean.get(i).getEmpName() %></option>
                        <%} %>
                    <%} %>
                </select>
            </td>
            <input type="hidden" name="name" value="<%=empBean.get(nameIndex).getEmpName()%>">
            <td style="background-color:#E2E2E2">
                등록번호
            </td>
            <td>
                <%= tempEmployeeBean.get(0).getEmpNumber()%>
            </td>
            <td rowspan="2" style="background-color:#E2E2E2">
                신 청<br>
                유 형
            </td>
            <td rowspan="2">
                <%if(tempJudgementBean.size()== 0)  {%>
                    정기<input type="radio" name="applicationType" value="1"/><br>
                    수시<input type="radio" name="applicationType" value="2"/>
                <%} else {
                    if(tempJudgementBean.get(0).getApplicationType() == "1")   {%>
	                    정기<input type="radio" name="applicationType" value="1" checked/><br>
	                    수시<input type="radio" name="applicationType" value="2"/>
	                <%} else if(tempJudgementBean.get(0).getApplicationType() == "2")   {%>
	                    정기<input type="radio" name="applicationType" value="1" /><br>
	                    수시<input type="radio" name="applicationType" value="2" checked/>
                    <%} %>
                <%} %>
            </td>
        </tr>
        
        <tr align="center">
            <td style="background-color:#E2E2E2">
                회사명
            </td>
            <td>
                <%=tempCompanyBean.get(0).getCompanyName() %>
            </td>
            <td style="background-color:#E2E2E2">
                국적
            </td>
            <td>
                <%=tempEmployeeBean.get(0).getEmpNation() %>
            </td>
        </tr>
        <tr>
            <td align="center" >
                기본<br>요건
            </td>
            <td colspan="5" >
                <%if(tempJudgementBean.size() == 0) {%>
	                ① 최근 10년 이내 5년 이상 E-9, E-10, H-2 자격으로 국내 정상 최업한 자<input type="radio" name="basicRequirement" value="1"/><br>
	                <font color="blue">② 최근 10년 이내 4년 이상 E-9,E-10,H-2 자격으로 국내 정상 취업한 자 중 사회통합<input type="radio" name="basicRequirement" value="2"/></font>
                <%} else { 
	                if(tempJudgementBean.get(0).getBasicRequirement() == "1")  {%>
	                    ① 최근 10년 이내 5년 이상 E-9, E-10, H-2 자격으로 국내 정상 최업한 자<input type="radio" name="basicRequirement" value="1" checked/><br>
	                    <font color="blue">② 최근 10년 이내 4년 이상 E-9,E-10,H-2 자격으로 국내 정상 취업한 자 중 사회통합<input type="radio" name="basicRequirement" value="2"/></font>
	                <%} else if(tempJudgementBean.get(0).getBasicRequirement() == "2")  {%>
	                    ① 최근 10년 이내 5년 이상 E-9, E-10, H-2 자격으로 국내 정상 최업한 자<input type="radio" name="basicRequirement" value="1"/><br>
	                    <font color="blue">② 최근 10년 이내 4년 이상 E-9,E-10,H-2 자격으로 국내 정상 취업한 자 중 사회통합<input type="radio" name="basicRequirement" value="2" checked/></font>
	                <%} %>
                <%} %>
            </td>
        </tr>
        
        <tr>
            <td align="center" >
                점수<br>요건
            </td>
            <td colspan="5">
                <%if(tempJudgementBean.size() == 0)    {%>
	                ① 산업기여가치 ‘연간소득’ 10점 이상 총 득점 52점 이상<input type="radio" name="scoreRequirement" value="1"/><br>
	                ② 미래기여가치 합계점수가 35점 이상 총 득점 72점 이상<input type="radio" name="scoreRequirement" value="2"/>
	            <%} else {
	            	if(tempJudgementBean.get(0).getScoreRequirement() == "1") {%>
		                ① 산업기여가치 ‘연간소득’ 10점 이상 총 득점 52점 이상<input type="radio" name="scoreRequirement" value="1" checked/><br>
	                    ② 미래기여가치 합계점수가 35점 이상 총 득점 72점 이상<input type="radio" name="scoreRequirement" value="2"/>
		            <%} else if(tempJudgementBean.get(0).getScoreRequirement() == "2") {%>
		                ① 산업기여가치 ‘연간소득’ 10점 이상 총 득점 52점 이상<input type="radio" name="scoreRequirement" value="1"/><br>
	                    ② 미래기여가치 합계점수가 35점 이상 총 득점 72점 이상<input type="radio" name="scoreRequirement" value="2" checked/>
		            <%} %>
		        <%} %>
            </td>
        </tr>
        
    </table>
    
    
    <table border="1" width="1000" align="center">
        <tr align="center">
            <td colspan="4" width="500" style="background-color:#E2E2E2">
                구분
            </td>
            <td width="100" style="background-color:#E2E2E2">
                평가<br>점수
            </td>
            <td width="200" style="background-color:#E2E2E2">
                심사내용(입증서류 등)
            </td>
            <td width="200" style="background-color:#E2E2E2">
               입력값 설정
            </td>
        </tr>
        <tr align="center">
            <td rowspan="6" style="background-color:#E2E2E2">
                기본<br>항목
            </td>
            <td colspan="3" style="background-color:#E2E2E2">
                <!-- annualIncome -->
                산업기여가치(연간소득)
            </td>
            <td>
                <!-- 산업기여가치(연간소득) 평가점수 입력칸 -->
                <!-- 산업기여가치 입력값이 33000000 이상이면 20점, 30000000 이상이면 15점, 26000000 이상이면 10점, 26000000 미만이면 0점-->
                <div id='annualIncomeValueResult'></div>
            </td>
            <td>
                <!-- 산업기여가치(연간소득) 심사내용 입력칸 -->
                <!-- 들어갈 값 없음 -->
                <div id='annualIncomeValueResultJudgement'></div>
                
            </td>
            <td>
                <!-- 산업기여가치(연간소득) 입력값 입력칸 -->
                <%
                String annualIncomeId = codeCtrl.selectIdByName("연간소득");
                List<CodeItem> annualIncomeList = new ArrayList<CodeItem>();
                annualIncomeList = codeCtrl.selectAllByParentId(annualIncomeId);
                
                ArrayList<String> annualIncomeNameList = new ArrayList<>();
                ArrayList<Integer> annualIncomeValueList = new ArrayList<>();
                ArrayList<String> annualIncomeJudgementList = new ArrayList<>(); 
                
                for(int i = 0; i < annualIncomeList.size(); i++)    {
                	annualIncomeNameList.add(annualIncomeList.get(i).getCodeName());
                	annualIncomeValueList.add(annualIncomeList.get(i).getCodeValue());
                	annualIncomeJudgementList.add(annualIncomeList.get(i).getCodeJudgement());
                }
                
                String annualIncomeNameString = annualIncomeNameList.toString().substring(1,annualIncomeNameList.toString().length()-1);
                String annualIncomeValueString = annualIncomeValueList.toString().substring(1,annualIncomeValueList.toString().length()-1);
                String annualIncomeJudgementString = annualIncomeJudgementList.toString().substring(1,annualIncomeJudgementList.toString().length()-1);
                
                %>
                <input style="width:200px;" type="text" name="annualIncomeValue" id="annualIncomeValue" onkeyup="inputNumberFormat(this)" onChange="checkInputValue('<%=annualIncomeNameString%>', '<%=annualIncomeValueString %>', '<%=annualIncomeJudgementString %>'
                , '<%=annualIncomeList.size()%>', 'annualIncomeValue', 'annualIncomeValueResult', 'annualIncomeValueResultJudgement')"/>
                
            </td>
        </tr>
        <tr align="center">
            <td rowspan="5" style="background-color:#E2E2E2">
                미래 기여 가치
            </td>
            <td rowspan="2" style="background-color:#E2E2E2">
                숙련도
            </td>
            <td style="background-color:#E2E2E2">
                <!-- license -->
                <!-- code테이블 code_id = 1, code_name = 자격증 -->
                자격증 소지
            </td>
            <td>
                <!-- 자격증소지 평가점수 입력칸 -->
                <!-- 자격증소지 입력값이 "기사"일 경우 20점, "산업기사"일 경우 15점, "기능사"일 경우 10점 -->
                <div id="licenseValueResult"></div>
            </td>
            <td>
                <!-- 자격증소지 심사내용 입력칸 -->
                <!-- 자격증소지 평가점수가 0보다 크다면 "자격증사본제출"이라고 출력한다. -->
                <div id="licenseValueJudgement"></div>
            </td>
            <td>
               <!-- 자격증소지 입력값 입력칸 -->
               <%
               // tempLicense는 code테이블에서 '자격증'의 code_id를 조회한 후, parent_id가 code_id인 값들을 ArrayList로 구성한다.
               String licenseId = codeCtrl.selectIdByName("자격증");
               List<CodeItem> licenseList = new ArrayList<CodeItem>();
               licenseList = codeCtrl.selectAllByParentId(licenseId);
               
               // 해당 계약자에게 심사표가 없는 경우
               if(tempJudgementBean.size() == 0)  {%>
	               <select style="width:200px;" id="licenseValue" name="licenseValue" onChange="checkSelectValue('licenseValue','licenseValueResult','licenseValueJudgement')">
	                   <%for(int i = 0; i < licenseList.size(); i++)    {
	                	   String tempString = licenseList.get(i).getCodeValue() + "," + licenseList.get(i).getCodeJudgement() + "," + i;	                	  
	                	   %>
	                       <%if(i == 0)    {%>
	                           <option value="<%=tempString %>" selected><%=licenseList.get(i).getCodeName() %></option>
	                       <%} else {%>
	                           <option value="<%=tempString %>"><%=licenseList.get(i).getCodeName() %></option>
	                       <%} %>
	                   <%} %>
	               </select>
               <%}
               
               // 해당 계약자에게 심사표가 있는 경우
               else { %>
                   <select style="width:200px;" id="licenseValue" name="licenseValue" onChange="checkSelectValue('licenseValue','licenseValueResult','licenseValueJudgement')">
                       <%for(int i = 0; i < licenseList.size(); i++)    {
                    	   String tempString = licenseList.get(i).getCodeValue() + "," + licenseList.get(i).getCodeJudgement() + "," + i;
                           
                           if(tempJudgementBean.get(0).getLicense().equals(Integer.toString(i)))    {%>
                               <option value="<%=tempString %>" selected><%=licenseList.get(i).getCodeName() %></option> 
                           <%} else {%>
                               <option value="<%=tempString %>"><%=licenseList.get(i).getCodeName() %></option>
                           <%} %>
                       <%} %>
                   
                   </select>
               <%} %>
            </td>
        </tr>
        <tr align="center">
            <td style="background-color:#E2E2E2">
                <!-- workmanship -->
                기량검증
            </td>
            <td>
                <!-- 기량검증 평가점수 입력칸 -->
                <!-- 기량검증 입력값이 "통과"라면 10점, "통과못함"이면 0점 -->
                <div id="workmanshipValueResult"></div>
            </td>
            <td>
                <!-- 기량검증 심사내용 입력칸 -->
                <!-- 기량검증 평가점수가 0보다 크다면 "서류제출"이라고 출력한다. -->
                <div id="workmanshipValueJudgement"></div>
                
            </td>
            <td>
                <!-- 기량검증 입력값 입력칸 -->                
                <%
                String workmanshipId = codeCtrl.selectIdByName("기량검증");
                List<CodeItem> workmanshipBean = new ArrayList<CodeItem>();
                workmanshipBean = codeCtrl.selectAllByParentId(workmanshipId);
                String c = "";
                
                if(tempJudgementBean.size() == 0)     {%>      
                    <select style="width:200px;" id="workmanshipValue" name="workmanshipValue" onChange="checkSelectValue('workmanshipValue','workmanshipValueResult','workmanshipValueJudgement')">
                        <%for(int i = 0; i < workmanshipBean.size(); i ++)     {
                        	String tempString = workmanshipBean.get(i).getCodeValue() + "," + workmanshipBean.get(i).getCodeJudgement() + "," + i;
                        	
                        	if(i == 0)  {%>
                                <option value="<%=tempString %>" selected><%=workmanshipBean.get(i).getCodeName() %></option>                                                             
                            <%} else {%>
                                <option value="<%=tempString %>"><%=workmanshipBean.get(i).getCodeName() %></option>                                
                            <%} %>
                        <%} %>
                    </select>
                <%} else {%>
                    <select style="width:200px;" id="workmanshipValue" name="workmanshipValue" onChange="checkSelectValue('workmanshipValue','workmanshipValueResult','workmanshipValueJudgement')">
                        <%for(int i = 0; i < workmanshipBean.size(); i++)  {
                        	String tempString = workmanshipBean.get(i).getCodeValue() + "," + workmanshipBean.get(i).getCodeJudgement() + "," + i;
                        	
                        	if(tempJudgementBean.get(0).getWorkmanship().equals(Integer.toString(i)))   {%>
                                <option value="<%= tempString %>" selected><%=workmanshipBean.get(i).getCodeName() %></option>
                            <%} else {%>
                                <option value="<%= tempString %>"><%=workmanshipBean.get(i).getCodeName() %></option>                               
                            <%} %>
                        <%} %>
                    </select>  
                <%} %>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2" style="background-color:#E2E2E2">
                <!-- education -->
                학력
            </td>
            <td>
               <!-- 학력 평가점수 입력칸 -->
               <div id='educationValueResult'></div>
               
            </td>
            <td>
               <!-- 학력 심사내용 입력칸 -->
               <div id='educationValueResultJudgement'></div>
               
            </td>
            <td>
                <!-- 학력 입력값 입력칸 -->
	            <%
	            String educationId = codeCtrl.selectIdByName("학력");
	            List<CodeItem> educationBean = new ArrayList<CodeItem>();
	            educationBean = codeCtrl.selectAllByParentId(educationId);
	            
	            if(tempJudgementBean.size() == 0)    {%>
	                <select style="width:200px;" id="educationValue" name="educationValue" onChange="checkSelectValue('educationValue','educationValueResult','educationValueResultJudgement')">
	                   <%for(int i = 0; i < educationBean.size(); i++)     {
	                	   String tempString = Integer.toString(educationBean.get(i).getCodeValue()) + "," + educationBean.get(i).getCodeJudgement() + "," + i;
	                       if(i == 0)    { %>
	                           <option value="<%=tempString %>" selected><%=educationBean.get(i).getCodeName() %></option>
	                       <%} else { %>
	                           <option value="<%=tempString %>"><%=educationBean.get(i).getCodeName() %></option>
	                       <%} %>
	                   <%} %>
	                </select>
	            <%} else   {%>
                    <select style="width:200px;" id="educationValue" name="educationValue" onChange="checkSelectValue('educationValue','educationValueResult','educationValueResultJudgement')">
                        <%for(int i = 0; i < educationBean.size(); i++)     {
                        	String tempString = Integer.toString(educationBean.get(i).getCodeValue()) + "," + educationBean.get(i).getCodeJudgement() + "," + i;
                            
                        	if(tempJudgementBean.get(0).getEducation().equals(Integer.toString(i)))  { %>
                                <option value="<%=tempString %>" selected><%=educationBean.get(i).getCodeName() %></option>
                            <%} else { %>
                                <option value="<%=tempString %>"><%=educationBean.get(i).getCodeName() %></option>
                            <%} %>
                        <%} %>
                    </select>
                <%} %>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2" style="background-color:#E2E2E2">
                <!-- age -->
                연령
            </td>
            <td>
                <!-- 연령 평가점수 입력칸 -->
                <!-- 연령 입력값이 24이하라면 20점, 27이하라면 17점, 30이하라면 14점, 33이하라면 11점, 36이하라면 8점, 39이하라면 5점 -->
                <%
                String empDate = tempEmployeeBean.get(0).getEmpDate();
                System.out.println("날짜 : " + empDate);
                String year = empDate.substring(0,4);
                String month = empDate.substring(5,7);
                if(month.substring(0,1).equals("0"))   {
                   month = month.substring(1);
                }
                String day = empDate.substring(8);
                if(day.substring(0,1).equals("0"))   {
                    day = day.substring(1);
                }
                int empAge = todayYear - Integer.valueOf(year);
                
                String ageId = codeCtrl.selectIdByName("연령");
                List<CodeItem> ageList = new ArrayList<CodeItem>();
                ageList = codeCtrl.selectAllByParentId(ageId);
                
                for(int i = 0; i < ageList.size(); i++) {
                	if(empAge <= Integer.parseInt(ageList.get(i).getCodeName()))    {
                		out.print(ageList.get(i).getCodeValue());
                		%>
                		<script>
                		sumValue("age", <%=ageList.get(i).getCodeValue() %>);
                		</script>
                		<%
                		break;
                	}
                }
                
                %>
               
            </td>
            <td>
                <!-- 연령 심사내용 입력칸 -->
                <!-- 계약자의 생년월일이 1983.07.22라고 한다면 "1983년 7월 22일생"이라고 출력한다. -->
                <%
                out.print(year + "년 " +  month + "월 " + day +"일생");
                %>
            </td>
            <td>
                <!-- 연령 입력값 입력칸 -->
                <!-- 해당 계약자의 생년월일(=employeeDate)을 조회해서 가져와 평가점수 값에 반영할 것!  -->
                <%=tempEmployeeBean.get(0).getEmpDate() %>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2" style="background-color:#E2E2E2">
                <!-- korean -->
                한국어능력
            </td>
            <td>
               <!-- 한국어능력 평가점수 입력칸 -->
               <div id="koreanValueResult"></div>
               
            </td>
            <td>
               <!-- 한국어능력 심사내용 입력칸 -->
               <div id="koreanValueResultJudgement"></div>
               
            </td>
            <td>
                <!-- 한국어능력 입력값 입력칸 -->
                <%
                String koreanId = codeCtrl.selectIdByName("한국어능력");
                List<CodeItem> koreanBean = new ArrayList<CodeItem>();
                koreanBean = codeCtrl.selectAllByParentId(koreanId);
                
                if(tempJudgementBean.size() == 0)     {%>
	                <select style="width:200px;" id="koreanValue" name="koreanValue" onChange='checkSelectValue("koreanValue","koreanValueResult","koreanValueResultJudgement")'>
	                    <%for(int i = 0; i < koreanBean.size(); i++) {
	                    	String tempString = Integer.toString(koreanBean.get(i).getCodeValue()) + "," + koreanBean.get(i).getCodeJudgement() + "," + i;
	                    	
	                        if(i == 0) {%>
	                           <option value="<%=tempString%>" selected><%=koreanBean.get(i).getCodeName() %></option>
	                        <%} else {%>
	                           <option value="<%=tempString%>"><%=koreanBean.get(i).getCodeName() %></option>
	                        <%} %>
                        <%} %>
	                </select>
	            <%} else {
	                %>
	                <select style="width:200px;" id="koreanValue" name="koreanValue" onChange='checkSelectValue("koreanValue","koreanValueResult","koreanValueResultJudgement")'>
		                <%for(int i = 0; i < koreanBean.size(); i++)   {
		                	String tempString = Integer.toString(koreanBean.get(i).getCodeValue()) + "," + koreanBean.get(i).getCodeJudgement() + "," + i;
                            
		                    if(tempJudgementBean.get(0).getKorean().equals(Integer.toString(i)))  {%>
		                        <option value="<%=tempString %>" selected><%=koreanBean.get(i).getCodeName() %></option>
		                    <%} else {%>
		                        <option value="<%=tempString %>"><%=koreanBean.get(i).getCodeName() %></option>
		                    <%} %>
		                <%}%>
	                </select>
	            <%} %>
            </td>
        </tr>
        <tr align="center">
            <td rowspan="7" style="background-color:#E2E2E2">
                선택<br>항목
            </td>
            <td colspan="3" style="background-color:#E2E2E2">
                <!-- longevity -->
                근속기간
            </td>
            <td>
               <!-- 근속기간 평가점수 입력칸 -->
               <div id="longevityValueResult"></div>
            </td>
            <td>
               <!-- 근속기간 심사내용 입력칸 -->
               <!-- 평가점수가 0보다 크다면 "경력증명서 제출"이라고 출력 -->
               <div id="longevityValueResultJudgement"></div>
            </td>
            <td>
                <!-- 근속기간 입력값 입력칸 -->
                <!-- 직접 입력하여 그대로 평가점수에 반영 ex)근속기간 2 → 평가점수 2 -->
                <%
                String longevityId = codeCtrl.selectIdByName("근속기간");
                List<CodeItem> longevityList = new ArrayList<CodeItem>();
                longevityList = codeCtrl.selectAllByParentId(longevityId);
                
                ArrayList<String> longevityNameList = new ArrayList<String>();
                ArrayList<Integer> longevityValueList = new ArrayList<Integer>();
                ArrayList<String> longevityJudgementList = new ArrayList<String>();
                
                for(int i = 0; i < longevityList.size(); i++)   {
                	longevityNameList.add(longevityList.get(i).getCodeName());
                	longevityValueList.add(longevityList.get(i).getCodeValue());
                	longevityJudgementList.add(longevityList.get(i).getCodeJudgement());
                }
                
                String longevityNameString = longevityNameList.toString().substring(1,longevityNameList.toString().length()-1);
                String longevityValueString = longevityValueList.toString().substring(1,longevityValueList.toString().length()-1);
                String longevityJudgementString = longevityJudgementList.toString().substring(1,longevityJudgementList.toString().length()-1);
                
                %>
                <input style="width:200px;" type="text" name="longevityValue" id="longevityValue" onChange="checkInputValue('<%=longevityNameString %>', '<%=longevityValueString %>', '<%=longevityJudgementString %>', '<%=longevityList.size()%>', 
                'longevityValue', 'longevityValueResult', 'longevityValueResultJudgement')"/>
                
            </td>
        </tr>
        <tr align="center">
            <td rowspan="2" style="background-color:#E2E2E2">
                보유 자산
            </td>
            <td colspan="2" style="background-color:#E2E2E2">
                <!-- ip -->
                정기적금
            </td>
            <td>
               <!-- 정기적금 평가점수 입력칸 -->
               <!-- 정기적금 입력값이 100000000 이상이면 15점, 80000000 이상이면 12점, 60000000 이상이면 9점, 40000000 이상이면 7점, 20000000 이상이면 5점  -->
               <div id="ipValueResult"></div>
            </td>
            <td>
               <!-- 정기적금 심사내용 입력칸 -->
               <!-- 공백 -->
               <div id="ipValueResultJudgement"></div>
            </td>
            <td>
                <!-- 정기적금 입력값 입력칸 -->
                <!-- 직접 입력 -->
                <%
                String ipId = codeCtrl.selectIdByName("정기적금");
                List<CodeItem> ipList = new ArrayList<CodeItem>();
                ipList = codeCtrl.selectAllByParentId(ipId);
                
                ArrayList<String> ipNameList = new ArrayList<String>();
                ArrayList<Integer> ipValueList = new ArrayList<Integer>();
                ArrayList<String> ipJudgementList = new ArrayList<String>();
                
                for(int i = 0; i < ipList.size(); i++)  {
                	ipNameList.add(ipList.get(i).getCodeName());
                	ipValueList.add(ipList.get(i).getCodeValue());
                	ipJudgementList.add(ipList.get(i).getCodeJudgement());
                }
                
                String ipNameString = ipNameList.toString().substring(1,ipNameList.toString().length()-1);
                String ipValueString = ipValueList.toString().substring(1,ipValueList.toString().length()-1);
                String ipJudgementString = ipJudgementList.toString().substring(1,ipJudgementList.toString().length()-1);
                %>
                
                <input style="width:200px;" type="text" name="ipValue" id="ipValue" onkeyup="inputNumberFormat(this)" onChange="checkInputValue('<%=ipNameString%>', '<%=ipValueString%>', '<%=ipJudgementString%>', '<%=ipList.size()%>', 
                'ipValue', 'ipValueResult', 'ipValueResultJudgement')">
            </td>
        </tr>
        <tr align="center">
            <td colspan="2" style="background-color:#E2E2E2">
                <!-- da -->
                국내자산
            </td>
            <td>
               <!-- 국내자산 평가점수 입력칸 -->
               <!-- 국내자산 입력값이 100000000 이상이면 20점, 80000000 이상이면 15점, 50000000 이상이면 10점 -->
               <div id="daValueResult"></div>
            </td>
            <td>
               <!-- 국내자산 심사내용 입력칸 -->
               <!-- 공백 -->
               <div id="daValueResultJudgement"></div>
            </td>
            <td>
                <!-- 국내자산 입력값 입력칸 -->
                <!-- 직접 입력 -->
                <%
                String daId = codeCtrl.selectIdByName("국내자산");
                List<CodeItem> daList = new ArrayList<CodeItem>();
                daList = codeCtrl.selectAllByParentId(daId);
                
                ArrayList<String> daNameList = new ArrayList<String>();
                ArrayList<Integer> daValueList = new ArrayList<Integer>();
                ArrayList<String> daJudgementList = new ArrayList<String>();
                
                for(int i = 0; i < daList.size(); i++)  {
                	daNameList.add(daList.get(i).getCodeName());
                	daValueList.add(daList.get(i).getCodeValue());
                	daJudgementList.add(daList.get(i).getCodeJudgement());
                }
                
                String daNameString = daNameList.toString().substring(1,daNameList.toString().length()-1);
                String daValueString = daValueList.toString().substring(1,daValueList.toString().length()-1);
                String daJudgementString = daJudgementList.toString().substring(1,daJudgementList.toString().length()-1);
                
                System.out.println(daNameString + "\n" + daValueString + "\n" + daJudgementString);
                %>
                <input style="width:200px;" type="text" name="daValue" id="daValue" onkeyup="inputNumberFormat(this)" onChange="checkInputValue('<%=daNameString%>', '<%=daValueString%>', '<%=daJudgementString%>', '<%=daList.size()%>',
                 'daValue', 'daValueResult', 'daValueResultJudgement')"/>
            </td>
        </tr>
        <tr align="center">
            <td rowspan="2" style="background-color:#E2E2E2">
                근무 경력
            </td>
            <td colspan="2" style="background-color:#E2E2E2">
                <!-- root -->
                뿌리산업분야
            </td>
            <td>
               <!-- 뿌리산업분야 평가점수 입력칸 -->
               <!-- 뿌리산업분야 입력값이 8 이상이면 20점, 6 이상이면 15점, 4 이상이면 10점 -->
               <div id="rootValueResult"></div>
            </td>
            <td>
               <!-- 뿌리산업분야 심사내용 입력칸 -->
               <!-- 뿌리산업분야 평가점수가 0 보다 크다면 "경력증명서 제출" 출력 -->
               <div id="rootValueResultJudgement"></div>
            </td>
            <td>
                <!-- 뿌리산업분야 입력값 입력칸 -->
                <!-- 직접 입력 -->
                <%
                String rootId = codeCtrl.selectIdByName("뿌리산업분야");
                List<CodeItem> rootList = new ArrayList<CodeItem>();
                rootList = codeCtrl.selectAllByParentId(rootId);
                
                ArrayList<String> rootNameList = new ArrayList<String>();
                ArrayList<Integer> rootValueList = new ArrayList<Integer>();
                ArrayList<String> rootJudgementList = new ArrayList<String>();
                
                for(int i = 0; i < rootList.size(); i++)    {
                	rootNameList.add(rootList.get(i).getCodeName());
                	rootValueList.add(rootList.get(i).getCodeValue());
                	rootJudgementList.add(rootList.get(i).getCodeJudgement());
                }
                
                String rootNameString = rootNameList.toString().substring(1,rootNameList.toString().length()-1);
                String rootValueString = rootValueList.toString().substring(1,rootValueList.toString().length()-1);
                String rootJudgementString = rootJudgementList.toString().substring(1,rootJudgementList.toString().length()-1);
                %>
                <input style="width:200px;" type="text" name="rootValue" id="rootValue" onkeyup="inputNumberFormat(this)" onChange="checkInputValue('<%=rootNameString%>', '<%=rootValueString%>', '<%=rootJudgementString%>', '<%=rootList.size()%>',
                'rootValue', 'rootValueResult', 'rootValueResultJudgement')"/>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2" style="background-color:#E2E2E2">
                <!-- gm -->
                일반제조업 등
            </td>
            <td>
               <!-- 일반제조업 평가점수 입력칸 -->
               <!-- 일반제조업 입력값이 8 이상이면 20점, 6 이상이면 10점, 4 이상이면 5점 -->
               <div id="gmValueResult"></div>
            </td>
            <td>
               <!-- 일반제조업 심사내용 입력칸 -->
               <!-- 일반제조업 평가점수가 0보다 크다면 "경력증명서 제출" 출력 -->
               <div id="gmValueResultJudgement"></div>
            </td>
            <td>
                <!-- 일반제조업 입력값 입력칸 -->
                <!-- 직접 입력 -->
                <%
                String gmId = codeCtrl.selectIdByName("일반제조업");
                List<CodeItem> gmList = new ArrayList<CodeItem>();
                gmList = codeCtrl.selectAllByParentId(gmId);
                
                ArrayList<String> gmNameList = new ArrayList<String>();
                ArrayList<Integer> gmValueList = new ArrayList<Integer>();
                ArrayList<String> gmJudgementList = new ArrayList<String>();
                
                for(int i = 0; i < gmList.size(); i++)  {
                	gmNameList.add(gmList.get(i).getCodeName());
                	gmValueList.add(gmList.get(i).getCodeValue());
                	gmJudgementList.add(gmList.get(i).getCodeJudgement());
                }
                
                String gmNameString = gmNameList.toString().substring(1,gmNameList.toString().length()-1);
                String gmValueString = gmValueList.toString().substring(1,gmValueList.toString().length()-1);
                String gmJudgementString = gmJudgementList.toString().substring(1,gmJudgementList.toString().length()-1);
                %>
                
                <input style="width:200px;" type="text" name="gmValue" id="gmValue" onChange="checkInputValue('<%=gmNameString%>', '<%=gmValueString%>', '<%=gmJudgementString%>', '<%=gmList.size()%>',
                'gmValue', 'gmValueResult', 'gmValueResultJudgement')"/>
                
            </td>
        </tr>
        <tr align="center">
            <td rowspan="2" style="background-color:#E2E2E2">
                교육,<br>연수
            </td>
            <td colspan="2" style="background-color:#E2E2E2">
                <!-- ee -->
                교육경험
            </td>
            <td>
               <!-- 교육경험 평가점수 입력칸 -->
               <!-- 교육경험 입력값이 "학사이상"이면 10점, "전문학사"이면 8점 -->
               <div id="eeValueResult"></div>
               
            </td>
            <td>
               <!-- 교육경험 심사내용 입력칸 -->
               <!-- 교육경험 평가점수가 0보다 크면 "경력증명서 제출" 출력 -->
               <div id="eeValueResultJudgement"></div>
            </td>
            <td>
                <!-- 교육경험 입력값 입력칸 -->
                <%
                String eeId = codeCtrl.selectIdByName("교육경험");
                List<CodeItem> eeBean = new ArrayList<CodeItem>();
                eeBean = codeCtrl.selectAllByParentId(eeId);
                
                if(tempJudgementBean.size() == 0)   { %>
                	<select style="width:200px;" id="eeValue" name="eeValue" onChange='checkSelectValue("eeValue","eeValueResult","eeValueResultJudgement")'>
                	    <%for(int i = 0; i < eeBean.size(); i++)    {
                	    	String tempString = Integer.toString(eeBean.get(i).getCodeValue()) + "," + eeBean.get(i).getCodeJudgement() + "," + i;
                		    if(i == 0)    {%>
                		    	<option value="<%=tempString %>" selected><%=eeBean.get(i).getCodeName() %></option>
                		    <%} else {%>
                		        <option value="<%=tempString %>"><%=eeBean.get(i).getCodeName() %></option>
                		    <%} %>
                	    <%} %> 
                	</select>
                <%} else {%>
                    <select style="width:200px;" id="eeValue" name="eeValue" onChange='checkSelectValue("eeValue","eeValueResult","eeValueResultJudgement")'>
                        <%for(int i = 0; i < eeBean.size(); i++)    {
                            String tempString = Integer.toString(eeBean.get(i).getCodeValue()) + "," + eeBean.get(i).getCodeJudgement() + "," + i;%>
                            <%if(tempJudgementBean.get(0).getEe().equals(Integer.toString(i)))   {%>
                                <option value="<%=tempString %>" selected><%=eeBean.get(i).getCodeName() %></option>
                            <%} else {%>
                                <option value="<%=tempString %>"><%=eeBean.get(i).getCodeName() %></option>
                            <%} %>
                        <%} %>
                    
                    </select>
                <%} %>
                
            </td>
        </tr>
        <tr align="center">
            <td colspan="2" style="background-color:#E2E2E2">
                <!-- te -->
                연수경험
            </td>
            <td>
                <!-- 연수경험 평가점수 입력칸 -->
                <!-- 연수경험 입력값이 "1년이상"이면 5점, "6개월~1년미만"이면 3점 -->
                <div id="teValueResult"></div>
                
            </td>
            <td>
                <!-- 연수경험 심사내용 입력칸 -->
                <!-- 연수경험 평가점수가 0보다 크면 "경력증명서 제출" 출력 -->
                <div id="teValueResultJudgement"></div>
            </td>
            <td>
                <!-- 연수경험 입력값 입력칸 -->
                <%
                String teId = codeCtrl.selectIdByName("연수경험");
                List<CodeItem> teBean = new ArrayList<CodeItem>();
                teBean = codeCtrl.selectAllByParentId(teId);
                
                if(tempJudgementBean.size() == 0)   {%>
                    <select style="width:200px" name="teValue" id="teValue" onChange="checkSelectValue('teValue','teValueResult','teValueResultJudgement')">
                        <%for(int i = 0; i < teBean.size(); i++)    {
                            String tempString = Integer.toString(teBean.get(i).getCodeValue()) + "," + teBean.get(i).getCodeJudgement() + "," + i;%>
                            <%if(i == 0)    {%>
                                <option value="<%=tempString %>" selected><%=teBean.get(i).getCodeName() %></option>
                            <%} else {%>
                                <option value="<%=tempString %>"><%=teBean.get(i).getCodeName() %></option>
                            <%} %>
                        <%} %>
                    </select>                
                <%} else {%>
                    <select style="width:200px;" name="teValue" id="teValue" onChange="checkSelectValue'teValue','teValueResult','teValueResultJudgement')">
                        <%for(int i = 0; i < teBean.size(); i++)    {
                            String tempString = Integer.toString(teBean.get(i).getCodeValue()) + "," + teBean.get(i).getCodeJudgement() + "," + i;%>
                            <%if(tempJudgementBean.get(0).getTe().equals(Integer.toString(i)))  { %>
                                <option value="<%=tempString %>" selected><%=teBean.get(i).getCodeName() %></option>
                            <%} else { %>
                                <option value="<%=tempString %>"><%=teBean.get(i).getCodeName() %></option>
                            <%} %>
                        <%} %>
                    </select>
                <%} %>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2" rowspan="7" style="background-color:#E2E2E2">
                가점
            </td>
            <td colspan="2" style="background-color:#E2E2E2">
                <!-- sa -->
                국내유학경험
            </td>
            <td>
               <!-- 국내유학경험 평가점수 입력칸 -->
               <!-- 국내유학경험 입력값이 "석사이상" 10점, "학사이하" 5점, "전문학사" 3점 -->
               <div id="saValueResult"></div>
               
            </td>
            <td>
               <!-- 국내유학경험 심사내용 입력칸 -->
               <!-- 국내유학경험 평가점수가 0보다 크면 "재학증명서 제출" 출력 -->
               <div id="saValueResultJudgement"></div>
            </td>
            <td>
                <!-- 국내유학경험 입력값 입력칸 -->
                <%
                String saId = codeCtrl.selectIdByName("국내유학경험");
                List<CodeItem> saBean = new ArrayList<CodeItem>();
                saBean = codeCtrl.selectAllByParentId(saId);
                
                if(tempJudgementBean.size() == 0)   {%>
                    <select style="width:200px" name="saValue" id="saValue" onChange="checkSelectValue('saValue','saValueResult','saValueResultJudgement')">
                        <%for(int i = 0; i < saBean.size(); i++)    {
                            String tempString = Integer.toString(saBean.get(i).getCodeValue()) + "," + saBean.get(i).getCodeJudgement() + "," + i;%>
                            
                            <%if(i == 0)    {%>
                                <option value="<%=tempString %>" selected><%=saBean.get(i).getCodeName() %></option>
                            <%} else {%>
                                <option value="<%=tempString %>"><%=saBean.get(i).getCodeName() %></option>
                            <%} %>
                        <%} %>
                    </select>                
                <%} else {%>
                    <select style="width:200px;" name="saValue" id="saValue" onChange="checkSelectValue('saValue','saValueResult','saValueResultJudgement')">
                        <%for(int i = 0; i < saBean.size(); i++)    {
                            String tempString = Integer.toString(saBean.get(i).getCodeValue()) + "," + saBean.get(i).getCodeJudgement() + "," + i;%>
                            
                            <%if(tempJudgementBean.get(0).getTe().equals(Integer.toString(i)))  { %>
                                <option value="<%=tempString %>" selected><%=saBean.get(i).getCodeName() %></option>
                            <%} else { %>
                                <option value="<%=tempString %>"><%=saBean.get(i).getCodeName() %></option>
                            <%} %>
                        <%} %>
                    </select>
                <%} %>
                
            </td>
        </tr>
        <tr align="center">
            <td colspan="2" style="background-color:#E2E2E2">
                <!-- cr -->
                부처 추천
            </td>
            <td>
               <!-- 부처추천 평가점수 입력칸 -->
               <!-- 부처추천 입력값이 "있다" 10점, "없다" 0점 -->
               <div id="crValueResult"></div>
            </td>
            <td>
               <!-- 부처추천 심사내용 입력칸 -->
               <!-- 부처추천 평가점수가 0보다 크면 "추천서 제출" 출력 -->
               <div id="crValueResultJudgement"></div>
            </td>
            <td>
                <!-- 부처추천 입력값 입력칸 -->
                <%
                String crId = codeCtrl.selectIdByName("부처추천");
                List<CodeItem> crBean = new ArrayList<CodeItem>();
                crBean = codeCtrl.selectAllByParentId(crId);
                
                if(tempJudgementBean.size() == 0)   {%>
                    <select style="width:200px" name="crValue" id="crValue" value="0" onChange="checkSelectValue('crValue', 'crValueResult', 'crValueResultJudgement')">
                        <%for(int i = 0; i < crBean.size(); i++)    {
                            String tempString = Integer.toString(crBean.get(i).getCodeValue()) + "," + crBean.get(i).getCodeJudgement() + "," + i;%>
                            
                            <%if(i == 0)    {%>
                                <option value="<%=tempString %>" selected><%=crBean.get(i).getCodeName() %></option>
                            <%} else {%>
                                <option value="<%=tempString %>"><%=crBean.get(i).getCodeName() %></option>
                            <%} %>
                        <%} %>
                    </select>                
                <%} else {%>
                    <select style="width:200px;" name="crValue" id="crValue" onChange="checkSelectValue('crValue', 'crValueResult', 'crValueResultJudgement')">
                        <%for(int i = 0; i < crBean.size(); i++)    {
                            String tempString = Integer.toString(crBean.get(i).getCodeValue()) + "," + crBean.get(i).getCodeJudgement() + "," + i;%>
                            
                            <%if(tempJudgementBean.get(0).getCr().equals(Integer.toString(i)))  { %>
                                <option value="<%=tempString %>" selected><%=crBean.get(i).getCodeName() %></option>
                            <%} else { %>
                                <option value="<%=tempString %>"><%=crBean.get(i).getCodeName() %></option>
                            <%} %>
                        <%} %>
                    </select>
                <%} %>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2" style="background-color:#E2E2E2">
                <!-- lc -->
                읍면지역 근무
            </td>
            <td>
               <!-- 읍면지역근무 평가점수 입력칸 -->
               <!-- 읍면지역 입력값이 4 이상이면 10점, 3점 이상이면 7점, 2점 이상이면 5점 -->
               <div id="lcValueResult"></div>
            </td>
            <td>
               <!-- 읍면지역근무 심사내용 입력칸 -->
               <!-- 읍면지역근무 평가점수가 0보다 크면 "경력증명서 제출" 출력 -->
               <div id="lcValueResultJudgement"></div>
            </td>
            <td>
                <!-- 읍면지역근무 입력값 입력칸 -->
                <%
                String lcId = codeCtrl.selectIdByName("읍면지역근무");
                List<CodeItem> lcList = new ArrayList<CodeItem>();
                lcList = codeCtrl.selectAllByParentId(lcId);
                
                ArrayList<String> lcNameList = new ArrayList<String>();
                ArrayList<Integer> lcValueList = new ArrayList<Integer>();
                ArrayList<String> lcJudgementList = new ArrayList<String>();
                
                for(int i = 0; i < lcList.size(); i++)  {
                	lcNameList.add(lcList.get(i).getCodeName());
                	lcValueList.add(lcList.get(i).getCodeValue());
                	lcJudgementList.add(lcList.get(i).getCodeJudgement());
                }
                
                String lcNameString = lcNameList.toString().substring(1,lcNameList.toString().length()-1);
                String lcValueString = lcValueList.toString().substring(1,lcValueList.toString().length()-1);
                String lcJudgementString = lcJudgementList.toString().substring(1,lcJudgementList.toString().length()-1);
                %>
                <input type="text" name="lcValue" id="lcValue" style="width:200px;" onChange="checkInputValue('<%=lcNameString%>', '<%=lcValueString%>', '<%=lcJudgementString%>', 
                '<%=lcList.size()%>', 'lcValue', 'lcValueResult', 'lcValueResultJudgement')"/>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2" style="background-color:#E2E2E2">
                <!-- sc -->
                사회공헌
            </td>
            <td>
               <!-- 사회공헌 평가점수 입력칸 -->
               <!-- 사회공헌 입력값이 "표창"이면 5점, "사회봉사" 3점 -->
               <div id="scValueResult"></div>
            </td>
            <td>
               <!-- 사회공헌 심사내용 입력칸 -->
               <!-- 사회공헌 평가점수가 5 일 경우 "표창장사본제출" 출력, 3 일 경우 "봉사실적제출" 출력  -->
               <div id="scValueResultJudgement"></div>
            </td>
            <td>
                <!-- 사회공헌 입력값 입력칸 -->
                <%
                String scId = codeCtrl.selectIdByName("사회공헌");
                List<CodeItem> scBean = new ArrayList<CodeItem>();
                scBean = codeCtrl.selectAllByParentId(scId);
                
                
                if(tempJudgementBean.size() == 0)   {%>
                    <select style="width:200px" name="scValue" id="scValue" onChange="checkSelectValue('scValue','scValueResult','scValueResultJudgement')">
                        <%for(int i = 0; i < scBean.size(); i++)    {
                            String tempString = Integer.toString(scBean.get(i).getCodeValue()) + "," + scBean.get(i).getCodeJudgement() + "," + i;%>
                            
                            <%if(i == 0)    {%>
                                <option value="<%=tempString %>" selected><%=scBean.get(i).getCodeName() %></option>
                            <%} else {%>
                                <option value="<%=tempString %>"><%=scBean.get(i).getCodeName() %></option>
                            <%} %>
                        <%} %>
                    </select>                
                <%} else {%>
                    <select style="width:200px;" name="scValue" id="scValue" onChange="checkSelectValue('scValue','scValueResult','scValueResultJudgement')">
                        <%for(int i = 0; i < scBean.size(); i++)    {
                            String tempString = Integer.toString(scBean.get(i).getCodeValue()) + "," + scBean.get(i).getCodeJudgement() + "," + i;%>
                            
                            <%if(tempJudgementBean.get(0).getTe().equals(Integer.toString(i)))  { %>
                                <option value="<%=tempString %>" selected><%=scBean.get(i).getCodeName() %></option>
                            <%} else { %>
                                <option value="<%=tempString %>"><%=scBean.get(i).getCodeName() %></option>
                            <%} %>
                        <%} %>
                    </select>
                <%} %>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2" style="background-color:#E2E2E2">
                <!-- tpp -->
                납세실적
            </td>
            <td>
               <!-- 납세실적 평가점수 입력칸 -->
               <!-- 납세실적 입력값이 3000000 이상이면 5점 -->
               <div id="tppValueResult"></div>
            </td>
            <td>
               <!-- 납세실적 심사내용 입력칸 -->
               <!-- 내용없음 -->
               <div id="tppValueResultJudgement"></div>
            </td>
            <td>
                <!-- 납세실적 입력값 입력칸 -->
                <!-- 직접 입력 -->
                <%
                String tppId = codeCtrl.selectIdByName("납세실적");
                List<CodeItem> tppList = new ArrayList<CodeItem>();
                tppList = codeCtrl.selectAllByParentId(tppId);
                
                ArrayList<String> tppNameList = new ArrayList<String>();
                ArrayList<Integer> tppValueList = new ArrayList<Integer>();
                ArrayList<String> tppJudgementList = new ArrayList<String>();
                
                for(int i = 0; i < tppList.size(); i++) {
                	tppNameList.add(tppList.get(i).getCodeName());
                	tppValueList.add(tppList.get(i).getCodeValue());
                	tppJudgementList.add(tppList.get(i).getCodeJudgement());
                }
                
                String tppNameString = tppNameList.toString().substring(1,tppNameList.toString().length()-1);
                String tppValueString = tppValueList.toString().substring(1,tppValueList.toString().length()-1);
                String tppJudgementString = tppJudgementList.toString().substring(1,tppJudgementList.toString().length()-1);
                %>
                
                <input style="width:200px;" type="text" name="tppValue" onkeyup="inputNumberFormat(this)" id="tppValue" onChange="checkInputValue('<%=tppNameString%>', '<%=tppValueString%>', '<%=tppJudgementString%>', '<%=tppList.size()%>', 
                'tppValue', 'tppValueResult', 'tppValueResultJudgement')"/>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2" style="background-color:#E2E2E2">
                <!-- sip -->
                <font color="blue">사회통합프로그램 이수</font>
            </td>
            <td>
                <!-- 사회통합프로그램 평가점수 입력칸 -->
                <!-- 만약 한국어 능력 입력값이 사회통합프로그램(5급/5단계이상) 일 경우 5점 -->
                <!-- koreanValue 선택 값이 "사회통합프로그램(5급/5단계이상)" 과 같다면 5점 -->
                <div id="sipValueResult"></div>
            </td>
            <td>
                <!-- 사회통합프로그램 심사내용 입력칸 -->
                <!-- 공백 -->
            </td>
            <td>
                <!-- 사회통합프로그램 입력값 입력칸 -->
                <!-- 공백 -->
                X
            </td>
        </tr>
        <tr align="center">
            <td colspan="2" style="background-color:#E2E2E2">
                <!-- depopulatedArea -->
                <font color="blue">인구감소지역 근무</font>
            </td>
            <td>
               <!-- 인구감소지역 근무 평가점수 입력칸 -->
               <!-- 인구감소지역 입력값이 4 이상이면 5점, 3 이상이면 3점, 2 이상이면 2점 -->
               <div id="depopulatedAreaValueResult"></div>
            </td>
            <td>
               <!-- 인구감소지역 근무 심사내용 입력칸 -->
               <!-- 공백 -->
               <div id="depopulatedAreaValueResultJudgement"></div>
            </td>
            <td>
                <!-- 인구감소지역 근무 입력값 입력칸 -->
                <!-- 직접 입력 -->
                <%
                String depopulatedAreaId = codeCtrl.selectIdByName("인구감소지역");
                List<CodeItem> depopulatedAreaList = new ArrayList<CodeItem>();
                depopulatedAreaList = codeCtrl.selectAllByParentId(depopulatedAreaId);
                
                ArrayList<String> depopulatedAreaNameList = new ArrayList<String>();
                ArrayList<Integer> depopulatedAreaValueList = new ArrayList<Integer>();
                ArrayList<String> depopulatedAreaJudgementList = new ArrayList<String>();
                
                for(int i = 0; i < depopulatedAreaList.size(); i++) {
                	depopulatedAreaNameList.add(depopulatedAreaList.get(i).getCodeName());
                	depopulatedAreaValueList.add(depopulatedAreaList.get(i).getCodeValue());
                	depopulatedAreaJudgementList.add(depopulatedAreaList.get(i).getCodeJudgement());
                }
                
                String depopulatedAreaNameString = depopulatedAreaNameList.toString().substring(1,depopulatedAreaNameList.toString().length()-1);
                String depopulatedAreaValueString = depopulatedAreaValueList.toString().substring(1,depopulatedAreaValueList.toString().length()-1);
                String depopulatedAreaJudgementString = depopulatedAreaJudgementList.toString().substring(1,depopulatedAreaJudgementList.toString().length()-1);
                %>
                <input type="text" name="depopulatedAreaValue" id="depopulatedAreaValue" style="width:200px;" onChange="checkInputValue('<%=depopulatedAreaNameString%>', '<%=depopulatedAreaValueString%>', '<%=depopulatedAreaJudgementString%>', '<%=depopulatedAreaList.size()%>', 
                'depopulatedAreaValue', 'depopulatedAreaValueResult', 'depopulatedAreaValueResultJudgement')"/>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2" rowspan="2" style="background-color:#E2E2E2">
                감점
            </td>
            <td colspan="2" style="background-color:#E2E2E2">
                <!-- immigration -->
                출입국관리법 위반
            </td>
            <td>
               <!-- 출입국관리법 위반 평가점수 입력칸 -->
               <!-- 출입국관리법 입력값이 "3회이상" 일 경우 -50점, "2회" 일 경우 -10점, "1회" 일 경우 -5점 -->
               <div id="immigrationResult"></div>
            </td>
            <td>
               <!-- 출입국관리법 위반 심사내용 입력칸 -->
               <!-- 공백 -->
               <div id="immigrationResultJudgement"></div>
            </td>
            <td>
                <!-- 출입국관리법 위반 입력값 입력칸 -->
                <%
                String immigrationId = codeCtrl.selectIdByName("출입국관리법위반");
                List<CodeItem> immigrationBean = new ArrayList<CodeItem>();
                immigrationBean = codeCtrl.selectAllByParentId(immigrationId);
                
                String[] tempImmigration = {"없음", "1회", "2회", "3회이상"};
                if(tempJudgementBean.size() == 0)   {%>
                    <select style="width:200px" name="immigrationValue" id="immigrationValue" onChange="checkSelectValue('immigrationValue','immigrationResult','immigrationResultJudgement')">
                        <%for(int i = 0; i < immigrationBean.size(); i++)    {
                            String tempString = Integer.toString(immigrationBean.get(i).getCodeValue()) + "," + immigrationBean.get(i).getCodeJudgement() + "," + i;%>
                            
                            <%if(i == 0)    {%>
                                <option value="<%=tempString %>" selected><%=immigrationBean.get(i).getCodeName() %></option>
                            <%} else {%>
                                <option value="<%=tempString %>"><%=immigrationBean.get(i).getCodeName() %></option>
                            <%} %>
                        <%} %>
                    </select>                
                <%} else {%>
                    <select style="width:200px;" name="immigrationValue" id="immigrationValue" onChange="checkSelectValue('immigrationValue','immigrationResult','immigrationResultJudgement')">
                        <%for(int i = 0; i < immigrationBean.size(); i++)    {
                            String tempString = Integer.toString(immigrationBean.get(i).getCodeValue()) + "," + immigrationBean.get(i).getCodeJudgement() + "," + i;%>
                            
                            <%if(tempJudgementBean.get(0).getTe().equals(Integer.toString(i)))  { %>
                                <option value="<%=tempString %>" selected><%=immigrationBean.get(i).getCodeName() %></option>
                            <%} else { %>
                                <option value="<%=tempString %>"><%=immigrationBean.get(i).getCodeName() %></option>
                            <%} %>
                        <%} %>
                    </select>
                <%} %>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2" style="background-color:#E2E2E2">
                <!-- violation -->
                기타 국내법 위반
            </td>
            <td>
               <!-- 기타 국내법 위반 평가점수 입력칸 -->
               <div id="violationValueReulst"></div>
            </td>
            <td>
               <!-- 기타 국내법 위반 심사내용 입력칸 -->
               <div id="violationValueResultJudgement"></div>
            </td>
            <td>
                <!-- 기타 국내법 위반 입력값 입력칸 -->
                <%
                String violationId = codeCtrl.selectIdByName("기타국내법위반");
                List<CodeItem> violationBean = new ArrayList<CodeItem>();
                violationBean = codeCtrl.selectAllByParentId(violationId);
                
                if(tempJudgementBean.size() == 0)   {%>
                    <select style="width:200px" name="violationValue" id="violationValue" onChange="checkSelectValue('violationValue','violationValueReulst','violationValueResultJudgement')">
                        <%for(int i = 0; i < violationBean.size(); i++)    {
                            String tempString = Integer.toString(violationBean.get(i).getCodeValue()) + "," + violationBean.get(i).getCodeJudgement() + "," + i;%>
                            
                            <%if(i == 0)    {%>
                                <option value="<%=tempString %>" selected><%=violationBean.get(i).getCodeName() %></option>
                            <%} else {%>
                                <option value="<%=tempString %>"><%=violationBean.get(i).getCodeName() %></option>
                            <%} %>
                        <%} %>
                    </select>                
                <%} else {%>
                    <select style="width:200px;" name="violationValue" id="violationValue" onChange="checkSelectValue('violationValue','violationValueReulst','violationValueResultJudgement')">
                        <%for(int i = 0; i < violationBean.size(); i++)    {
                            String tempString = Integer.toString(violationBean.get(i).getCodeValue()) + "," + violationBean.get(i).getCodeJudgement() + "," + i;%>
                            
                            <%if(tempJudgementBean.get(0).getTe().equals(Integer.toString(i)))  { %>
                                <option value="<%=tempString %>" selected><%=violationBean.get(i).getCodeName() %></option>
                            <%} else { %>
                                <option value="<%=tempString %>"><%=violationBean.get(i).getCodeName() %></option>
                            <%} %>
                        <%} %>
                    </select>
                <%} %>
            </td>
        </tr> 
        <tr align="center">
            <td colspan="4" width="600" style="background-color:#E2E2E2">
                총   점
            </td>
            <td width="100" style="background-color:yellow">
                <!-- 총점 -->
                <div id='totalValue'></div>
            </td>
            <td colspan="2" width="500">
               <!-- 합격여부 -->
               
            </td>
        </tr>
    </table>
<%} %>
<br>
<table border="1" height="50" width="1000" align="center">
    <tr>
        <td width="100" style="background-color:#E2E2E2" align="center">
            작성일
        </td>
        <td width="400">
            
        </td>
        <td width="100" style="background-color:#E2E2E2" align="center">
            작성자
        </td>
        <td width="400" align="right">
        (인)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </td>
    </tr>
</table>
<br>
<input type="button" onClick="location.href='../employee/signup.jsp'" value="뒤로가기">
<input type="submit" value="전달">

</body>
</form>

</html>