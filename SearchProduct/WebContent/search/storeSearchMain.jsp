<%@page import="store.StoreDAO"%>
<%@page import="store.StoreBean"%>
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
		function gallery(storeId,address){
		var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() {
			    if (this.readyState == 4 && this.status == 200) {
			      document.getElementById("map_view").innerHTML = this.responseText;
			    }
			  };
		xhttp.open("GET", "goodsGallery.jsp?storeId="+storeId+"&address="+address, true);
		xhttp.send();
		}
	
	
	
	</script>

</head>
<body>
<%
String address=request.getParameter("address");
String storeId=request.getParameter("storeId");
Cookie sidCookie = new Cookie(storeId, storeId);
sidCookie.setMaxAge(60*60);
sidCookie.setPath("/");
response.addCookie(sidCookie); // 쿠키 추가
StoreDAO sdao = new StoreDAO();

if(address==""){%>
<script>
alert('주소가 존재하지 않는 스토어 입니다');
history.back();
</script>
<%}else{
%>
<div id="wrap"><jsp:include page="../inc/snsbar.jsp"/>
<jsp:include page="../inc/top.jsp"/>
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->
<nav id="sub_menu">
<ul>
<li><a href="#" onclick="map('<%=address%>')">위치보기</a></li>
<li><a href="#" onclick="gallery('<%=storeId%>','<%=address%>')">물품 목록 보기</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 메뉴 들어가는 곳 -->


<div class="text_center">


</div>
<div id="map_view" class="text_center" >
	<embed type="text/html" src="single_ad_map.jsp?address=<%=address %>" id ="map_view"  style="margin:0;" height="400px" width="500px">
	</div>
<%}%>
<!-- 메뉴 들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>