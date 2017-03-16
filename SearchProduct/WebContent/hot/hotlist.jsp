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
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

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
String sessionId=(String)session.getAttribute("id");
StoreDAO sdao = new StoreDAO();

GoodsDAO gdao = new GoodsDAO();
List<Object> list = new ArrayList<Object>();
list=gdao.hotgoodsList();
%>
<div id="wrap"><jsp:include page="../inc/snsbar.jsp"/>
<jsp:include page="../inc/top.jsp"/>
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->

<!-- 본문 들어가는 곳 -->
<div class="text_center">
<article style="float: none; width: 100%;">
<h1>인기상품</h1>
</article>
</div>
<div class="clear"></div>
<div id="hot_list">
	<table id="hot_table">
	 		<tr><th>상품사진</th><th>상품이름</th><th>가격</th><th>스토어 주소</th></tr>
 	<%for(int i=0; i<list.size();i++){
 	GoodsBean gb = (GoodsBean)list.get(i);
 	StoreBean sb = sdao.storeSearch(gb.getId());
 	%>

 		<tr>
 		<td><img src="../upload/<%=gb.getPic()%>" height="80px" width="80px"></td>
 		<td><%=gb.getProduct() %></td>
 		<td> <%=gb.getPrice() %></td>
 		<td> <%=sb.getAddress()%></td>
 		<td style="text-align: right">
 		 <input type = "button" value="스토어 방문" onclick="location.href='../search/storeSearchMain.jsp?storeId=<%=gb.getId()%>&address=<%=sb.getAddress()%>'">
 		<input type = "button" value="찜하기" onclick="location.href='../search/addHot.jsp?storeId=<%=gb.getId()%>&product=<%=gb.getProduct()%>'"></td>
 		</tr>


	
	
	<%}%> 
 


	</table>
	</div>
<!-- 본문 들어가는 곳 -->

<!-- 메뉴 들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>