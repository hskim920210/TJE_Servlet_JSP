<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 회원 목록</title>
</head>
<body>

<table>
	<tr>
		<th>인덱스</th>
		<th>아이디</th>
		<th>이름</th>		
	</tr>
<c:forEach var="member" items="${list}" varStatus="status">


	<tr>
		<th>${ status.count }</th>
		<th>
	
	<a href='${pageContext.request.contextPath}/auth/detail.do?id=${member.id}'>
	${member.id}</a></th>
		
		<th>${member.name}</th>		
	</tr>
	
</c:forEach>	
	
</table>

<h3><a href="<%=request.getContextPath()%>/main.do">메인으로 이동</a></h3>
				
</body>
</html>




















