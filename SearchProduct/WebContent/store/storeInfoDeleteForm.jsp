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
String id =request.getParameter("id");
String name = request.getParameter("name");
String address = request.getParameter("address");
String email = request.getParameter("email");
String pass=(String)session.getAttribute("pass");

%>

<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../store/storeInfo.jsp">회원 정보 확인</a></li>
<li><a href="../store/storeInfoUpdate.jsp?id=<%=id%>&name=<%=name%>&address=<%=address%>&email=<%=email%>">회원 정보 수정</a></li>
<li><a href="../store/storeInfoDeleteForm.jsp?id=<%=id%>&name=<%=name%>&address=<%=address%>&email=<%=email%>">회원 탈퇴</a></li>
</ul>
</nav>


<!-- 왼쪽메뉴 -->
<h2>비밀번호와 아이디를 다시한번 입력해주세요</h2>
<form action="storeInfoDeletePro.jsp" method="post" name="fr">
아이디:<input type="text" name="id" value="<%=id %>" readonly><br>
비밀번호 :<input type="password" name="pass"><br>
<input type="submit" value="회원정보삭제">
</form>
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>