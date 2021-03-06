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

<script>
function imageOn(path, count){
		var divform = document.getElementById("up"+count);
		divform.style.display = '';
		document.getElementById("upImg"+count).src = path;
	}
	function imageOut(count){
		var divform = document.getElementById("up"+count);
		divform.style.display = 'none';
	}
</script>
</head>
<body>
<!-- 오른쪽 슬라이더 -->
<jsp:include page="../inc/right.jsp"/>
<!-- 오른쪽 슬라이더 -->
<%request.setCharacterEncoding("utf-8"); 
String sessionId=(String)session.getAttribute("id");

StoreDAO sdao = new StoreDAO();
GoodsDAO gdao = new GoodsDAO();
List<Object> list = new ArrayList<Object>();
list=gdao.hotgoodsList();
%>
<div id="wrap">
<jsp:include page="../inc/snsbar.jsp"/>
<jsp:include page="../inc/top.jsp"/>

<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->

<!-- 본문 들어가는 곳 -->
<!-- 본문내용 -->
<div class="text_center">
<article style="float: none; width: 100%;">
<h1>인기상품</h1>
</article>
*사진 위에 마우스를 올리시면 크게 볼 수 있습니다.
</div>
<div class="clear"></div>
<div style="margin-top: 50px;">
	<table id="hot_table" style="width:80%">
	<tr><th>Rank</th><th>상품사진</th><th>상품이름</th><th>가격</th><th>스토어 이름</th><th>주소</th></tr>
 	<%for(int i=0; i<list.size();i++){
 	GoodsBean gb = (GoodsBean)list.get(i);
 	StoreBean sb = sdao.storeSearch(gb.getId());
 	%>
 	<tr style="position: relative;">
 	<td><%=i+1 %></td>
 	<td>
 	<a href="../search/proDetail.jsp?storeId=<%=gb.getId()%>&product=<%=gb.getProduct()%>"><img src="../upload/<%=gb.getPic()%>" height="80px" width="80px" onmouseover="imageOn('../upload/<%=gb.getPic()%>', <%=i%>)" onmouseout="imageOut(<%=i%>)"></a>
 	<div id="up<%=i %>" style="position:absolute; max-width:300px; left:36%; display:none; z-index: 50;">
	<img id="upImg<%=i %>" src="" width="100%" height="100%" style="max-width: 300px;z-index: 100;"/></div>
	</td>
	<td><a href="../search/proDetail.jsp?storeId=<%=gb.getId()%>&product=<%=gb.getProduct()%>"><%=gb.getProduct() %></a></td>
 	<td> <%=gb.getPrice() %></td>
 	<td> <%=sb.getName()%></td>
 	<td> <%=sb.getAddress()%></td>
 	<td style="text-align: right">
 	<input type = "button" value="스토어 방문" onclick="location.href='../search/storeSearchMain.jsp?storeId=<%=gb.getId()%>&address=<%=sb.getAddress()%>'">
 	<input type = "button" value="찜하기" onclick="location.href='../search/addHot.jsp?storeId=<%=gb.getId()%>&product=<%=gb.getProduct()%>'">
 	</td>
 	</tr>
	<%}%> 
	</table>
</div>
<!-- 본문내용 -->
<!-- 본문 들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>