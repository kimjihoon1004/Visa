package com.eugene.company.ctrl;

import com.eugene.common.db.SqlSessionCtrl;
import com.eugene.company.item.CompanyItem;
import com.eugene.employee.item.EmployeeItem;

import java.util.ArrayList;
import java.util.List;
import org.apache.ibatis.session.SqlSession;

public class CompanyCtrl extends SqlSessionCtrl  {
	public int insertCompany(CompanyItem companyItem)	{
		int success = -1;
		SqlSession session = null;
		
		try {
			session = sqlSessionFactory.openSession();
			success = session.insert("CompanyMapper.insertCompany", companyItem);
		}catch(Exception e){
			e.printStackTrace();
		}
		finally {
			session.commit();
			session.close();
		}
		return success;
	}
	
	public List<CompanyItem> checkCompany(CompanyItem companyItem)	{
		List<CompanyItem> temp = new ArrayList<CompanyItem>();
		SqlSession session = null;
		
		try {
			session = sqlSessionFactory.openSession();
			temp = session.selectList("CompanyMapper.checkCompany", companyItem);
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		return temp;
	}
	
	public List<CompanyItem> checkAllCompany()	{
		List<CompanyItem> temp = new ArrayList<CompanyItem>();
		SqlSession session = null;
		
		try {
			session = sqlSessionFactory.openSession();
			temp = session.selectList("CompanyMapper.checkAllCompany");
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		return temp;
	}
	
	public List<CompanyItem> selectAllByName(String companyName)	{
		List<CompanyItem> temp = new ArrayList<CompanyItem>();
		SqlSession session = null;
		
		try {
			session = sqlSessionFactory.openSession();
			temp = session.selectList("CompanyMapper.selectAllByName", companyName);
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		return temp;
	}
	
	public List<CompanyItem> selectAllById(String companyId)	{
		List<CompanyItem> temp = new ArrayList<CompanyItem>();
		SqlSession session = null;
		
		try {
			session = sqlSessionFactory.openSession();
			temp = session.selectList("CompanyMapper.selectAllById", companyId);
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		return temp;
	}
	
}
