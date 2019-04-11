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
	#trans{
		display: none;
	}
</style>
</head>
<script type="text/javascript">
	
	window.onload = function(){
		var delObj = document.getElementById("delBtn");
		delObj.onclick = function(){
			var formDel = document.forms[1];
			formDel.action = "./calDel.do?seq=${dto.seq}";
			formDel.method = "post";
			formDel.submit();
		}
	};

	function modify(){
		var modify = document.getElementById("mod");
		var transfer = document.getElementById("trans");
		
		modify.style.display = "none";
		transfer.style.display = "block";
	}

	function transfer(){
		var formModify = document.forms[0];
		formModify.action = "./modify.do?command=modify";
		formModify.method = "post";
		formModify.submit();
	}
	
	function deleteee(){
		var formDel = document.forms[1];
		formDel.action = "./delete.do?seq="+${dto.seq};
		formDel.method = "post";
		formDel.submit();
	}
	
</script>
<body>
<!-- 수정 -->
<form action="./CalController.do" method="post">
	<input type="text" value="${dto.seq}" name="seq">
	<input type="text" value="${dto.id}" name="id">
	<input type="text" value="${dto.title}" name="title">
	<textarea rows="10" cols="60" name="content">${dto.content}</textarea>
	<input type="button" id="mod" value="수정" onclick="modify()">
	<input type="button" id="trans" value="전송" onclick="transfer()">
</form>

<!-- 삭제 -->
<form action="" method="post">
	<input type="button" value="삭제" onclick="deleteee()">
	<button id="delBtn">삭제하기</button>
</form>

</body>
</html>
