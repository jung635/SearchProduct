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
MemberDAO mdao = new MemberDAO();
int check=mdao.idCheck(id,pass);
if(check==1){
	session.setAttribute("id", id);
	session.setAttribute("pass", pass);
	response.sendRedirect("../main/main.jsp");
}else if(check==-1){%>
	<script type="text/javascript">
	alert('아이디를 다시 확인해 주세요.');
	history.back();
	</script>
<%}else if(check==0){%>
	<script type="text/javascript">
	alert('비밀번호를 다시 확인해 주세요.');
	history.back();
	</script>
<%}

%>

</body>
</html>