package happy.com.mybatis;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlDaoSupport {

	private static SqlSessionFactory sqlSessionFactory;

	static {
		String path = "happy/com/mybatis/Configuration.xml";
		try {
			Reader reader = Resources.getResourceAsReader(path);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
			System.out.println("SqlSessionFactory 객체 생성 성공");
			reader.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	 
	
	public static SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}
	
	
	
	
}
