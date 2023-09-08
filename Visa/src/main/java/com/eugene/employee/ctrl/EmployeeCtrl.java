package com.eugene.employee.ctrl;

import com.eugene.common.db.SqlSessionCtrl;
import com.eugene.employee.item.EmployeeItem;
import java.util.ArrayList;
import java.util.List;
import org.apache.ibatis.session.SqlSession;

public class EmployeeCtrl extends SqlSessionCtrl {
	
	// employee db에서 emp_name과 emp_number를 이용하여 값을 출력
	public List<EmployeeItem> checkEmployee(EmployeeItem empItem)	{
		List<EmployeeItem> temp = new ArrayList<EmployeeItem>();
		SqlSession session = null;
		
		try {
			session = sqlSessionFactory.openSession();
			temp = session.selectList("EmployeeMapper.checkEmployee", empItem);
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		return temp;
	}
	
	
	public int insertEmployee(EmployeeItem empItem)	{
		int success = -1;
		SqlSession session = null;
		
		try {
			session = sqlSessionFactory.openSession();
			success = session.insert("EmployeeMapper.insertEmployee", empItem);	
		}catch(Exception e){
			e.printStackTrace();
		}
		finally {
			session.commit();
			session.close();
		}
		return success;
	}
	
	/*rkskekf*/
	public List<EmployeeItem> checkAllEmployee()	{
		List<EmployeeItem> temp = new ArrayList<EmployeeItem>();
		SqlSession session = null;
		
		try {
			session = sqlSessionFactory.openSession();
			temp = session.selectList("EmployeeMapper.checkAllEmployee");
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		return temp;
	}
	
	public List<EmployeeItem> selectAllByName(String empName)	{
		List<EmployeeItem> temp = new ArrayList<EmployeeItem>();
		SqlSession session = null;
		
		try {
			session = sqlSessionFactory.openSession();
			temp = session.selectList("EmployeeMapper.selectAllByName", empName);
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		return temp;
	}
	
	public List<String> selectAllCompanyId()	{
		List<String> temp = new ArrayList<String>();
		SqlSession session = null;
		
		try {
			session = sqlSessionFactory.openSession();
			temp = session.selectList("EmployeeMapper.selectAllCompanyId");
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		return temp;
	}
	
	public List<EmployeeItem> selectAllByCompanyId(EmployeeItem employeeItem)	{
		List<EmployeeItem> temp = new ArrayList<EmployeeItem>();
		SqlSession session = null;
		
		try {
			session = sqlSessionFactory.openSession();
			temp = session.selectList("EmployeeMapper.selectAllByCompanyId", employeeItem);
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		return temp;
	}
	
	public List<EmployeeItem> selectAllByCompanyIdAndName(EmployeeItem employeeItem)	{
		List<EmployeeItem> temp = new ArrayList<EmployeeItem>();
		SqlSession session = null;
		
		try {
			session = sqlSessionFactory.openSession();
			temp = session.selectList("EmployeeMapper.selectAllByCompanyIdAndName", employeeItem);
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		return temp;
	}
	
	public List<EmployeeItem> selectAllById(String id)	{
		List<EmployeeItem> temp = new ArrayList<EmployeeItem>();
		SqlSession session = null;
		
		try {
			session = sqlSessionFactory.openSession();
			temp = session.selectList("EmployeeMapper.selectAllById", id);
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		return temp;
	}
	
	
}
