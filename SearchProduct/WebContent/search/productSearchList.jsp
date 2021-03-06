<%@page import="store.GoodsBean"%>
<%@page import="store.GoodsDAO"%>
<%@page import="java.util.ArrayList"%>
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
<!-- 오른쪽 슬라이더 -->
<jsp:include page="../inc/right.jsp"/>
<!-- 오른쪽 슬라이더 -->
<div id="wrap">
<jsp:include page="../inc/snsbar.jsp"/>
<jsp:include page="../inc/top.jsp"/>

<!-- 본문 들어가는 곳 -->
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->

<!-- 내용 -->
<%
String product = request.getParameter("product");
GoodsDAO gdao = new GoodsDAO();
StoreDAO sdao = new StoreDAO();

int count = sdao.getSearchListCount(product);
String pageNum_product = request.getParameter("pageNum_product");
if(pageNum_product==null)	pageNum_product="1";
int currentPage=Integer.parseInt(pageNum_product);
int pageSize=5;
int start=0;
int end=0;
	start = (pageSize*(currentPage-1));
	end = start+pageSize-1;
	List<?> list = null ;
	if(count!=0){
 		list = sdao.storeList(product, start, pageSize);		
	} 	
List<Object> ad_list = new ArrayList<Object>();
List<Object> name_list = new ArrayList<Object>();
%>
<!--테이블-->
	<table border="1" class="center_table">
	<th>상품 사진</th><th>상품 이름</th><th>스토어 이름</th><th>주소</th>
	<%
	try{
	for(int i=0; i<list.size(); i++){
	GoodsBean gb = (GoodsBean)list.get(i);
	StoreBean sb = sdao.storeSearch(gb.getId());
	%>
 	<tr style="position: relative;">
 		<td>
 			<a href="proDetail.jsp?storeId=<%=gb.getId()%>&product=<%=gb.getProduct()%>"><img src="../upload/<%=gb.getPic()%>" height="80px" width="80px"></a>
			
 		</td>
		<td><a href="proDetail.jsp?storeId=<%=gb.getId()%>&product=<%=gb.getProduct()%>"><%=gb.getProduct() %></a></td>
		<td><a href="storeSearchMain.jsp?&address=<%=sb.getAddress() %>&storeId=<%=sb.getId() %>" id="ad_href"><%=sb.getName() %></a></td>
		<td><%=sb.getAddress() %></td>
		<td><input type="button" value="위치보기" onclick="map('<%=sb.getAddress()%>')"></td>
		<td><input type="button" value="방문하기" onclick='location.href="storeSearchMain.jsp?&address=<%=sb.getAddress() %>&storeId=<%=sb.getId() %>"'></td>
		<td><input type = "button" value="찜하기" onclick="location.href='../search/addHot.jsp?storeId=<%=gb.getId()%>&product=<%=gb.getProduct()%>'"></td>
	</tr>
<%}}catch(Exception e){%>
<tr><td colspan="4">찾으시는 상품이 없습니다.</td></tr>
<%}%>
	</table>
	<div id="page_control">
<%
if(count!=0){
 	pageNum_product = request.getParameter("pageNum_product");
	int pageCount = count/pageSize+(count%pageSize==0?0:1);
	int pageBlock=10;
	int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
	int endPage = startPage+pageBlock-1;
	if(endPage > pageCount){
		endPage=pageCount;
	}
	if(currentPage<=10){ %>
		[이전]
	<%}else{ %>
		<a href="productSearchList.jsp?product=<%=product %>&pageNum_product=<%=startPage-pageBlock %>">[이전]</a>&nbsp;
	<%}
	for(int i=startPage; i<=endPage; i++){
		if(i==currentPage){%>
			[<%=i %>]
		<%}else{%>
			<a href="productSearchList.jsp?product=<%=product %>&pageNum_product=<%=i %>">[<%=i %>]</a>&nbsp;
	<%}}
	if(endPage<=pageCount){ %>
		[다음]
	<%}else{ %>
		<a href="productSearchList.jsp?product=<%=product %>&pageNum=<%=startPage+pageBlock %>">[다음]</a>&nbsp;
	<%}}%>
</div>
	<%
	list = sdao.storeList(product, 0, 100);
	for(int i=0; i<list.size(); i++){
		GoodsBean gb = (GoodsBean)list.get(i);
		StoreBean sb = sdao.storeSearch(gb.getId());
		ad_list.add(sb.getAddress());
		name_list.add(sb.getName());
	} %>
	<div id="map_view_wrap" class="text_center">
	<embed type="text/html" src="multiple_map.jsp?ad_list=<%=ad_list %>&name_list=<%=name_list %>" id ="map_view"  height="400px" width="500px">
	</div>
	<script>
		function map(address){
		var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() {
			    if (this.readyState == 4 && this.status == 200) {
			      document.getElementById("map_view").innerHTML = this.responseText;
			    }
			  };
		xhttp.open("GET", "single_ad_map.jsp?address="+address, true);
		xhttp.send();
		}
	</script>
<!-- 내용 -->
<!-- 본문 들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>