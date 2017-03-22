<%@page import="java.util.List"%>
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
<%session.invalidate();%>
<script type="text/javascript">
alert('로그아웃 되었습니다');
location.href="../main/main.jsp";
</script>
<%
StoreDAO sdao = new StoreDAO();
List<String> allId = sdao.searchAllId();
String cookie = request.getHeader("Cookie");
	if(cookie!=null){
		Cookie[] cookies = request.getCookies(); //쿠키를 받아온다.
	 	for(int i=0; i<cookies.length;i++){	
	 		String cookieName = cookies[i].getName();
	 		for(int idnum=0; idnum<allId.size(); idnum++){
	 			if(cookieName.equals(allId.get(idnum))){
	 				cookies[i].setMaxAge(0);
	 				cookies[i].setPath("/");  
	 				response.addCookie(cookies[i]);
	 			}
	 		}	
	}
}

%>
</body>
</html>