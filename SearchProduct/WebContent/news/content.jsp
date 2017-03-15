
<%@page import="store.NewsBean"%>
<%@page import="store.NewsDAO"%>
<%@page import="store.CommentBean"%>
<%@page import="java.util.List"%>
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
String type=(String)session.getAttribute("type");
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = (String)request.getParameter("pageNum");
NewsDAO ndao = new NewsDAO();
CommentBean cb = null;
//조회수증가 readcount 1증가 update readcount=readcount+1
//메서드 호출 updateReadcount(num)
ndao.updateReadcount(num);
NewsBean nb = ndao.getDetail(num);
%>

<table border="1" id="news_table">
<tr>
<td>제목</td><td colspan="3"><%=nb.getSubject() %></td>
<td>글번호</td><td><%=nb.getNum() %></td>
</tr>
<tr>
<td style="height: 300px;">내용 </td><td colspan="5"><%=nb.getContent() %></td>
</tr>
</table>

<%
try{
if(type.equals("admin")){ %>
<div id="content_btn">
<input type="button" value="글수정" onclick="location.href='updateForm.jsp?pageNum=<%=pageNum%>&num=<%=num%>'">
<input type="button" value="글삭제" onclick="location.href='deleteForm.jsp?pageNum=<%=pageNum%>&num=<%=num%>">
<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%=pageNum%>'">
</div> 
<%}}catch(Exception e){%>

<%} %>
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>