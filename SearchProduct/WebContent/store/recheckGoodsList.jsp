<%@page import="store.GoodsBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="wrap"><jsp:include page="../inc/snsbar.jsp"/>
<jsp:include page="../inc/top.jsp"/>
<%request.setCharacterEncoding("utf-8"); String realfilePath = request.getRealPath("/upload");
int maxSize = 5*1024*1024; //5M(메가바이트)
MultipartRequest multi = new MultipartRequest(request, realfilePath, maxSize, "utf-8", new DefaultFileRenamePolicy());
String id=(String)session.getAttribute("id");
String pass=(String)session.getAttribute("pass");
String ori_product=multi.getParameter("ori_product");
GoodsBean gb = new GoodsBean();
gb.setPic(multi.getFilesystemName("file"));
gb.setPrice(Integer.parseInt(multi.getParameter("price")));
gb.setProduct(multi.getParameter("product"));
%>
<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>Password Check</h1>
<form action="goodsUpdatePro.jsp" id="join"  enctype="multipart/form-data" method="POST">
<input type="hidden" name="product" value="<%=gb.getProduct()%>">
<input type="hidden" name="price" value="<%=gb.getPrice()%>">
<input type="hidden" name="ori_product" value="<%=ori_product%>">
<div style="display: none;"><input type="file" name="file" value="<%=gb.getPic()%>"></div>
<fieldset>
	<legend>Login Info</legend>
	<label>User ID</label>
	<input type="text" name="id" value=<%=id %> readonly><br>
	<label>Password</label>
	<input type="password" name="pass"><br>
</fieldset>

<div class="clear"></div>
<div id="buttons">
<input type="submit" value="Submit" class="submit">
<input type="button" value="Cancel" class="cancel">
</div>
</form>
</article>

<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>