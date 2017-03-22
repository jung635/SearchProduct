<%@page import="store.GoodsBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="store.GoodsDAO"%>
<%@page import="store.StoreBean"%>
<%@page import="store.StoreDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->

<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]--> 


</head>
<body>

<%request.setCharacterEncoding("utf-8");
String address=request.getParameter("address");
String storeId=request.getParameter("storeId");
GoodsDAO gdao = new GoodsDAO();
List<Object> list = new ArrayList<Object>();
list=gdao.goodsList(storeId);%>


<!-- 본문 들어가는 곳 -->
<article>
<h1>상품 목록</h1>
</article>
	<table border="1" class="center_table">
 	<%for(int i=0; i<list.size();i++){
 	GoodsBean gb = (GoodsBean)list.get(i);
 	if(i==0||i%4==0){%>
 	<tr>
 	<%}%>
 	<td><img src="../upload/<%=gb.getPic()%>" height="80px" width="80px"></a><br>
 	<hr>
 	상품명: <%=gb.getProduct() %><br>
 	가격: <%=gb.getPrice() %><br>
 	<input type = "button" value="찜하기" onclick="location.href='addHot.jsp?storeId=<%=storeId%>&product=<%=gb.getProduct()%>'"></td>
	<%if(i%4==3){%>
	</tr>
	<%}}%> 
	</table>
<!-- 본문 들어가는 곳 -->
</body>
</html>