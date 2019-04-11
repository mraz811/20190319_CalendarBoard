<%@page import="happy.com.dto.CalDto"%>
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
<%
	CalDto dto = (CalDto) request.getAttribute("dto");
%>
<script type="text/javascript">
function del1(){
	location.href="./CalController.do?command=delete&seq=<%=dto.getSeq()%>";
}
function del2(){
	location.href="./CalController.do?command=delete&seq=${dto.seq}";
}

function commit(){
 var form = document.forms[0];
 form.action = "./CalController.do";
 form.method = "post";
 form.submit();
}

</script>
<body>

<form action="./CalController.do" method="post">
<input type="hidden" name="command" value="modify">
<input type="hidden" name="seq" value="<%=dto.getSeq()%>">
	<table>
		<tr>
			<td>아이디</td>
			<td><%=dto.getId() %></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><%=dto.getTitle() %></td>
		</tr>
		<tr>
			<td>내용</td>
			<td>
				<input type="text" name="content" value="<%=dto.getContent() %>">
			</td>
		</tr>
		<tr>
			<td>등록일자</td>
			<td><%=dto.getRegDate() %></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="수정">
				<input type="button" value="삭제 inline Scriptlet" 
					onclick="javascript:location.href='./CalController.do?command=delete&seq=<%=dto.getSeq()%>'">
				<input type="button" value="삭제 inline EL" 
					onclick="javascript:location.href='./CalController.do?command=delete&seq=${dto.seq}'">
				<input type="button" value="삭제 embedded scriptlet" onclick="del1()">
				<input type="button" value="삭제 embedded EL" onclick="del2()">
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" value="삭제 form이지만 button" onclick="commit()" >
			</td>
		</tr>
	</table>
</form>
</body>
</html>
