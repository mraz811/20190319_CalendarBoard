package happy.com.ctrl;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ModifyCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ModifyCtrl() {
        super();
    }

    // init - service - destroy : life cycle
    
	public void init(ServletConfig config) throws ServletException {
		System.out.println("ModifyCtrl이 초기화 되었습니다.");
	}

	public void destroy() {
		System.out.println("ModifyCtrl이 삭제 되었습니다.");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String id = request.getParameter("id");
		String seq = request.getParameter("seq");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		System.out.printf("%s %s %s %s \n", id, seq, title, content);
		
		
	}

}
