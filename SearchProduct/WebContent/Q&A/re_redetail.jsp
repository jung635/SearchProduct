<%@page import="java.util.List"%>
<%@page import="store.BoardDAO"%>
<%@page import="store.CommentBean"%>
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
System.out.println("되나요?");
CommentBean cb = new CommentBean();
int renum=Integer.parseInt(request.getParameter("renum"));
int board_num=Integer.parseInt(request.getParameter("board_num"));

BoardDAO bdao = new BoardDAO();
List list = bdao.getRereDetail(board_num, renum);

%>

<table>
<%
for(int i=0; i<list.size(); i++){
	cb = (CommentBean)list.get(i);
	
	System.out.println("check2: "+cb.getContent());
	%>
<tr>
<td><%=cb.getName() %></td>
<td><%=cb.getContent() %></td>
<td><%=cb.getDate() %></td>

</tr>
<%} %>
<td colspan="4"><textarea cols="60" rows="2" id="re_re_text"></textarea><input type="button" id="re_reply_content" value="댓글등록"
	onclick="re_reply()">
</table>
<div class="clear"></div>

</body>
</html>