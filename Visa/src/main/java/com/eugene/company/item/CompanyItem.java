package com.eugene.company.item;

public class CompanyItem {
	private String companyName;
	private String companyCeo;
	private String companyCeoPhone;
	private String companyPhone;
	private String companyMemo;
	/*user의 아이디*/
	private int id;
	private int companyId;
	
	public int getCompanyId() {
		return companyId;
	}
	public void setCompanyId(int companyId) {
		this.companyId = companyId;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getCompanyCeo() {
		return companyCeo;
	}
	public void setCompanyCeo(String companyCeo) {
		this.companyCeo = companyCeo;
	}
	public String getCompanyCeoPhone() {
		return companyCeoPhone;
	}
	public void setCompanyCeoPhone(String companyCeoPhone) {
		this.companyCeoPhone = companyCeoPhone;
	}
	public String getCompanyPhone() {
		return companyPhone;
	}
	public void setCompanyPhone(String companyPhone) {
		this.companyPhone = companyPhone;
	}
	public String getCompanyMemo() {
		return companyMemo;
	}
	public void setCompanyMemo(String companyMemo) {
		this.companyMemo = companyMemo;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
}
