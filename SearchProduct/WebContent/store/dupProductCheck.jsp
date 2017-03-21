<%@page import="store.GoodsBean"%>
<%@page import="store.GoodsDAO"%>
<%@page import="store.StoreDAO"%>
<%@page import="store.StoreBean"%>
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
String product = request.getParameter("product");
GoodsDAO gdao = new GoodsDAO();
Boolean check = gdao.isSearchGoods(id, product);
if(check==true){
%>
	<script>
	window.opener.fr.dubOk.value="no";
	alert('다른 이름을 입력해주세요');
	window.close();
	</script>

<%}else{%>
	<script>
	window.opener.fr.dubOk.value="ok";
	alert('이름 사용 가능');
	window.close();
	</script>

<%}%>
</body>
</html>