<%@page import="javax.websocket.SendResult"%>
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
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
String pass = request.getParameter("pass");
session.setAttribute("type", "admin");

if(id.equals("admin")&&pass.equals("admin")){
	session.setAttribute("id", id);
	session.setAttribute("pass", pass);
%>
<script>
alert('안녕하세요 운영자님!');
location.href="../main/main.jsp";
</script>
<%}else{ %>
<script>
alert('아이디나 비밀번호를 다시 확인해주세요');
history.back();
</script>
<%} %>
</body>
</html>