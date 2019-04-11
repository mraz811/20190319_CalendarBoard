<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
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
table, td{
	border: 1px solid blue;
	border-collapse: collapse;
}
</style>
</head>
<body>
<%
	int year = Integer.parseInt((String)request.getParameter("year"));
	int month = Integer.parseInt((String)request.getParameter("month"));
	int date = Integer.parseInt((String)request.getParameter("date"));
	int lastday = Integer.parseInt((String)request.getParameter("lastday"));
	
	GregorianCalendar gcal = new GregorianCalendar();
	// new cal을 하면 현재껄 가지고 오지만, 우리가 찍어놓은 그 연도, 그 월을 알기위해 gregorian 사용
	int hour = gcal.get(Calendar.HOUR_OF_DAY); // 24시간
	int min = gcal.get(Calendar.MINUTE);
%>

<h1>일정작성하기</h1>

<form action="./CalController.do" method="post">
<input type="hidden" name="command" value="insertCal">
	<table>
		<tr>
			<td>아이디</td>
			<td><input type="text" name="id" value="M001" readonly="readonly"></td>
		</tr>
		<tr>
			<td>일정</td>
			<td>
				<select name="year">
					<%
						for(int i=(year-3); i<=(year+3); i++){
							%>
							<option value="<%=i%>" <%=(year==i)?"selected":"" %>><%=i%></option>
							<%
						}
					%>
				</select>년

				<select name="month">
					<%
						for(int i=1; i<=12; i++){
							%>
							<option value="<%=i%>" <%=(month==i)?"selected":"" %>><%=i%></option>
							<%
						}
					%>
				</select>월

				<select name="date">
					<%
						for(int i=1; i<=lastday; i++){
							%>
							<option value="<%=i%>" <%=(date==i)?"selected":"" %>><%=i%></option>
							<%
						}
					%>
				</select>일

				<select name="hour">
					<%
						for(int i=0; i<=23; i++){
						%>
						<option value="<%=i%>" <%=(hour==i)?"selected":"" %>><%=i%></option>
						<%
					}
					%>
				</select>시

				<select name="min">
					<%
						for(int i=0; i<60; i++){
						%>
						<option value="<%=i%>" <%=(min==i)?"selected":"" %>><%=i%></option>
						<%
					}
					%>
				</select>분
			</td>
		</tr>
		<tr>
			<td>제목</td>
			<td>
				<input type="text" name="title">
			</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>
				<textarea rows="10" cols="40" name="content"></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="일정등록">
			</td>
		</tr>

	</table>
</form>

</body>
</html>
















