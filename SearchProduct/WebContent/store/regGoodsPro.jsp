<%@page import="store.GoodsBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="store.GoodsDAO"%>
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
request.setCharacterEncoding("utf-8"); 
String id=(String)session.getAttribute("id");
String realfilePath = request.getRealPath("/upload"); 

int maxSize = 5*1024*1024; //5M(메가바이트)
MultipartRequest multi = new MultipartRequest(request, realfilePath, maxSize, "utf-8", new DefaultFileRenamePolicy());
String price = multi.getParameter("price");
GoodsBean gb = new GoodsBean();
gb.setId(multi.getParameter("id"));
gb.setPic(multi.getFilesystemName("file"));
try{
gb.setPrice(Integer.parseInt(price));
gb.setProduct(multi.getParameter("product"));

GoodsDAO gdao = new GoodsDAO();
gdao.insertGoods(id,gb);
response.sendRedirect("goodsList.jsp");
}catch(NumberFormatException e){
%>
 <script>
history.back();
</script> 
<%}%>
</body>
</html>