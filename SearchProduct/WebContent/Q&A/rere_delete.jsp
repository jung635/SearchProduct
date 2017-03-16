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
String sessionId=(String)session.getAttribute("id");
int board_num=Integer.parseInt(request.getParameter("board_num"));
int renum=Integer.parseInt(request.getParameter("renum"));
int re_seq=Integer.parseInt(request.getParameter("re_seq"));
int num = board_num;
String pageNum = (String)request.getParameter("pageNum");
String name = request.getParameter("name");
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
<%}else{

BoardDAO bdao = new BoardDAO();
bdao.deleterereBoard(board_num, renum,re_seq);
%>
<script>
alert('삭제되었습니다');
location.href="content.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
</script>
<%} %>
</body>
</html>