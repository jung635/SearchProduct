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
String id=(String)session.getAttribute("id");
String pass=(String)session.getAttribute("pass");
if(id==null){response.sendRedirect("storeLoginForm.jsp");
}%>
<%=id %>님이 로그인 하셨습니다!<br>
<input type="button" value="로그아웃" onclick="location.href='logout.jsp'"><br>
<a href="regGoodsForm.jsp">상품등록</a><br>
<a href="info.jsp">회원정보조회</a><br>
<a href="updateForm.jsp">회원정보수정</a><br>
<a href="deleteForm.jsp">회원정보삭제</a><br>
<a href="list.jsp">회원목록</a><br>
</body>
</html>