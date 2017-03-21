<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="store.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); 
String email = request.getParameter("email");
String authNum = request.getParameter("authNum");
String content="인증번호는"+authNum+"입니다.";
MemberDAO mdao = new MemberDAO();
boolean check = mdao.sendMail(email,content);
if(check){
%>
	<script>
	alert('메일발송하였습니다!');
	window.close();
	</script>
<%}else{ %>
	<script>
	alert('메일발송을 실패하였습니다.');
	window.close();
	</script>
<%}%>
</body>
</html>