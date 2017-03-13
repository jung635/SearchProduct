<%@page import="store.CommentBean"%>
<%@page import="store.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%request.setCharacterEncoding("utf-8");
int num = Integer.parseInt(request.getParameter("num"));

String pageNum = (String)request.getParameter("pageNum");
String id=(String)session.getAttribute("id");
String pass=(String)session.getAttribute("pass");
CommentBean cb = new CommentBean();
cb.setRe_lev(Integer.parseInt(request.getParameter("re_lev")));
cb.setRe_seq(Integer.parseInt(request.getParameter("re_seq")));
cb.setContent(request.getParameter("content"));
cb.setRe_ref(num);
cb.setName(id);
cb.setPass(pass);
if(id==null){%>
	<script>
	alert('로그인을 해주세요');
	location.href="../member/clientLoginForm.jsp"
	</script>
	
<%}else{
BoardDAO bdao = new BoardDAO();
bdao.insertrereBoard(cb);
%>
<script>
location.href="content.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
</script>
<%}%>
</body>
</html>