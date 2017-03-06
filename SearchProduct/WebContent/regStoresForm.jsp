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
 String place=request.getParameter("placeId");
 System.out.println(place);
 %>
<form action="regStoresPro.jsp" name="fr">
<table>
<tr>
<td>이름 <input type="text" name="name"></td>
</tr>
<tr>
<td>주소 <input type="text" name="address"></td>
</tr>
<tr>
<td>아이디 <input type="text" name="id"></td>
</tr>
<tr>
<td>비밀번호 <input type="text" name="pass"></td>
</tr>
<tr>
<td>id<input type="text" name="ad_id" value="<%=place%>"><input type="button" value="id 찾기" onclick='location.href="idFinder.jsp"'></td>
<!-- window.open("idFinder.jsp", "idfinder", "width=600,height=500"); -->
</tr>
</table>
<input type="submit" value="등록">
<input type="button" value="취소" onclick="history.back()">
</form>
</body>
</html>