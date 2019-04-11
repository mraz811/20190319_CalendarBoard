package happy.com.ctrl;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import happy.com.comm.Util;
import happy.com.dao.CalBoardDao_Impl;
import happy.com.dao.ICalBoardDao;
import happy.com.dto.CalDto;

public class CalController extends HttpServlet {

	private static final long serialVersionUID = 8283307553752523104L;
 
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String command = request.getParameter("command");
		System.out.println("요청값: "+command);
		
		ICalBoardDao dao = new CalBoardDao_Impl();
		System.out.println("Data Access Object 생성");
		
		// 분기
		if(command.equalsIgnoreCase("calendar")) {
			response.sendRedirect("./calendar.jsp");
		} else if(command.equalsIgnoreCase("insertForm")) {
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String date = request.getParameter("date");
			String lastday = request.getParameter("lastday");
			System.out.println(year+":"+month+":"+date+":"+lastday);
			
			request.setAttribute("year", year);
			request.setAttribute("month", month);
			request.setAttribute("date", date);
			request.setAttribute("lastday", lastday);
			dispatch("./insertCalBoard.jsp", request, response);
		} else if(command.equalsIgnoreCase("insertCal")) {
			String id = request.getParameter("id");
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String date = request.getParameter("date");			
			String hour = request.getParameter("hour");
			String min = request.getParameter("min");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			System.out.printf("%s:%s:%s:%s:%s:%s:%s:%s",id,year,month,date,hour,min,title,content);
			
			String mDate = year + Util.isTwo(month) + Util.isTwo(date) + Util.isTwo(hour) +
					Util.isTwo(min);
			System.out.println("mDate: "+mDate);
			
			CalDto dto = new CalDto(0, id, title, content, mDate, null);
			boolean isc = dao.insertCalBoard(dto);
			if(isc) {
				response.sendRedirect("./CalController.do?command=calendar");
			} else {
				
			}
		} else if(command.equalsIgnoreCase("detail")) {
			String seq = request.getParameter("seq");
			CalDto dto = dao.getDetail(seq);
			request.setAttribute("dto", dto);
			dispatch("./detailView.jsp", request, response);
			
		} else if(command.equalsIgnoreCase("modify")) {
			String seq = request.getParameter("seq");
			String content = request.getParameter("content");

			Map<String, String> map = new HashMap<String, String>();
			map.put("seq", seq);
			map.put("content", content);
			
			int n = dao.modifyBoard(map);
			if(n>0) {
				response.sendRedirect("./CalController.do?command=calendar");
			} else {
				
			}
		} else if(command.equalsIgnoreCase("delete")) {
			String seq = request.getParameter("seq");
			int n = dao.deleteBoard(seq);
			if(n>0) {
				response.sendRedirect("./CalController.do?command=calendar");
			} else {
				
			}
		} else if(command.equalsIgnoreCase("calList")) {
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String date = request.getParameter("date");	
			
			// yyyyMMdd + id 
			String yyyyMMdd = year+Util.isTwo(month)+Util.isTwo(date);
			Map<String, String> map = new HashMap<String, String>();
			map.put("yyyyMMdd", yyyyMMdd);
			map.put("id", "M001");
			
			List<CalDto> lists = dao.getCalList(map);
			System.out.println(lists.size());
			
			request.setAttribute("lists", lists);
			dispatch("./calList.jsp", request, response);
		} else if(command.equalsIgnoreCase("multiDel")) {
			String[] seqs = request.getParameterValues("chk");
			System.out.println(Arrays.toString(seqs));
			int n = dao.multiDelForm(seqs);
			if(n>0) {
				response.sendRedirect("./CalController.do?command=calendar");
			}
		}
		
	}
 
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
 
	private void dispatch(String url, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("이동화면: " + url);
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}
	
}
