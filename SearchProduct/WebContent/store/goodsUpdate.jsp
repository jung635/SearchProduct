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
String product = request.getParameter("product");
int price = Integer.parseInt(request.getParameter("price"));
%>
<div id="wrap">

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

<form action="goodsUpdatePro.jsp" name="fr" enctype="multipart/form-data" method="POST">
<input type="hidden" name="ori_product" value="<%=product%>">
<table>
<tr>
<td>상품 이름 <input type="text" name="product" value="<%=product%>"></td>
</tr>
<tr>
<td>가격 <input type="text" name="price" value="<%=price%>"></td>
</tr>
<tr>
<td>파일 <input type="file" name="file"></td>
</tr>
</table>
<input type="submit" value="수정">
<input type="button" value="삭제" onclick="location.href='recheckGoodsDelete.jsp?product=<%=product%>&price=<%=price%>'">
<input type="button" value="취소" onclick="history.back()">
</form>
<!-- 메뉴 들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>