<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/sessionCheck.inc" %>
<%@ include file="../include/top.inc" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.eugene.company.ctrl.CompanyCtrl" %>
<%@ page import = "com.eugene.company.item.CompanyItem" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 추가</title>
</head>
<body>
    <%
    CompanyCtrl companyCtrl = new CompanyCtrl();
    CompanyItem companyItem = new CompanyItem();
    
    List<CompanyItem> companyBean = new ArrayList();
    companyBean = companyCtrl.checkAllCompany();
    %>
    <!-- 금액 입력시 3번째자리마다 쉼표 입력 -->
    <script>
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
	
	<!-- 회사를 선택하지 않으면 알림이 뜨며 submit하지 않는다. -->
	<script>
	function validateForm() {
        var selectElement = document.getElementById("companyId");
        var selectedValue = selectElement.value;

        if (selectedValue == "0" || selectedValue == "") {
            alert("회사를 선택하세요.");
            return false; 
        }

    }
	</script>
	
    <br><br><br>
    <center>
    
    <form action="employeeAppendCheck.jsp" onsubmit="return validateForm()">
    <div style="display: flex; justify-content: center;">
	    <table border="1" width="700" style="margin-right: 30px;">
	        <tr align="center">
	            <td colspan="2">
	                <br><font size="5">계약자 추가</font><br><br>
	            </td>
	        </tr>
	        
	        <tr align="center">
	            <td>
	                <br>
	                <font size="4">이름</font>
	                <br><br>
	            </td>   
	            <td>
	                <br>
	                <input type="text" name="empName" size="30" required/>
	                <br><br>
	            </td>
	        </tr>
	        
	        <tr align="center">
	            <td>
	                <br>
	                <font size="4">국적</font>
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
	                <font size="4">전화번호</font>
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
	                <font size="4">등록번호</font>
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
	                <font size="4">비자타입</font>
	                <br><br>
	            </td>   
	            <td>
	                <br>
	                <input type="text" name="empVisa" size="30" required/>
	                <br><br>
	            </td>
	        </tr>
	        
	        <tr align="center">
	            <td>
	                <br>
	                <font size="4">체류만료일</font>
	                <br><br>
	            </td>   
	            <td>
	                <br>
	                <input type="date" name="empDate"required/>
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
    
        <!-- 회사계약 표 -->
	    <table border="1" width="700">
	    <tr align="center">
            <td colspan="2">
                <br><font size="5">회사 계약</font><br><br>
            </td>
        </tr>
        
	    <tr align="center">
            <td width="200">
                <br>
                <font size="4">담당 회사</font>
                <br><br>
            </td>   
            <td>
                <br>
                <!-- 회사id가 employee테이블의 companyId로도 쓰이며, contract의 companyId로도 쓰인다. -->
                <select name = "companyId" id="companyId" >
                    <option value="0">회사 선택</option>
                    <%for(int i = 0; i < companyBean.size(); i++)   {%>
                        <option value="<%=companyBean.get(i).getCompanyId() %>"><%=companyBean.get(i).getCompanyName() %></option> 
                    <%} %>
                </select>
                <br><br>
            </td>
        </tr>
        
        <tr align="center">
            <td>
                <br>
                <font size="4">계약일</font>
                <br><br>
            </td>   
            <td>
                <br>
                <input type="date" name="contractDate"required/>
                <br><br>
            </td>
        </tr> 
        
        <tr align="center">
            <td>
                <br>
                <font size="4">총수임금액</font>
                <br><br>
            </td>   
            <td>
                <br>
                <input type="text" name="contractRevenue" onkeyup="inputNumberFormat(this)" required/>
                <br><br>
            </td>
        </tr> 
        
        <tr align="center">
            <td>
                <br>
                <font size="4">계약금</font>
                <br><br>
            </td>   
            <td>
                <br>
                <input type="text" name="contractPayment" onkeyup="inputNumberFormat(this)" required/>
                <br><br>
            </td>
        </tr> 
         
        <tr align="center">
            <td>
                <br>
                <font size="4">입금일</font>
                <br><br>
            </td>   
            <td>
                <br>
                <input type="date" name="contractDepositeDate" />
                <br><br>
            </td>
        </tr> 
        
        <tr align="center">
            <td>
                <br>
                <font size="4">실비</font>
                <br><br>
            </td>   
            <td>
                <br>
                <input type="text" name="contractInsurance" onkeyup="inputNumberFormat(this)" required/>
                <br><br>
            </td>
        </tr> 
        
        <tr align="center">
            <td>
                <br>
                <font size="4">잔금</font>
                <br><br>
            </td>   
            <td>
                <br>
                <input type="text" name="contractBalance" onkeyup="inputNumberFormat(this)" />
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
                <Textarea name="contractMemo" rows="5" cols="30" style="font-size:20px";></Textarea>
                <br><br>                
            </td>
        </tr>
	    </table>
    </div>
    <br>
    <input type="submit" style="padding : 10px 10px 10px 10px;" value="계약자 추가"/>
    <button style="padding : 10px 10px 10px 10px;" onclick="location.href='signup.jsp'">취소</button>
    </center>
    </form>
</body>
</html>