<%@page import="happy.com.dto.CalDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="happy.com.comm.Util"%>
<%@page import="happy.com.dao.CalBoardDao_Impl"%>
<%@page import="happy.com.dao.ICalBoardDao"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#calendar{
		border: 1px solid gray;
		border-collapse: collapse;	
	}
	
	#calendar th{
		width: 80px;
		border: 1px solid gray;
	}
	
	#calendar td{
		width: 80px;
		height: 80px;
		border: 1px solid gray;
		text-align: left;
		vertical-align: top;
		position: relative;
	}
	
	a{
		text-decoration: none;
	}
	
	.clist p{
		font-size: 6px;
		margin: 1px;
		background-color: pink;
	}
	
	.cPreview{
/* 		border: 1px solid forestgreen; */
		background-color: tomato;
		position: absolute; 
		top: -30px;
		left: 10px;
		
		width: 40px;
		height: 40px;
		color: white;
		font-weight: bold;
		text-align: center;
/* 		vertical-align: middle; */
		line-height: 40px;
		border-radius: 40px 40px 40px 1px;
	}
	
</style>
</head>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(function(){
	
	// 마우스 떼었을 때
	$(".countView").mouseleave(function(){
		$(".cPreview").remove();
	});
	
	
	// toggle로 하면 화면이 멈추게 계속 나올 수 있기 때문에 mouse를 올리면.. 
	// javascript는 div태그를 만들고 지우는게 아니라 보이냐 안보이느냐인데, jQuery는 만들고 지울 수 있다.
	// 태그를 추가하면 마진하고 패딩이 있어서 밀릴 수 있기 때문에 position을 absolute를 잡을 것이고,
	// position이 fixed로 잡히면 0,0 기준으로.. 
	$(".countView").mouseenter(function(){
		// javascript는 노드 트리 때문에 검색이 힘들지만 jQuery는 셀렉터 표현식으로 element를 검색하기에 가능
		// 내가 현재 클릭된 애의 element를 가지고 오게 됨 
		var aCountView = $(this);
		// 올린 상태에서 ajax를 사용하지 않으면 화면이 refresh되면서 올린 상태값도 사라지게 되기 때문에 ajax사용할 것
		// 년도, 월, 마우스 올린 일자 - 총 3개 값이 필요
		var year = $(".y").text().trim(); // 문자열이니까 공백이 잇을 수 있으므로
		var month = $(".m").text().trim(); // trim()으로 잘라줌 
		var cDate = aCountView.text().trim(); 
// 		alert(year+":"+month+":"+cDate);
		// 달과 일자가 한 자리일 경우 java를 사용x -> javascript에서 function을 만들어서 해결할 것. 아래
		
		// mDate로 변경
		var yyyyMMdd = year +isTwo(month) + isTwo(cDate);
// 		alert(yyyyMMdd);
		// get방식으로 전송할 것이고, 받을 때는 JSON 으로 받을 것이다. 그래서 json-lib받아놓았엇음 ㅋ
		// json object, argument를 자동으로 맵으로 때려넣어 주는 게 json-lib(common 4개 ezmorph)
		
		// 객체이니까 {}
		$.ajax({
			url : "CalListAjax.do", // 요청 URL (대부분 따로 만듭니다. 회사에서)
			type : "post", // 전송처리방식
			async : false, // true가 비동기식, false가 동기 (일정이 3개면 3을 가지고 오기 위해)
			data : "id=M001&yyyyMMdd="+yyyyMMdd, // 서버 전송 파라미터
			dataType : "JSON", // 서버에서 받아오는 데이터 타입
			success : function(msg){
// 				alert(msg.calCount); // calCount라는 이름의 json을 보내줄 것. 
				var obj = msg.calCount;
				aCountView.after("<div class='cPreview'>"+obj+"</div>")
			}, error : function(){
				alert("서버통신 실패");
			}

		});
	});
});

function isTwo(n){
	return n.length<2? "0"+n : n;
}

