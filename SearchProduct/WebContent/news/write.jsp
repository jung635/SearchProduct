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
String id=(String)session.getAttribute("id");
String pass=(String)session.getAttribute("pass");
if(id==null||id.equals("admin")==false){%>
	<script>
	alert('admin만 글을 작성할 수 있습니다.');
	location.href="../member/adminLoginForm.jsp"
	</script>
	
<%}%>
<form action="writePro.jsp" name="fr">
<input type="hidden" name="name" value="<%=id%>">
<input type="hidden" name="pass" value="<%=pass%>">
<table class="center_table">
<tr>
<td>제목 <input type="text" name="subject"></td>
</tr>
<tr>
<td>내용 <textarea name="content" cols="60" rows="15"></textarea></td>
</tr>
</table>
<div class="text_center">
<input type="submit" value="등록">
<input type="button" value="취소" onclick="history.back()">
</div>
</form>

<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>