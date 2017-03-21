<%@page import="java.io.File"%>
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
String rfp = realfilePath+'\\'+ori_pic;
//파일 업로드 안할 시 원 파일 사용
GoodsBean gb = new GoodsBean();
if(pic==null){
	gb.setPic(ori_pic);
}else{
	gb.setPic(pic);
	//원파일 삭제
	File file = new File(rfp);
	if(file.delete()){
		System.out.println("성공");
	}else{
		System.out.println("실패");
	}
}
gb.setId(id);
gb.setPrice(Integer.parseInt(multi.getParameter("price")));
gb.setProduct(multi.getParameter("product"));
GoodsDAO gdao = new GoodsDAO();
StoreDAO sdao = new StoreDAO();
gdao.updateGoods(gb,ori_product);
response.sendRedirect("../store/goodsList.jsp");
%>

</body>
</html>