package com.eugene.user.ctrl;

import com.eugene.common.db.SqlSessionCtrl;
import com.eugene.user.item.UserItem;
import java.util.ArrayList;
import java.util.List;
import org.apache.ibatis.session.SqlSession;

public class UserCtrl extends SqlSessionCtrl {
	
	// user 정보 전부 가져온다.
	// user가 여러명이기 떄문에 각 user의 정보를 아이템으로 저장하며 리스트 한 인덱스에 한 명의 정보가 저장된다.
	public List<UserItem> selectAllUser()	{
		List<UserItem> temp = new ArrayList<UserItem>();
		SqlSession session = null;
		
		try{
			session = sqlSessionFactory.openSession();
			temp = session.selectList("UserMapper.selectAllUser");
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return temp;
	}
	
	// 특정 user의 이름, 생년월일, 전화번호를 이욯하여 아이디를 찾는다.
	public String findUserId(UserItem userItem)	{
		String temp = null;
		SqlSession session = null;
		
		try{
			session = sqlSessionFactory.openSession();
			temp = session.selectOne("UserMapper.findUserId", userItem);
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return temp;
		
	}
	
	// 특정 user의 아이디, 이름, 생년월일, 전화번호를 이용하여 비밀번호를 찾는다.
	public String findUserPw(UserItem userItem)	{
		String temp = null;
		SqlSession session = null;
		
		try{
			session = sqlSessionFactory.openSession();
			temp = session.selectOne("UserMapper.findUserPw", userItem);
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return temp;
	}
	
	// user의 아이디를 이용하여 비밀번호를 조회한다.
	public String checkPw(String id)	{
		String temp = null;
		SqlSession session = null;
		
		try{
			session = sqlSessionFactory.openSession();
			temp = session.selectOne("UserMapper.checkPw", id);
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return temp;
	}
	
	public String selectId(String id)	{
		String temp = null;
		SqlSession session = null;
		
		try{
			session = sqlSessionFactory.openSession();
			temp = session.selectOne("UserMapper.selectId", id);
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return temp;
	}
	
	
	// user의 인적사항을 아이템으로 set하여 user테이블에 추가한다.
	public int insertUser(UserItem userItem)	{
		int success = -1;
		SqlSession session = null;
		
		try {
			session = sqlSessionFactory.openSession();
			success = session.insert("UserMapper.insertUser", userItem);	
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
