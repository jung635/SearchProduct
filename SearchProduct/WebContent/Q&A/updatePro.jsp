<%@page import="store.BoardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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

<%request.setCharacterEncoding("utf-8"); 

String realfilePath = request.getRealPath("/boardPic");

int maxSize = 5*1024*1024; //5M(메가바이트)
//파일이름이 동일 할 때 파일이름을 변경 DefalutFileRenamePolicy()
MultipartRequest multi = new MultipartRequest(request, realfilePath, maxSize, "utf-8", new DefaultFileRenamePolicy());
//자바빈 생성
BoardBean bb = new BoardBean();
//set 메서드호출 폼 => 자바빈 멤버변수 저장 (수동으로 해야함)

bb.setName(multi.getParameter("name"));
bb.setPass(multi.getParameter("pass"));
bb.setSubject(multi.getParameter("subject"));
bb.setContent(multi.getParameter("content"));
//upload폴더에 올라간 파일이름
bb.setFile(multi.getFilesystemName("file"));
bb.setNum(Integer.parseInt(multi.getParameter("num")));

int pageNum = Integer.parseInt(multi.getParameter("pageNum"));
//사용자가 올린 원 파일이름

BoardDAO bdao = new BoardDAO();
bdao.updateBoard(bb);
//response.sendRedirect("list.jsp?pageNum="pageNum);
%>
 <script>
 location.href='list.jsp?pageNum=<%=pageNum%>'
 </script>
</body>
</html>