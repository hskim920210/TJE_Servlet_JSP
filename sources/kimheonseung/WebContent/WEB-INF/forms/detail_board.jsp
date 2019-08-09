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
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.js"></script>
<script type="text/javascript">
	
	var like_count_tot = ${like_count};
	var comment_count = ${commentSize};
	
	$(function () {
		var isLogin = false;
		var user_id = '${user_id}';
		
		if(user_id.length != 0) {
			isLogin = true;
		}
		
		if(isLogin == true) {
			$("#likeBtn").on("click", function () {
					$.ajax({
						url:'<%=request.getContextPath()%>/like.khs',
						type:"post",
						contentType:"application/x-www-form-urlencoded; charset=utf-8",
						data:"user_id=${user_id}&article_num=${article_num}&like_count=${like_count}",
						dataType:"text",
						success:function (result){ // result 는 불린 타입
							var msg='';
							// 성공 시 확인창과 보여줄 메세지를 설정
							if( eval(result) ){ // true 라면, 즉 이미 존재하는 ID
								alert('좋아요 완료');
								msg='좋아요 취소';
								like_count_tot += 1;
								$("#like").text(msg);
								$("#likeCountArea").text(like_count_tot);
							} else { // 가입할 수 있는 ID
								alert('좋아요 취소 완료');
								msg='좋아요';
								like_count_tot -= 1;
								$("#like").text(msg);
								$("#likeCountArea").text(like_count_tot);
							}
						},
						error:function (result){
							alert('좋아요 과정에서 문제 발생');
						}
					});
				});
			};
			
			if(isLogin == false) {
				$("#likeBtn").on("click", function () {
					alert('로그인이 필요한 서비스입니다.');
				});
			}
			
		});
	
	
	
	function delete_comment(comment_id) {
		$.ajax({
			url:'<%=request.getContextPath()%>/comment_delete.khs',
			type:"post",
			contentType: 
				"application/x-www-form-urlencoded; charset=utf-8",
			data:"comment_id=" + comment_id,
			dataType:"text",
			success:function(result){			
				if( eval(result) ) {						
					var selector = '#comment_' + comment_id
					$(selector).remove();
					alert('댓글(' + comment_id + ') 삭제 완료!');	
					
					comment_count -= 1;
					$("#comment_count").text(comment_count);
					$("#comment_count_bottom").text(comment_count);
					
					if( comment_count == 0 ) {
						$("#comment_table").remove();
						$("#comment_area").append("<h4>댓글이 존재하지 않습니다.</h4>");
					}
				} else {
					alert('댓글 삭제과정에서 문제 발생');		
				}
					
			},
			error:function(result){
				alert('댓글 삭제과정에서 문제 발생');					
			}
		});
	}
	
	
	
	
	
	
	function insert_comment() {
		var comment_data = $("#comment_form").serialize();
		
		$.ajax({
			url:'<%= request.getContextPath() %>/comment_write.khs',
			type:"post",
			contentType:"application/x-www-form-urlencoded; charset=utf-8",
			data: comment_data,
			dataType:"json",
			success:function(result) {
				if(eval(result.result)){
					var commentTag = "<tr id='comment_" + result.comment_id + "''>";
					commentTag += "<td>" + result.user_id + "</td>";
					commentTag += "<td>" + result.content + "</td>";					
					commentTag += "<td>" + result.date + "</td>";
					commentTag += "<td>";
					commentTag += "<button onclick='delete_comment(" + result.comment_id + ");'>삭제</button>";					
					commentTag += "</td>";
					commentTag += "</tr>";
					$("#comment_table").append(commentTag);
					comment_count += 1;
					$("#comment_count").text(comment_count);
					$("#comment_count_bottom").text(comment_count);
					console.log(commentTag);
				} else {
					alert('댓글 작성에서 문제 발생');
					console.log(commentTag);
				}
			}
			
		});
	}
	
		

</script>


</head>
<body>
<div class="panel panel-success" align="center">
	<input type="hidden" name="user_id" value="${ login_user.user_id }">
	<input type="hidden" name="article_num" value="${ detailBoard.article_num }">
<table border="1">
	<tr>
		<th>작성자 : ${ detailBoard.writer_nick }</th>
		<th style="text-align: center">${ detailBoard.write_date }</th>
	</tr>
	<tr>
		<th colspan="2" style="text-align: center" height="60px">${ detailBoard.article_title } (<span id="comment_count">${ commentSize }</span>)</th>
	</tr>
	<tr>
		<td colspan="2" height="160px">${ detailBoard.article_content }</td>
	</tr>
	<tr>
		<th style="text-align: center">조회수 (${ read_count })</th>
		<th><button id="likeBtn"><span id="like">
			<c:if test="${like_check==true}" var="p">
				좋아요 취소
			</c:if>
			<c:if test="${not p}">
				좋아요
			</c:if>
		</span></button>(<span id="likeCountArea">${ like_count }</span>)</th>
	</tr>
	<tr>
		<th>댓글쓰기</th>
		<c:if test="${ empty login_user }" var="p">
				<th><input type="text" readonly value="로그인이 필요한 서비스입니다."><input type="submit" value="로그인"></th>
		</c:if>
		<c:if test="${ not p }">
		<form id="comment_form">
				<th><textarea style="resize: none;" rows="3" cols="20" name="content"></textarea>
				<input type="button" value="댓글등록" onclick="insert_comment();"></th>
				<input type="hidden" name="article_num" value="${ detailBoard.article_num }">
			</form>
		</c:if>
	</tr>

</table>
</div>

<h2 align="center">댓글 (<span id="comment_count_bottom">${ commentSize }</span>)</h2>

	<div id="comment_area" class="panel panel-success" align="center">
		<c:if test="${ empty commentList }" var="p">
		<table border="1" id="comment_table">
				<tr id="comment_start">
					<td>닉네임(ID)</td>
					<td>내용</td>
					<td colspan="2">작성일</td>
				</tr>
		</table>
		</c:if>
		
		<c:if test="${ not p }">
	<table border="1" id="comment_table">
				<tr id="comment_start">
					<td>닉네임(ID)</td>
					<td>내용</td>
					<td colspan="2">작성일</td>
				</tr>
			<c:forEach items="${ commentList }" var="comment">
				<tr id="comment_${ comment.comment_id }">
					<td>${ comment.user_nick } (${ comment.user_id })</td>
					<td>${ comment.content }</td>
					<td>${ comment.write_time })</td>
					<td><c:if test="${ login_user.user_id eq comment.user_id }"><button onclick="delete_comment(${comment.comment_id});">삭제</button></c:if></td>
				</tr>
			</c:forEach>
	</table>
		</c:if>
	</div>

<p align="center"><a href="<%= request.getContextPath() %>/main.khs">메인으로</a></p>


<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>