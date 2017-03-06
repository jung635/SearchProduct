
<%@page import="java.util.List"%>
<%@page import="store.BoardBean"%>
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
<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = (String)request.getParameter("pageNum");
BoardDAO bdao = new BoardDAO();
//조회수증가 readcount 1증가 update readcount=readcount+1
//메서드 호출 updateReadcount(num)
bdao.updateReadcount(num);
BoardBean bb = bdao.getDetail(num);
%>
<h1>글 내용 보기</h1>
<table border="1">
<tr>
<td>글번호</td><td><%=bb.getNum() %></td>
</tr>
<tr>
<td>이름</td><td><%=bb.getName() %></td>
</tr>
<tr>
<td>제목</td><td colspan="3"><%=bb.getSubject() %></td>
</tr>
<tr>
<td>내용 </td><td colspan="3"><%=bb.getContent() %></td>
</tr>
<tr>
<td>첨부파일 </td><td colspan="3"><%
if(bb.getFile()==null){
%>
첨부파일 없음
<%}else{ %>
<a href="../upload/<%=bb.getFile() %>" >
<%=bb.getFile() %></a></td>
</tr>
<%} %>
</table>

<%List relist=bdao.getReDetail(num); %>
<h1>댓글 내용 보기</h1>
	<table border="1">
	<%for(int i=0; i<relist.size(); i++){
	BoardBean bb2 = (BoardBean)relist.get(i);
	%>
	<tr>
	<td>댓글번호</td><td><%=bb2.getRe_seq() %></td><td>이름</td><td><%=bb2.getName() %></td>
	</tr>
	<tr>
	<td>내용 </td><td colspan="3"><%=bb2.getContent() %></td>
	<td><input type="button" value="댓글달기"></td>
	</tr>
<%} %>
	</table>


<form action="rewritePro.jsp">
<input type="hidden" name="re_lev" value="<%=bb.getRe_lev() %>">
<input type="hidden" name="re_seq" value="<%=bb.getRe_seq()%>">
<input type="hidden" name="re_ref" value="<%=bb.getRe_ref()%>">
<table>
<tr>
<td>이름 <input type="text" name="name">비밀번호 <input type="text" name="pass"></td>
</tr>
<tr>
<td>내용 <textarea name="content" cols="60" rows="10"></textarea>
<input type="submit" value="등록"></td>
</tr>
</table>
</form>


<input type="button" value="글수정" onclick="location.href='updateForm.jsp?pageNum=<%=pageNum%>&num=<%=num%>'">
<input type="button" value="글삭제" onclick="location.href='deleteForm.jsp?pageNum=<%=pageNum%>&num=<%=num%>'">
<input type="button" value="답글쓰기" onclick="location.href='rewriteForm.jsp?pageNum=<%=pageNum%>&num=<%=num%>&re_lev=<%=bb.getRe_lev()%>&re_seq=<%=bb.getRe_seq()%>&re_ref=<%=bb.getRe_ref()%>'">
<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%=pageNum%>'">
</body>
</html>