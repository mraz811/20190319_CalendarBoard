package happy.com.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;

import happy.com.dto.CalDto;
import happy.com.mybatis.SqlDaoSupport;

public class CalBoardDao_Impl implements ICalBoardDao {

	private final Logger logger = Logger.getLogger(CalBoardDao_Impl.class);
	private final String NS = "happy.com.calboard.";
	private SqlSessionFactory session = SqlDaoSupport.getSqlSessionFactory();
	
	@Override
	public List<CalDto> getCalList(Map<String, String> map) {
		logger.info("getCalList");
		List<CalDto> lists = null;
		SqlSession manager = session.openSession(true);
		lists = manager.selectList(NS+"getCalList", map);
		manager.close();
		return lists;
	}

	@Override 
	public boolean insertCalBoard(CalDto dto) {
		logger.info("insertCalBoard");
		SqlSession manager = session.openSession(true);
		int n = manager.insert(NS+"insertCalBoard", dto);
		manager.close();
		return n>0?true:false;
	}

	@Override
	public int getCalView(Map<String, String> map) {
		logger.info("getCalView");
		SqlSession manager = session.openSession(true);
		int cnt = manager.selectOne(NS+"getCalView", map);
		manager.close();
		return cnt;
	}

	@Override
	public List<CalDto> getCalViewList(Map<String, String> map) {
		logger.info("getCalViewList");
		List<CalDto> lists = null;
		SqlSession manager = session.openSession(true);
		lists = manager.selectList(NS+"getCalViewList", map);
		manager.close();
		return lists; 
	}

	@Override
	public CalDto getDetail(String seq) {
		logger.info("getDetail");
		CalDto dto = null;
		SqlSession manager = session.openSession(true);
		dto = manager.selectOne(NS+"getDetail", seq);
		manager.close();
		return dto;
	}

	@Override
	public int modifyBoard(Map<String, String> map) {
		logger.info("modifyBoard");
		int cnt = 0;
		SqlSession manager = session.openSession(true);
		cnt = manager.update(NS+"modify", map);
		manager.close();
		return cnt;
	}

	@Override
	public int deleteBoard(String seq) {
		logger.info("deleteBoard");
		int cnt = 0;
		SqlSession manager = session.openSession(true);
		cnt = manager.delete(NS+"delete", seq);
		manager.close();
		return cnt;
	}

	@Override
	public int multiDelForm(String[] seq) {
		int cnt = 0;
		SqlSession manager = session.openSession(false);
		for(int i=0; i<seq.length; i++) {
			cnt += manager.delete(NS+"delete",seq[i]);
		}
		if(cnt>0) {
			manager.commit();
		}
		manager.close();
		
		return cnt;
	}

}
