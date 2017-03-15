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
request.setCharacterEncoding("utf-8"); 
String id=(String)session.getAttribute("id");
String product = request.getParameter("product");
String storeId = request.getParameter("storeId");
if(id==null){%>
<script>
	alert('로그인을 해주세요');
	location.href="../member/clientLoginForm.jsp";
	</script>
<%}else{
GoodsDAO gdao = new GoodsDAO();
gdao.updateGoodsHot(storeId, product, id);

%>
<script>
alert('찜목록에 추가되었습니다!');
history.back();
<%}%>
</script>
</body>
</html>