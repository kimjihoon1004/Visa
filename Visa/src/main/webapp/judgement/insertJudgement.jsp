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
<title>Insert judgement</title>
</head>
<body>
<%
String id = request.getParameter("id");
String name = request.getParameter("name");
String applicationType = request.getParameter("applicationType"); //신청유형
String basicRequirement = request.getParameter("basicRequirement"); //기본요건
String scoreRequirement = request.getParameter("scoreRequirement"); //점수요건
String annualIncome = request.getParameter("annualIncomeValue"); //연간소득
String license = request.getParameter("licenseValue").split(",")[2]; //자격증
String workmanship = request.getParameter("workmanshipValue").split(",")[2]; //기량검증
String education = request.getParameter("educationValue").split(",")[2]; //학력
String korean = request.getParameter("koreanValue").split(",")[2]; //한국어능력
String longevity = request.getParameter("longevityValue"); //근속기간
String ip = request.getParameter("ipValue"); //정기적금
String da = request.getParameter("daValue"); //국내자산
String root = request.getParameter("rootValue"); //뿌리산업분야
String gm = request.getParameter("gmValue"); //일반제조업
String ee = request.getParameter("eeValue").split(",")[2]; //교육경험
String te = request.getParameter("teValue").split(",")[2]; //연수경험
String sa = request.getParameter("saValue").split(",")[2]; //국내 유학 경험
String cr = request.getParameter("crValue").split(",")[2]; //부처 추천
String lc = request.getParameter("lcValue"); //지역근무
String sc = request.getParameter("scValue").split(",")[2]; //사회공헌
String tpp = request.getParameter("tppValue"); //납세실적
String depopulatedArea = request.getParameter("depopulatedAreaValue"); //인구감소지역
String immigration = request.getParameter("immigrationValue").split(",")[2]; //출입국 관리법 위반
String violation = request.getParameter("violationValue").split(",")[2]; //국내법 위반
%>
<h1>id : <%=id %></h1>
<h1>이름 : <%=name %></h1>
<h1>신청유형 : <%=applicationType %></h1>
<h1>기본요건 : <%=basicRequirement %></h1>
<h1>점수요건 : <%=scoreRequirement %></h1>
<h1>연간소득 : <%=annualIncome %></h1>
<h1>자격증 : <%=license %></h1>
<h1>기량검증 : <%=workmanship %></h1>
<h1>학력 : <%=education %></h1>
<h1>한국어 능력 : <%=korean %></h1>
<h1>근속기간 : <%=longevity %></h1>
<h1>정기적금 : <%=ip %></h1>
<h1>국내자산 : <%=da %></h1>
<h1>뿌리산업분야 : <%=root %></h1>
<h1>일반제조업 : <%=gm %></h1>
<h1>교육경험 : <%=ee %></h1>
<h1>연수경험 : <%=te %></h1>
<h1>국내 유학 경험 : <%=sa %></h1>
<h1>부처 추천 : <%=cr %></h1>
<h1>지역 근무 : <%=lc %></h1>
<h1>사회 공헌 : <%=sc %></h1>
<h1>납세 실적 : <%=tpp %></h1>
<h1>인구 감소 지역 : <%=depopulatedArea %></h1>
<h1>출입국관리법 위반 : <%=immigration %></h1>
<h1>국내법 위반 : <%=violation %></h1>
</body>
</html>