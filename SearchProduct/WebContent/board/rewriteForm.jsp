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
int re_ref = Integer.parseInt(request.getParameter("re_ref"));
int re_lev = Integer.parseInt(request.getParameter("re_lev"));
int re_seq = Integer.parseInt(request.getParameter("re_seq"));
%>
<form action="rewritePro.jsp" name="fr">
<input type="hidden" name="num" value="<%=num%>">
<input type="hidden" name="pageNum" value="<%=pageNum %>">
<input type="hidden" name="re_lev" value="<%=re_lev %>">
<input type="hidden" name="re_seq" value="<%=re_seq %>">
<input type="hidden" name="re_ref" value="<%=re_ref %>">
<table>
<tr>
<td>이름 <input type="text" name="name"></td>
</tr>
<tr>
<td>비밀번호 <input type="text" name="pass"></td>
</tr>
<tr>
<td>제목 <input type="text" name="subject" value="[답글]"></td>
</tr>
<tr>
<td>내용 <textarea name="content" cols="60" rows="15"></textarea></td>
</tr>
</table>

<input type="submit" value="등록">
<input type="button" value="취소" onclick="history.back()">
</form>
</body>
</html>