<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="writePro.jsp" name="fr">
<table>
<tr>
<td>이름 <input type="text" name="name"></td>
</tr>
<tr>
<td>비밀번호 <input type="text" name="pass"></td>
</tr>
<tr>
<td>제목 <input type="text" name="subject"></td>
</tr>
<tr>
<td>내용 <textarea name="content" cols="60" rows="15"></textarea></td>
</tr>
</table>

<input type="submit" value="등록">
<input type="button" value="취소" onclick="history.back()">
</form>
</body>
</html>