</script>
<body>
<h1>일정관리 게시판</h1>
<%
	// 캘린더 객체 생성
	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR); // 현재 로컬날짜의 년도
	// 현재의 달 가지고 옴 (배열이기 때문에) 가져올 때는 +1, 넣을 땐 -1
	int month = cal.get(Calendar.MONTH)+1; 
	
	// 처음에 뜨는 달력은 현재달력이지만, 우리가 원하는 달력은 서버로 요청하면.. 받아줘야하니
	// 두번째 화면이 refresh될 때 전송받는 값
	String paramYear = request.getParameter("year");
	String paramMonth = request.getParameter("month");
	
	if(paramYear != null){ 
		year = Integer.parseInt(paramYear); // paramYear를 넣어줌
	}
	
	if(paramMonth != null){ // 3이 아닌 03으로 만들어야 하기 때문에 공통모듈만들 것
		month = Integer.parseInt(paramMonth);
	}

	// api가 자동으로 제공해주지만 확실히 하기위해 처리해주겠다
	if(month>12){
		month = 1;
		year++;
	}
	if(month<1){
		month=12;
		year--;
	}

	// 달력의 입력받은 년월일로 세팅
	cal.set(year, month-1, 1);
	
	// 매 달력의 1일의 요일
	int dayofWeek = cal.get(Calendar.DAY_OF_WEEK); // 요일이 나올 것  2019년 3월 1일 금요일 = 6
	
	//매 달력의 최대 일수
	int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	
	// 달력의 일정 표현
	ICalBoardDao dao = new CalBoardDao_Impl();
	
	// 나중에 CalList인가 달력 가지고 오는애는 yyyyMM으로 받기 때문
	// yyyyMM 의 형태로 만들어 주어야 하기 때문에 MM을 두자리로 해주어야 함
	// happy.com.comm 공통모듈로 갑니닷
	String yyyyMM = year + Util.isTwo(String.valueOf(month));
	
	// dao에서 현재 달력의 게시글을 가져옴
	Map<String, String> map = new HashMap<String, String>();
	map.put("id", "M001");
	map.put("yyyyMM", yyyyMM);
	
	List<CalDto> clist = dao.getCalViewList(map);
%>

<table id="calendar">
	<caption>
		<a href="./calendar.jsp?year=<%=year-1%>&month=<%=month%>">◁</a>
		<a href="./calendar.jsp?year=<%=year%>&month=<%=month-1%>">◀</a>
		
		<span class="y"><%=year%></span>년
		<span class="m"><%=month%></span>월
		
		<a href="./calendar.jsp?year=<%=year%>&month=<%=month+1%>">▶</a>
		<a href="./calendar.jsp?year=<%=year+1%>&month=<%=month%>">▷</a>
	</caption>

	<tr>
		<th>일</th><th>월</th>
		<th>화</th><th>수</th>
		<th>목</th><th>금</th><th>토</th>
	</tr>
	<tr>
		<%
		// 공백 (dayofWeek)
		for(int i =0; i<dayofWeek-1; i++){ // 자기 자신 빼야하니까
			out.print("<td>&nbsp;</td>");
		}
		
		for(int i=1; i<=lastDay;i++){
			%>
			<td>
				<a class="countView" href="./CalController.do?command=calList&year=<%=year%>&month=<%=month%>&date=<%=i%>"
				 style="color:<%=Util.fontColor(i,dayofWeek)%>">
				<%=i %>
				</a>
				<a href="./CalController.do?command=insertForm&year=<%=year%>&month=<%=month%>&date=<%=i%>&lastday=<%=lastDay%>">
					<img alt="일정 추가" src="./img/pen.png" style="width: 10px; height: 10px">
				</a>
				<div class="clist">
					<%=Util.getCalView(i, clist) %>
				</div>
			</td>
			<%
			
			if((dayofWeek-1+i)%7==0){
				out.print("</tr><tr>");
			}
		}
		
		for(int i=0;i<(7-(lastDay+dayofWeek-1)%7)%7;i++){
			out.print("<td>&nbsp;</td>");
		}
		
		%>
	</tr>


</table>

	
</body>
</html>








