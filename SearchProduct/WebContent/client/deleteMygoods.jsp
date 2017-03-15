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
<%
String id = request.getParameter("id");
String product = request.getParameter("product");
String goods_id = request.getParameter("goods_id");

GoodsDAO gdao = new GoodsDAO();
gdao.deletemyGoods(id, product, goods_id);
%>
<script>
alert("해제 되었습니다");
location.href="mygoods.jsp";
</script>
</body>
</html>