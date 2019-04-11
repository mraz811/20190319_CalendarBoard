<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	// javascript 방식
	function allchk(bool){
		var chks = document.getElementsByName("chk");
		for (var i = 0; i < chks.length; i++) {
			chks[i].checked = bool;
		}
	}
	
	
	$(function(){
		// 얘가 서브밋이 걸렸을 때 이벤트
		$("#multiDelForm").submit(function(){
			// 체크된 애가 하나도 없다면
			if($("#multiDelForm input:checked").length == 0){
				alert("하나 이상 체크해 주세요");
				return false;
			} else {
				$("#multiDelForm input:checked");
			}			
		});		
	});
	
	
</script>
<body>
<h1>일정 목록 보기</h1>
${fn:length(lists)==0}	  - false
${fn:length(lists) ne 0}  - true
<c:if test="${!empty lists}">
	lists가 비어있지 않음. 글 있음
</c:if>

<form action="./CalController.do" method="post" id="multiDelForm">
<input type="hidden" name="command" value="multiDel">
	<table border="1">
		<col width="50px"><col width="50px"><col width="200px">
		<col width="200px"><col width="100px">
		<thead>
			<tr>
				<th>
					<input type="checkbox" name="all" onclick="allchk(this.checked)">
				</th>
				<th>번호</th>
				<th>제목</th>
				<th>일정</th>
				<th>작성일</th>
			</tr>
		</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty lists}">
						<tr>
							<td colspan="5">-- 작성된 글이 없습니다 --</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:set var="l" value="${lists}" />
						<%-- 					<c:out value="${l}"/> --%>
						<!-- 			객채는  한번만 생성되면 됨 여기이ㅔ usebean만들어 주겟다.-->
						<jsp:useBean id="calutil" class="happy.com.comm.ChangeDateBean" />
						<c:forEach var="dto" items="${l}" varStatus="vs">
							<tr>
								<td><input type="checkbox" name="chk" value="${dto.seq}"></td>
								<td>${fn:length(l)-vs.index}</td>
								<td>${dto.title}</td>
								<td>
									<jsp:setProperty property="toDate" name="calutil" value="${dto.mDate}" /> 
									<jsp:getProperty property="changeDate" name="calutil" />
								</td>
								<td>
									<fmt:formatDate value="${dto.regDate}" pattern="yyyy-MM-dd" />
								</td>
							</tr>
						</c:forEach>

					</c:otherwise>
				</c:choose>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="5">
						<input type="submit" value="다중삭제">
					</td>
				</tr>
			</tfoot>
		</table>
</form>


</body>
</html>
