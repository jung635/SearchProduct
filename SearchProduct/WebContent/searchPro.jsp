<%@page import="store.StoreBean"%>
<%@page import="java.util.List"%>
<%@page import="store.StoreDAO"%>
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
String product = request.getParameter("product");
StoreDAO sdao = new StoreDAO();
List list = sdao.StoreList(product);
%>
	<table border="1">
	<th>스토어 이름</th><th>주소</th><th>주소 아이디</th>
	<%for(int i=0; i<list.size(); i++){
	StoreBean sb = (StoreBean)list.get(i);
	%>
	
	<tr><td><a href="mapId.jsp?ad_id=<%=sb.getAd_id() %>"><%=sb.getName() %></a></td>
	<td><%=sb.getAddress() %></td>
	<td><%=sb.getAd_id()%></td>
	</tr>
<%} %>
	</table>
</body>
</html>