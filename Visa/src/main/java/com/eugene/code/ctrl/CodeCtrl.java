package com.eugene.code.ctrl;

import com.eugene.common.db.SqlSessionCtrl;
import com.eugene.company.item.CompanyItem;
import com.eugene.code.item.CodeItem;

import java.util.*;
import org.apache.ibatis.session.SqlSession;

public class CodeCtrl extends SqlSessionCtrl{
	public List<CodeItem> selectAllByCodeName(String codeName)	{
		List<CodeItem> temp = new ArrayList<CodeItem>();
		SqlSession session = null;
		
		try {
			session = sqlSessionFactory.openSession();
			temp = session.selectList("CodeMapper.selectAllByCodeName", codeName);
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		return temp;
	}
	
	public List<CodeItem> selectAllByParentId(String parentId)	{
		List<CodeItem> temp = new ArrayList<CodeItem>();
		SqlSession session = null;
		
		try {
			session = sqlSessionFactory.openSession();
			temp = session.selectList("CodeMapper.selectAllByParentId", parentId);
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		return temp;
	}
	
	public String selectIdByName(String codeName)	{
		String temp = "";
		SqlSession session = null;
		
		try	{
			session = sqlSessionFactory.openSession();
			temp = session.selectOne("CodeMapper.selectIdByName", codeName);
		}catch(Exception e) {
			e.printStackTrace();
		}finally	{
			session.close();
		}
		return temp;
	}
}
