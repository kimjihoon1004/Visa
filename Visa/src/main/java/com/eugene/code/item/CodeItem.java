package com.eugene.code.item;

public class CodeItem {
	private int codeId;
	private String codeName;
	private int parentId;
	private int codeValue;
	private String codeJudgement;
	
	public int getCodeValue() {
		return codeValue;
	}
	public void setCodeValue(int codeValue) {
		this.codeValue = codeValue;
	}
	public String getCodeJudgement() {
		return codeJudgement;
	}
	public void setCodeJudgement(String codeJudgement) {
		this.codeJudgement = codeJudgement;
	}
	public int getCodeId() {
		return codeId;
	}
	public void setCodeId(int codeId) {
		this.codeId = codeId;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}
}
