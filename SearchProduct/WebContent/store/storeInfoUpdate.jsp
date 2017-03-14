<%@page import="java.sql.Timestamp"%>
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

 <script type="text/javascript">
 function submitCheck(){
 	
 	
 	//////이름 체크
 	if(document.fr.name.value==""){
 		alert("이름을 입력해 주세요!");
 		document.fr.name.focus();
 		return false;
 	}
 	//////이메일 체크
 	if(document.fr.email.value==""){
 		alert("이메일을 입력해 주세요!");
 		document.fr.name.focus();
 		return false;
 	}
 	
 	


 }

 </script>
</head>
<body>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<!-- 본문 들어가는 곳 -->
<%request.setCharacterEncoding("utf-8");
String id =request.getParameter("id");
String name = request.getParameter("name");
String address = request.getParameter("address");
String email = request.getParameter("email");
String pass=(String)session.getAttribute("pass");

%>

<%
String sessionId=(String)session.getAttribute("id");
%>
<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../store/storeInfo.jsp">회원 정보 확인</a></li>
<li><a href="../store/storeInfoUpdate.jsp">회원 정보 수정</a></li>
<li><a href="../store/storeInfoDeleteForm.jsp">회원 탈퇴</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>InFo</h1>
<form action="recheckUpdateForm.jsp" id="join" name="fr" onsubmit="return submitCheck()">
<fieldset>
<legend>Basic Info</legend>
<label>User ID</label>
<input type="text" name="id" class="id" value=<%=sessionId %> readonly><br>
<label>Name</label>
<input type="text" name="name" value=<%=name %>><br>
<label>E-Mail</label>
<input type="email" name="email" value=<%=email %>><br>
<label>Address</label>
<input type="text" name="address" value="<%=address %>"><input type="button" value="주소 찾기" onclick='window.open("idFinder.jsp", "idfinder", "width=600,height=500");'><br>




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