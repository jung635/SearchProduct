<%@page import="store.NewsDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
<jsp:useBean id="nb" class="store.NewsBean"></jsp:useBean>
<jsp:setProperty property="*" name="nb"/>
<%request.setCharacterEncoding("utf-8"); 
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = (String)request.getParameter("pageNum");
NewsDAO ndao = new NewsDAO();
ndao.updateBoard(nb);
%>
<script>
alert('글이 수정되었습니다.');
location.href="content.jsp?pageNum=<%=pageNum%>&num=<%=num%>";
</script>
</body>
</html>