package com.eugene.judgement.item;

public class JudgementItem {
	private int judgementId;	//judgement_id 
	private String annualIncome; //annualIncome, 연간소득
	private String license; //license, 자격증소지
	private String workmanship; //workmanship, 기량검증
	private String education; //education, 학력
	private String age; //age, 연령
	private String korean; //korean, 한국어능력
	private String longevity; //longevity, 근속기간
	private String ip; //IP, 정기적금
	private String da; //DA, 국내자산
	private String root; //root, 뿌리산업분야
	private String gm; //GM, 일반제조업
	private String ee; //EE, 교육경험
	private String te; //TE, 연수경험
	private String sa; //SA, 국내 유학 경험
	private String cr; //CR, 부처 추천
	private String lc; //LC, 지역 근무
	private String sc; //SC, 사회 공헌
	private String tpp; //TPP, 납세 실적
	private String sip; //SIP, 사회 통합 프로그램
	private String depopulatedArea; //depopulatedArea, 인구 감소 지역
	private String immigration; //immigration, 출입국관리법 위반
	private String violation; //violation, 국내법 위반
	private int employeeId;	//employee_id
	private String judgementDate; //judgementDate
	private String scoreRequirement; //기본 요건
	private String basicRequirement; //점수 요건
	
	public String getScoreRequirement() {
		return scoreRequirement;
	}
	public void setScoreRequirement(String scoreRequirement) {
		this.scoreRequirement = scoreRequirement;
	}
	public String getBasicRequirement() {
		return basicRequirement;
	}
	public void setBasicRequirement(String basicRequirement) {
		this.basicRequirement = basicRequirement;
	}
	public String getApplicationType() {
		return applicationType;
	}
	public void setApplicationType(String applicationType) {
		this.applicationType = applicationType;
	}
	private String applicationType; //신청 유형
	
	public int getJudgementId() {
		return judgementId;
	}
	public void setJudgementId(int judgementId) {
		this.judgementId = judgementId;
	}
	public String getAnnualIncome() {
		return annualIncome;
	}
	public void setAnnualIncome(String annualIncome) {
		this.annualIncome = annualIncome;
	}
	public String getLicense() {
		return license;
	}
	public void setLicense(String license) {
		this.license = license;
	}
	public String getWorkmanship() {
		return workmanship;
	}
	public void setWorkmanship(String workmanship) {
		this.workmanship = workmanship;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getKorean() {
		return korean;
	}
	public void setKorean(String korean) {
		this.korean = korean;
	}
	public String getLongevity() {
		return longevity;
	}
	public void setLongevity(String longevity) {
		this.longevity = longevity;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getDa() {
		return da;
	}
	public void setDa(String da) {
		this.da = da;
	}
	public String getRoot() {
		return root;
	}
	public void setRoot(String root) {
		this.root = root;
	}
	public String getGm() {
		return gm;
	}
	public void setGm(String gm) {
		this.gm = gm;
	}
	public String getEe() {
		return ee;
	}
	public void setEe(String ee) {
		this.ee = ee;
	}
	public String getTe() {
		return te;
	}
	public void setTe(String te) {
		this.te = te;
	}
	public String getSa() {
		return sa;
	}
	public void setSa(String sa) {
		this.sa = sa;
	}
	public String getCr() {
		return cr;
	}
	public void setCr(String cr) {
		this.cr = cr;
	}
	public String getLc() {
		return lc;
	}
	public void setLc(String lc) {
		this.lc = lc;
	}
	public String getSc() {
		return sc;
	}
	public void setSc(String sc) {
		this.sc = sc;
	}
	public String getTpp() {
		return tpp;
	}
	public void setTpp(String tpp) {
		this.tpp = tpp;
	}
	public String getSip() {
		return sip;
	}
	public void setSip(String sip) {
		this.sip = sip;
	}
	public String getDepopulatedArea() {
		return depopulatedArea;
	}
	public void setDepopulatedArea(String depopulatedArea) {
		this.depopulatedArea = depopulatedArea;
	}
	public String getImmigration() {
		return immigration;
	}
	public void setImmigration(String immigration) {
		this.immigration = immigration;
	}
	public String getViolation() {
		return violation;
	}
	public void setViolation(String violation) {
		this.violation = violation;
	}
	public int getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}
	public String getJudgementDate() {
		return judgementDate;
	}
	public void setJudgementDate(String judgementDate) {
		this.judgementDate = judgementDate;
	}
}
