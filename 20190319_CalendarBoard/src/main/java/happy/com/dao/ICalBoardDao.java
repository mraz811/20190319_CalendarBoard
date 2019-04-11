package happy.com.dao;

import java.util.List;
import java.util.Map;

import happy.com.dto.CalDto;

public interface ICalBoardDao {

	public List<CalDto> getCalList(Map<String, String> map);
	
	public boolean insertCalBoard(CalDto dto);
	
	public int getCalView(Map<String, String> map);
	
	public List<CalDto> getCalViewList(Map<String, String> map);

	public CalDto getDetail(String seq);
	
	public int modifyBoard(Map<String, String> map);
	
	public int deleteBoard(String seq);
	
	public int multiDelForm(String[] seq);
	
}
