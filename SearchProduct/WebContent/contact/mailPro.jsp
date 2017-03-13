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
String from = request.getParameter("from");
String to = request.getParameter("to");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

List<String> list = new ArrayList<String>();
list.add(from);
list.add(to);
list.add(subject);
list.add(content);
MemberDAO mdao = new MemberDAO();
//mdao.sendMail(list);

%>


</body>
</html>