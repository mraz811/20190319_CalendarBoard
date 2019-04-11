package happy.com.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import happy.com.dao.CalBoardDao_Impl;
import happy.com.dao.ICalBoardDao;
import happy.com.dto.CalDto;
import happy.com.mybatis.SqlDaoSupport;

public class CalBoard_Main {

	public static void main(String[] args) {
//		SqlDaoSupport.getSqlSessionFactory();
		ICalBoardDao dao = new CalBoardDao_Impl();
		Map<String, String> map = new HashMap<String, String>();
		
		//id yyyyMMdd
	/*	map.put("id", "M001");
		map.put("yyyyMMdd", "20190319");
		List<CalDto> lists = dao.getCalList(map);
		for(CalDto dto : lists) {
			System.out.println(dto);
		}*/
		
//		CalDto dto 
//		  = new CalDto(0, "M001", "일정추가", "오늘도 힘차게", "201903200900", null);
//		boolean isc = dao.insertCalBoard(dto);
//		System.out.println(isc);
		 
//		map.put("id", "M001");
//		map.put("yyyyMMdd", "20190319");
//		int cnt = dao.getCalView(map);
//		System.out.println(cnt);
		
//		map.put("id", "M001");
//		map.put("yyyyMM", "201903");
//		List<CalDto> lists = dao.getCalViewList(map);
//		for(CalDto dto : lists ) {
//			System.out.println(dto.getmDate() +"//"+ dto);
//		}
		
	}

}
 