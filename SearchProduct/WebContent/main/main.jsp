<%@page import="store.StoreBean"%>
<%@page import="store.StoreDAO"%>
<%@page import="store.GoodsBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="store.GoodsDAO"%>
<%@page import="store.NewsBean"%>
<%@page import="store.NewsDAO"%>
<%@page import="store.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="store.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">


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
<style>
.main_title {
	text-align: center;
	margin-bottom: 30px;
	background-color: #ff7428;
	overflow: initial;
	height: 64px;
	line-height: 65px;
	max-width: 952px;
	margin: 0 auto;
}
</style>
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
<div id="wrap">
<jsp:include page="../inc/snsbar.jsp"/>
<jsp:include page="../inc/top.jsp"/>
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img"><img src="../images/map.png" width="971" height="282"></div>
<div id="search">
<form action="../search/productSearchList.jsp" name="fr">
<input type="text" placeholder="무엇을 찾으시나요" name="product">
<input type="submit" value="search" >
</form>
</div>
<!-- 메인이미지 들어가는곳 -->
<!-- 광고슬라이더 -->
<div class="main_title"><span style="font-size: 2em;">오늘의 상품|</span><span>오늘의 행사제품입니다</span></div>
<div class="slideshow-container">
	<div class="mySlides fade">
 	 <div class="numbertext"></div>
 	 <img src="../images/main_img.jpg" style="width:100%;">
	</div>

	<div class="mySlides fade">
 	 <div class="numbertext"></div>
 	 <img src="../images/main_img1.jpg" style="width:100%">
	</div>

	<div class="mySlides fade">
 	 <div class="numbertext"></div>
 	 <img src="../images/main_img2.jpg" style="width:100%">
	</div>
</div>
<br>

<div style="text-align:center; margin-bottom: 48px;">
  <span class="dot"></span> 
  <span class="dot"></span> 
  <span class="dot"></span> 
</div>
<script>
var slideIndex = 0;
showSlides();

function showSlides() {
    var i;
    var slides = document.getElementsByClassName("mySlides");
    var dots = document.getElementsByClassName("dot");
    for (i = 0; i < slides.length; i++) {
       slides[i].style.display = "none";  
    }
    slideIndex++;
    if (slideIndex> slides.length) {slideIndex = 1}    
    for (i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active", "");
    }
    slides[slideIndex-1].style.display = "block";  
    dots[slideIndex-1].className += " active";
    setTimeout(showSlides, 2000); // Change image every 2 seconds
}
</script>
<!-- 광고슬라이더 -->

<!-- 인기상품 -->
<div class="main_title" style="background-color: #ff2828; margin-bottom: 30px;"><span style="font-size: 2em;">인기상품|</span><span>이번달 인기 상품입니다</span></div>
<%
GoodsDAO gdao = new GoodsDAO();
StoreDAO sdao = new StoreDAO();
List<Object> goodslist = new ArrayList<Object>();
goodslist=gdao.hotgoodsList();%>
<div class="clear"></div>
<div style="margin-bottom: 45px;">
	<table id="hot_table">
	<tr><th>Rank</th><th>상품사진</th><th>상품이름</th><th>가격</th><th>스토어 이름</th><th>주소</th></tr>
 	<%for(int i=0; i<goodslist.size();i++){
 	GoodsBean gb = (GoodsBean)goodslist.get(i);
 	StoreBean sb = sdao.storeSearch(gb.getId());
 	%>
 	<tr style="position: relative;">
 		<td><%=i+1 %></td>
 		<td>
 			<a href="../search/proDetail.jsp?storeId=<%=gb.getId()%>&product=<%=gb.getProduct()%>"><img src="../upload/<%=gb.getPic()%>" height="80px" width="80px" onmouseover="imageOn('../upload/<%=gb.getPic()%>', <%=i%>)" onmouseout="imageOut(<%=i%>)"></a>
			<div id="up<%=i %>" style="position:absolute; max-width:300px; left:35%;display:none; z-index: 50;">
			<img id="upImg<%=i %>" src="" width="100%" height="100%" style="max-width: 300px;z-index: 100;"/>
			</div>
 		</td>
 		<td><a href="../search/proDetail.jsp?storeId=<%=gb.getId()%>&product=<%=gb.getProduct()%>"><%=gb.getProduct() %></a></td>
 		<td> <%=gb.getPrice() %></td>
 		<td> <%=sb.getName()%></td>
 		<td> <%=sb.getAddress()%></td>
 		<td style="text-align: right">
 		<input type = "button" value="스토어 방문" onclick="location.href='../search/storeSearchMain.jsp?storeId=<%=gb.getId()%>&address=<%=sb.getAddress()%>'">
 		<input type = "button" value="찜하기" onclick="location.href='../search/addHot.jsp?storeId=<%=gb.getId()%>&product=<%=gb.getProduct()%>'"></td>
 		</tr>
	<%}%>
	</table>
	</div>
<div class="clear"></div>
<!-- 인기상품 -->

<!-- 메인 콘텐츠 들어가는 곳 -->
<!-- <article id="front">
<div id="solution">
<div id="hosting">
<h3>Web Hosting Solution</h3>
<p>Lorem impsun Lorem impsunLorem impsunLorem
 impsunLorem impsunLorem impsunLorem impsunLorem
  impsunLorem impsunLorem impsun....</p>
</div>
<div id="security">
<h3>Web Security Solution</h3>
<p>Lorem impsun Lorem impsunLorem impsunLorem
 impsunLorem impsunLorem impsunLorem impsunLorem
  impsunLorem impsunLorem impsun....</p>
</div>
<div id="payment">
<h3>Web Payment Solution</h3>
<p>Lorem impsun Lorem impsunLorem impsunLorem
 impsunLorem impsunLorem impsunLorem impsunLorem
  impsunLorem impsunLorem impsun....</p>
</div>
</div> -->
<div class="clear"></div>
<div id="sec_news">
<h3 class="orange">News</h3>
<table>
<!-- 메인 콘텐츠 들어가는 곳 -->
<!-- 게시판 들어가는 곳 -->
<%
NewsDAO ndao = new NewsDAO();
int newsCount = ndao.getListCount();
List<?> news_list = ndao.boardList(0, 5);
%>
   <%if(news_list.size()==0){%>
   글이 없습니다
   <%}
for(int i=0; i<news_list.size(); i++){
	NewsBean bb = (NewsBean)news_list.get(i);
%>
<tr>
<td><a href="../news/content.jsp?num=<%=bb.getNum()%>&pageNum=<%=1%>"><%=bb.getSubject() %></a></td>
<td><%=bb.getName() %></td><td><%=bb.getDate() %></td><td><%=bb.getReadcount() %></td>
</tr>
<%} %>  
</table>
</div>
<div id="news_notice">
<h3 class="brown">Board</h3>
<table>
<%
BoardDAO bdao = new BoardDAO();
int count = bdao.getListCount();
List<?> list = bdao.boardList(0, 5);
for(int i=0; i<list.size(); i++){
	BoardBean bb = (BoardBean)list.get(i);
%>
	<tr>
		<td><a href="../Q&A/content.jsp?num=<%=bb.getNum()%>&pageNum=<%=1%>"><%=bb.getSubject() %></a></td>
		<td><%=bb.getName() %></td><td><%=bb.getDate() %></td><td><%=bb.getReadcount() %></td>
	</tr>
<%}%>  
</table>
</div>
</article>
<!-- 게시판 들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>