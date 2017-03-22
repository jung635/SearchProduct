<%@page import="store.BoardBean"%>
<%@page import="store.BoardDAO"%>
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
<!-- 오른쪽 슬라이더 -->
<jsp:include page="../inc/right.jsp"/>
<!-- 오른쪽 슬라이더 -->
<div id="wrap">
<jsp:include page="../inc/snsbar.jsp"/>
<jsp:include page="../inc/top.jsp"/>
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->
<!-- 본문들어가는 곳 -->
<%
String id=(String)session.getAttribute("id");
String pass=(String)session.getAttribute("pass");
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = (String)request.getParameter("pageNum");
BoardDAO bdao = new BoardDAO();
BoardBean bb=bdao.getDetail(num);
if(id==null){%>
	<script>
	alert('로그인을 해주세요');
	location.href="../member/clientLoginForm.jsp"
	</script>
<%}else if(id.equals(bb.getName())==false){%>
	<script>
	alert('글쓴이가 아닙니다');
	history.back();
	</script>
<%}%>
<form action="updatePro.jsp" name="fr"  enctype="multipart/form-data" method="post">
<input type="hidden" name="name" value="<%=id%>">
<input type="hidden" name="pass" value="<%=pass%>">
<input type="hidden" name="num" value="<%=num%>">
<input type="hidden" name="pageNum" value="<%=pageNum%>">
<input type="hidden" name="ori_file" value="<%=bb.getFile() %>">
<table class="write_table">
<tr><td>제목  </td><td><input type="text" name="subject" value="<%=bb.getSubject()%>"></td></tr>
<tr><td>내용 </td><td> <textarea name="content" cols="60" rows="15"><%=bb.getContent()%></textarea></td></tr>
<tr><td>파일  </td><td><input type="file" name="file" value="<%=bb.getFile() %>"></td>
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