package com.eugene.judgement.ctrl;

import com.eugene.common.db.SqlSessionCtrl;
import com.eugene.judgement.item.JudgementItem;
import java.util.ArrayList;
import java.util.List;
import org.apache.ibatis.session.SqlSession;

public class JudgementCtrl extends SqlSessionCtrl {
	public List<JudgementItem> selectAllByEmpId(String empId)	{
		List<JudgementItem> temp = new ArrayList<JudgementItem>();
		SqlSession session = null;
		
		try {
			session = sqlSessionFactory.openSession();
			temp = session.selectList("JudgementMapper.selectAllByEmpId", empId);
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		return temp;
	}
}
