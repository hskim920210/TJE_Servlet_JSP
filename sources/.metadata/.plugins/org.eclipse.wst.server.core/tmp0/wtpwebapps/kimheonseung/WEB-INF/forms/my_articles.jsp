<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<title>게시판</title>
</head>
<body>


	<h4 align="center">${ login_user.user_id } 님의 게시글 (최근 5건만 나타납니다.) <a href="<%= request.getContextPath() %>/my_detail_article.khs?user_id=${ login_user.user_id }">더보기</a></h4>
<table border=1 style="margin-left: auto; margin-right: auto;">
			<tr>
				<th>게시글 번호</th>
				<th>제목</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>좋아요</th>
			</tr>
			
			<c:if test="${ empty articleList }" var="r">
			<tr>
				<th colspan="5"><h4>게시글이 존재하지 않습니다.</h4></th>
			</tr>
			</c:if>
			<c:if test="${ not r }">
				<c:forEach items="${ articleList }" var="article">
				<tr>
					<th>${ article.article_num }</th>
					<th><a href='<%= request.getContextPath() %>/detail_board.khs?article_num=${ article.article_num }'>
							${ article.article_title } 
							[<c:forEach var="comment" items="${ articleNumAndCommentUserMap }">
								<c:if test="${ article.article_num eq comment.key }">
									${ comment.value }
								</c:if>
							</c:forEach>]
							</a></th>
					<th>${ article.write_date }</th>
					<th>${ article.read_count }</th>
					<th>${ article.like_count }</th>
				</tr>
				</c:forEach>
			</c:if>
			
</table>





<h4 align="center">${ login_user.user_id } 님의 댓글(최근 5건만 나타납니다.) <a href="<%= request.getContextPath() %>/my_detail_comment.khs?user_id=${ login_user.user_id }">더보기</a></h4>
<table border=1 style="margin-left: auto; margin-right: auto;">
			<tr>
				<th>게시글 번호</th>
				<th>내용</th>
				<th>작성일</th>
			</tr>
			
			<c:if test="${ empty commentMyList }" var="r">
			<tr>
				<th colspan="5"><h4>댓글이 존재하지 않습니다.</h4></th>
			</tr>
			</c:if>
			<c:if test="${ not r }">
				<c:forEach items="${ commentMyList }" var="comment">
				<tr>
					<th>${ comment.article_num }</th>
					<th><a href='<%= request.getContextPath() %>/detail_board.khs?article_num=${ comment.article_num }'>
							${ comment.content } 
							</a></th>
					<th>${ comment.write_time }</th>
				</tr>
				</c:forEach>
			</c:if>
			
</table>


<p align="center"><a href="<%= request.getContextPath() %>/main.khs">메인으로</a></p>


<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>