<%@page import="java.util.List"%>
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
String id=(String)session.getAttribute("id");
String pass=(String)session.getAttribute("pass");
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = (String)request.getParameter("pageNum");
CommentBean cb = new CommentBean();
cb.setRe_seq(Integer.parseInt(request.getParameter("re_seq")));
cb.setRenum(Integer.parseInt(request.getParameter("renum")));
cb.setBoard_num(num);
cb.setContent(request.getParameter("content"));
cb.setName(id);
cb.setPass(pass);
BoardDAO bdao = new BoardDAO();
bdao.insertRereBoard(cb);
List list = bdao.getRereDetail(num, cb.getRenum());


%>
<table id="rere">
<%
for(int i=0; i<list.size(); i++){
	cb = (CommentBean)list.get(i);
	
	%>
<tr>
<td style="width: 200px;"><%=cb.getName() %></td>
<td style="width: 200px;"><%=cb.getContent() %></td>
<td style="width: 200px;"><%=cb.getDate() %>
<input type="button" id="re_delete_btn" value="X" onclick="location.href='rere_delete.jsp?board_num=<%=cb.getBoard_num()%>&renum=<%=cb.getRenum()%>&name=<%=cb.getName()%>&pageNum=<%= pageNum %>&re_seq=<%= cb.getRe_seq() %>'">

</td>

</tr>
<%} %>

</table>
<div class="clear"></div>


</body>
</html>