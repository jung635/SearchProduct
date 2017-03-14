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
<%request.setCharacterEncoding("utf-8"); %>
<jsp:include page="../inc/snsbar.jsp"/><div id="wrap">

<jsp:include page="../inc/top.jsp"/>
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->
<!-- 왼쪽메뉴 -->


<nav id="sub_menu">
<ul>
<li><a href="goodsList.jsp">상품 목록</a></li>
<li><a href="regGoodsForm.jsp">상품 등록</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문 들어가는 곳 -->
 <%
 String id=(String)session.getAttribute("id");
 %>
 
<article>
<h1>상품 등록</h1>
</article>
<form action="regGoodsPro.jsp" name="fr" enctype="multipart/form-data" method="POST">
<table class="table_center" style="margin: auto;">
<tr>
<td>상품 이름</td><td> <input type="text" name="product"></td>
</tr>
<tr>
<td>가격</td><td> <input type="text" name="price"></td>
</tr>
<tr>
<td>파일</td><td> <input type="file" name="file"></td>
</tr>
<tr><td colspan="2" >
<input type="button" value="취소" onclick="history.back()"  style="float: right;">
<input type="submit" value="등록"  style="float: right;">

</td></tr>
</table>
</form>
<!-- 메뉴 들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>