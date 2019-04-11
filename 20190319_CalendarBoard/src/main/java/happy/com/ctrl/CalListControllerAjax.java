package happy.com.ctrl;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import happy.com.dao.CalBoardDao_Impl;
import happy.com.dao.ICalBoardDao;
import net.sf.json.JSONObject;

public class CalListControllerAjax extends HttpServlet {

	private static final long serialVersionUID = 8165417206178186898L;

	// ajax에서는 forward를 만들 것이 아니기 때문에 request객체는 필요없지만
	// response 객체는 필요하다. 요청이 들어오면 응답을 해주어야 하기 때문에
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		String id = req.getParameter("id");
		String yyyyMMdd = req.getParameter("yyyyMMdd");
		
		System.out.printf("전달받은 객체: %s, %s",id,yyyyMMdd);
		
		ICalBoardDao dao = new CalBoardDao_Impl();
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("yyyyMMdd", yyyyMMdd);
		
		int n = dao.getCalView(map);
//		System.out.println("dao 실행 결과: " + n);
	
		//-----------------값 넘겨주는 작업 ------------------//
		// json형태를 받아 올 것이다. json 형태가 어떻게 되어있는지 알아보자//
		// JSON {{"key":"value"},{"key":"value"}} 형태로 전송해 줘야 함
		// jsonlib.jar을 이용하며 Map으로 만든 다음, JSON Object로 변경할 예정
		// JsonObject msg={{"calCount":n}} calCount가 값을 갖고 있는 key 
		// 그래서 msg.calCount를 불러주면 n값을 가져올 수 있음
		
		Map<String, Integer> mapl = new HashMap<String, Integer>();
		mapl.put("calCount", n);

		JSONObject obj = JSONObject.fromObject(mapl);
		System.out.println(obj.toString());
		
		// response 응답 객체
		PrintWriter out = resp.getWriter();
		// 요청했던 페이지로 응답을 해줌
		// 생성된 객체를 브라우저로 전송
		obj.write(out);
		out.flush();
		out.close();
	}

	
	
	
	
}
