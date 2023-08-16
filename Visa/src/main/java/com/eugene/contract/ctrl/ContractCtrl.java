package com.eugene.contract.ctrl;

import com.eugene.common.db.SqlSessionCtrl;
import com.eugene.company.item.CompanyItem;
import com.eugene.employee.item.EmployeeItem;
import com.eugene.contract.item.ContractItem;

import java.util.ArrayList;
import java.util.List;
import org.apache.ibatis.session.SqlSession;

public class ContractCtrl extends SqlSessionCtrl {
	public int insertContract(ContractItem contractItem)	{
		int success = -1;
		SqlSession session = null;
		
		try	{
			session = sqlSessionFactory.openSession();
			success = session.insert("ContractMapper.insertContract", contractItem);
		}catch(Exception e){
			e.printStackTrace();
		}
		finally {
			session.commit();
			session.close();
		}
		return success;
	}
}
