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

<div id="wrap"><jsp:include page="../inc/snsbar.jsp"/>
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
String name = request.getParameter("name");
String file = request.getParameter("file");
if(sessionId==null){%>
<script>
alert('로그인을 해주세요');
location.href="../member/clientLoginForm.jsp"
</script>

<%}else if(sessionId.equals(name)==false){%>
<script>
alert('글쓴이가 아닙니다');
history.back();
</script>
<%}%>
<div class="text_center">
<h2>비밀번호와 아이디를 다시한번 입력해주세요</h2>
<table class="table_center" style="margin: auto;">
<form action="deletePro.jsp" method="post" name="fr" enctype="multipart/form-data" method="post">
<input type="hidden" name="num" value="<%=num %>">
<input type="hidden" name="pageNum" value="<%=pageNum %>">
<input type="hidden" name="file" value="<%=file %>">
<tr><td>아이디</td><td><input type="text" name="id" value="<%=sessionId %>" readonly></td></tr>
<tr><td>비밀번호</td><td><input type="password" name="pass"></td></tr>
<tr><td colspan="2"><input type="submit" value="글 삭제" style="float: right;"></td></tr>
</form>
</table>
</div>

<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>

</body>
</html>