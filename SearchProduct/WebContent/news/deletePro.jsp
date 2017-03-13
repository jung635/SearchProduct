<%@page import="store.NewsDAO"%>
<%@page import="store.BoardDAO"%>
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
<%request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
String pass = request.getParameter("pass");
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = (String)request.getParameter("pageNum");
NewsDAO ndao = new NewsDAO();
if(pass.equals("admin")){
	ndao.deleteBoard(num);%>
	 <script>
 location.href='list.jsp?pageNum=<%=pageNum%>'
 </script>
<%}else{%>
	<script type="text/javascript">
	alert('아이디 혹은 비밀번호를 다시 확인해 주세요.');
	history.back();
	</script>
<%}

%>

</body>
</html>