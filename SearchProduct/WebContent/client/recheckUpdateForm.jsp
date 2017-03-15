<%@page import="store.MemberBean"%>
<%@page import="store.MemberDAO"%>
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
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="mb" class="store.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="mb"/>
<%
String id=(String)session.getAttribute("id");
String sessionPass=(String)session.getAttribute("pass");
%>
<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="clientInfo.jsp">회원 정보 확인</a></li>
<li><a href="clientInfoUpdate.jsp">회원 정보 수정</a></li>
<li><a href="clientInfoDeleteForm.jsp">회원 탈퇴</a></li>
<li><a href="mygoods.jsp">찜 리스트</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>Password Check</h1>
<form action="recheckUpdatePro.jsp" id="join">
<input type="hidden" name="name" value="<%=mb.getName()%>">
<input type="hidden" name="address" value="<%=mb.getAddress()%>">
<input type="hidden" name="postcode" value="<%=mb.getPostcode()%>">
<input type="hidden" name="email" value="<%=mb.getEmail()%>">
<input type="hidden" name="phone" value="<%=mb.getPhone()%>">
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