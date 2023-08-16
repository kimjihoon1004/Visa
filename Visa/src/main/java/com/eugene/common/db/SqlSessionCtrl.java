package com.eugene.common.db;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlSessionCtrl {
public static SqlSessionFactory sqlSessionFactory;
	
    static {
        String resource = "com/eugene/common/db/Configuration.xml";        
        Reader reader;
        try {
        	reader = Resources.getResourceAsReader( resource );
        	sqlSessionFactory = new SqlSessionFactoryBuilder().build( reader );
        	
        	System.out.println("sqlSessionFactory build success!");
    	} catch (IOException e) {
    		e.printStackTrace();
    	}
        
    }
    public static SqlSessionFactory getSqlSession() {
        return sqlSessionFactory;
    }
}
