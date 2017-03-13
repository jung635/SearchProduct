<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
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

<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 본문들어가는 곳 -->
<%
request.setCharacterEncoding("utf-8");
String sessionId=(String)session.getAttribute("id");
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = (String)request.getParameter("pageNum");
%>
<div class="text_center">
<h2>비밀번호와 아이디를 다시한번 입력해주세요</h2>
<form action="deletePro.jsp" method="post" name="fr">
<input type="hidden" name="num" value="<%=num %>">
<input type="hidden" name="pageNum" value="<%=pageNum %>">
아이디:<input type="text" name="id" value="<%=sessionId %>" readonly><br>
비밀번호 :<input type="password" name="pass"><br>
<input type="submit" value="글 삭제">
</form>
</div>

<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>

</body>
</html>