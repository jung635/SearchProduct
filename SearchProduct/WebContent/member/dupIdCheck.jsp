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
String id = request.getParameter("id");
MemberDAO mdao = new MemberDAO();
if(mdao.idDupCheck(id)){
%>
	<script>
	window.opener.fr.idDubOk.value="ok";
	alert('아이디 사용 가능');
	window.close();
	</script>
<%}else{
%>
	<script>
	window.opener.fr.idDubOk.value="no";
	alert('다른 아이디를 입력해주세요');
	window.close();
	</script>
<%}%>
</body>
</html>