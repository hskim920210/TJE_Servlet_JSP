<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정 에러</title>
</head>
<body>

	<h2>게시글을 수정하는 과정에서 문제가 발생했습니다.</h2>
	<h3>에러 내용 : ${ errorMsg }</h3>

<p><a href='<%= request.getContextPath() %>/main.do'>메인화면으로 이동</a></p>
</body>
</html>