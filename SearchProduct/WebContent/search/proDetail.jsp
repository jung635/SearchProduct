<%@page import="java.net.URLEncoder"%>
<%@page import="store.GoodsBean"%>
<%@page import="store.GoodsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<style>
#pro_table{
margin: 50px auto 50px auto;
}
#pro_content{
text-align: center;
}
#name{
font-size: 4em;
line-height: 2;
}
#pro_detail{
text-align: center;
}
#price{
font-size: 2em;
line-height: 2;
}
#de_content{
font-size: 2em;
line-height: 2;
}
</style>
<body>
<%
String storeId=request.getParameter("storeId");
String product=request.getParameter("product");
GoodsDAO gdao = new GoodsDAO();
GoodsBean gb = gdao.searchGoods(storeId, product);
String product_co = URLEncoder.encode(product,"utf-8");
String cookieName=storeId+"/"+product_co;
Cookie sidCookie = new Cookie(cookieName, cookieName);
sidCookie.setMaxAge(60*60);
sidCookie.setPath("/");
response.addCookie(sidCookie); // 쿠키 추가  
%>
<!-- 오른쪽 슬라이더 -->
<jsp:include page="../inc/right.jsp"/>
<!-- 오른쪽 슬라이더 -->
<div id="wrap">
<jsp:include page="../inc/snsbar.jsp"/>
<jsp:include page="../inc/top.jsp"/>
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->
<!-- 본문 들어가는 곳 -->

<table id="pro_table">
<tr><td><img src="../upload/<%=gb.getPic()%>" style="max-width: 450px;"></td>
<td>
<div id="pro_detail">
<span id="name"><%=gb.getProduct()%></span><br>
<span id="price">가격:<%=gb.getPrice() %></span><br>
<span id="de_content">
<%if(gb.getContent()==null){ %>
상품 설명이 없습니다.
<%}else{ %>
설명:<%=gb.getContent() %>
<%} %>
</span><br>
<input type = "button" value="찜하기" onclick="location.href='addHot.jsp?storeId=<%=gb.getId()%>&product=<%=gb.getProduct()%>'">
</div>
</td></tr>
</table>


<div id="pro_content">
<%if(gb.getCon_file()==null){%>
<%}else{%>
<img src="../upload/<%=gb.getCon_file()%>" style="max-width: 700px;">
<%} %>
</div>

<!-- 본문 들어가는 곳 -->
<!-- 메뉴 들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>