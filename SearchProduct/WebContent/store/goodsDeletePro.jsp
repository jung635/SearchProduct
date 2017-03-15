<%@page import="java.io.File"%>
<%@page import="store.StoreDAO"%>
<%@page import="store.GoodsDAO"%>
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
<jsp:useBean id="gb" class="store.GoodsBean"></jsp:useBean>
<jsp:setProperty property="*" name="gb"/>
<% 
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String product = request.getParameter("product");
String pic = request.getParameter("pic");
String realpath = "D:\\workspace_jsp2\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\SearchProduct\\upload\\"+pic;
File file = new File(realpath);
System.out.println(realpath);
if(file.delete()){
	System.out.println("성공");
}else{
	System.out.println("실패");
}
GoodsDAO gdao = new GoodsDAO();
StoreDAO sdao = new StoreDAO();
int check=sdao.isStoreAdmin(id,pass);
if(check==1){
	session.setAttribute("id", id);
	session.setAttribute("pass", pass);
	gdao.deleteGoods(id, product);
	response.sendRedirect("../store/goodsList.jsp");
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