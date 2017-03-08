<%@page import="store.GoodsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="gb" class="store.GoodsBean"></jsp:useBean>
<jsp:setProperty property="*" name="gb"/>


<%
String id=(String)session.getAttribute("id");

GoodsDAO gdao = new GoodsDAO();
gdao.insertGoods(id,gb);
//response.sendRedirect("list.jsp");
%>
</body>
</html>