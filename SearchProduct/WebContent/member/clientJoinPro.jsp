<%@page import="java.sql.Timestamp"%>
<%@page import="store.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="mb" class="store.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="mb"/>
<% 
MemberDAO mdao = new MemberDAO();
mb.setReg_date(new Timestamp(System.currentTimeMillis()));
mdao.insertMember(mb);%>
<script type="text/javascript">
alert('가입 완료!');
location.href="clientLoginForm.jsp";
</script>
</body>
</html>