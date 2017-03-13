<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="store.GoodsBean"%>
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
<%request.setCharacterEncoding("utf-8"); 
String realfilePath = request.getRealPath("/upload");
int maxSize = 5*1024*1024; //5M(메가바이트)
MultipartRequest multi = new MultipartRequest(request, realfilePath, maxSize, "utf-8", new DefaultFileRenamePolicy());
String id=(String)session.getAttribute("id");
//String id = multi.getParameter("id");
//String pass = multi.getParameter("pass");
String ori_product=multi.getParameter("ori_product");
String ori_pic = multi.getParameter("ori_pic");
String pic = multi.getFilesystemName("file");
GoodsBean gb = new GoodsBean();
if(pic==null){
	gb.setPic(ori_pic);
}else{
	gb.setPic(pic);
}
gb.setId(id);
gb.setPrice(Integer.parseInt(multi.getParameter("price")));
gb.setProduct(multi.getParameter("product"));

System.out.println("사용자가 올린 원 파일 이름: "+multi.getOriginalFileName("file"));
GoodsDAO gdao = new GoodsDAO();
StoreDAO sdao = new StoreDAO();
//int check=sdao.isStoreAdmin(id,pass);
//if(check==1){
	gdao.updateGoods(gb,ori_product);
	response.sendRedirect("../store/goodsList.jsp");
//}//else if(check==-1){%>
	<script type="text/javascript">
	alert('비밀번호가 일치하지 않습니다.');
	history.back();
	</script>
<%//}else if(check==0){%>
	<script type="text/javascript">
	alert('아이디를 다시 확인해 주세요.');
	history.back();
	</script>
<%//}

%>
</body>
</html>