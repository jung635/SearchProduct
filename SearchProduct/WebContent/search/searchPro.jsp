<%@page import="store.StoreDAO"%>
<%@page import="java.util.List"%>
<%@page import="store.StoreBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
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
<title>Insert title here</title>

</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>

<!-- 본문 들어가는 곳 -->
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->

<!-- 내용 -->
<%
String product = request.getParameter("product");
StoreDAO sdao = new StoreDAO();
List list = sdao.storeList(product);

%>
<!--테이블-->


	<table border="1" class="center_table">
	<th>스토어 이름</th><th>주소</th><th>주소 아이디</th>
	<%for(int i=0; i<list.size(); i++){
	StoreBean sb = (StoreBean)list.get(i);
	%>
	<tr><td><a href="#" onclick='location.href="map.jsp?ad_id=<%=sb.getAd_id() %>&address=<%=sb.getAddress() %>"' id="ad_href"><%=sb.getName() %></a>
	</td>
	<td><%=sb.getAddress() %></td>
	<td><%=sb.getAd_id()%></td>
	</tr>

<%} %>
	</table>


<!-- 내용 -->
<!-- 본문 들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>