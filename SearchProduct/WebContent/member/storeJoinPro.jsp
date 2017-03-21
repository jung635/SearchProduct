<%@page import="java.sql.Timestamp"%>
<%@page import="store.StoreDAO"%>
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
<jsp:useBean id="sb" class="store.StoreBean"></jsp:useBean>
<jsp:setProperty property="*" name="sb"/>
<% 
sb.setReg_date(new Timestamp(System.currentTimeMillis()));
StoreDAO sdao = new StoreDAO();
sdao.insertStore(sb);%>
	<script type="text/javascript">
	alert('가입 완료!');
	location.href="storeLoginForm.jsp";
	</script>
</body>
</html>