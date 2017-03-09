<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
 <%
 String id=(String)session.getAttribute("id");
 %>
<form action="regGoodsPro.jsp" name="fr">
<table>
<tr>
<td>상품 이름 <input type="text" name="product"></td>
</tr>
<tr>
<td>가격 <input type="text" name="price"></td>
</tr>
<tr>
<td>파일 <input type="file" name="file"></td>
</tr>
</table>
<input type="submit" value="등록">
<input type="button" value="취소" onclick="history.back()">
</form>
</body>
</html>