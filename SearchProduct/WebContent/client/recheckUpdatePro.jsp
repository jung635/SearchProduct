<%@page import="store.MemberDAO"%>
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
<jsp:useBean id="mb" class="store.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="mb"/>
<% 
String id = request.getParameter("id");
String inputPass = request.getParameter("inputPass");
MemberDAO mdao = new MemberDAO();
int check=mdao.idCheck(id,inputPass);
if(check==1){
	mdao.updateMember(mb);
	response.sendRedirect("clientInfo.jsp");
}else if(check==-1){%>
	<script type="text/javascript">
	alert('비밀번호가 일치하지 않습니다.');
	history.back();
	</script>
<%}else if(check==0){%>
	<script type="text/javascript">
	alert('아이디를 다시 확인해 주세요.');
	history.back();
	</script>
<%}

%>
</body>
</html>