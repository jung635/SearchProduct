DAO"%>
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
<jsp:useBean id="cb" class="store.CommentBean"></jsp:useBean>
<jsp:setProperty property="*" name="cb"/>

<%request.setCharacterEncoding("utf-8");
int re_lev = Integer.parseInt(request.getParameter("re_lev"));
int re_seq = Integer.parseInt(request.getParameter("re_seq"));
int re_ref = Integer.parseInt(request.getParameter("re_ref"));
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = (String)request.getParameter("pageNum");
System.out.println("check");
%>


<%
cb.setIp(request.getRemoteAddr());
cb.setRe_lev(re_lev);
cb.setRe_seq(re_seq);
cb.setRe_ref(re_ref);
BoardDAO bdao = new BoardDAO();
bdao.insertreBoard(cb);
%>
<script>
location.href="content.jsp?num=<%=num%>&pageNum=<%=pageNum %>";
</script>
</body>
</html>