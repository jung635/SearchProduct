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


</head>
<body>
<div id="wrap"><jsp:include page="../inc/snsbar.jsp"/>
<jsp:include page="../inc/top.jsp"/>
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->
<!-- 왼쪽메뉴 -->
<%request.setCharacterEncoding("utf-8"); %>
<%
String id = (String)session.getAttribute("id");
StoreDAO sdao = new StoreDAO();
StoreBean sb = sdao.infoStore(id);



%>
<nav id="sub_menu">
<ul>
<li><a href="storeInfo.jsp">회원 정보 확인</a></li>
<li><a href="storeInfoUpdate.jsp?id=<%=id%>&name=<%=sb.getName()%>&address=<%=sb.getAddress()%>&email=<%=sb.getEmail()%>">회원 정보 수정</a></li>
<li><a href="storeInfoDeleteForm.jsp?id=<%=id%>&name=<%=sb.getName()%>&address=<%=sb.getAddress()%>&email=<%=sb.getEmail()%>">회원 탈퇴</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문 들어가는 곳 -->



<div class="text_center">
<article>
<h1>회원 정보</h1>
</article>
<table border="1" class="center_table">
<tr><td>아이디</td><td><%=id%></td></tr>
<tr><td>비밀번호</td><td><%=sb.getPass()%></td></tr>
<tr><td>이름</td><td><%=sb.getName()%></td></tr>
<tr><td>가입 날짜</td><td><%=sb.getReg_date()%></td></tr>
<tr><td>주소</td><td><%=sb.getAddress()%></td></tr>
<tr><td>email</td><td><%=sb.getEmail()%></td></tr>
</table>
</div>

<!-- 메뉴 들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>