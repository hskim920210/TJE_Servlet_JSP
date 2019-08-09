<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>

<form action="<%= request.getContextPath() %>/regist.do" method="post">
	<table>
		<caption>회원가입</caption>
		<tr>
			<th>ID</th>
			<td><input type="text" name="id" required></td>
		</tr>
		<tr>
			<th>PW</th>
			<td><input type="password" name="password" required></td>
		</tr>
		<tr>
			<th>NAME</th>
			<td><input type="text" name="name" required></td>
		</tr>
		<tr>
			<th>AGE</th>
			<td><input type="text" name="age"></td>
		</tr>
		<tr>
			<th>TEL</th>
			<td><input type="text" name="tel"></td>
		</tr>
		<tr>
			<th>ADDRESS</th>	
			<td><input type="text" name="address"></td>		
		</tr>		
		<tr>
			<th colspan="2"><input type="submit" value="가입"></th>
		</tr>
	</table>
</form>

</body>
</html>