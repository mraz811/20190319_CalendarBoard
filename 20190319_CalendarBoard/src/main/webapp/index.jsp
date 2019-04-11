<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>일정관리 게시판</h1>


<jsp:forward page="./CalController.do">
	<jsp:param value="calendar" name="command"/>
</jsp:forward>



</body>
</html>
