<%@page import="store.GoodsBean"%>
<%@page import="store.GoodsDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLDecoder"%>
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
GoodsDAO gdao = new GoodsDAO();
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
String cookie_pro = request.getHeader("Cookie");
	if(cookie_pro!=null){
		Cookie[] cookies = request.getCookies(); //쿠키를 받아온다.
	 	for(int i=0; i<cookies.length;i++){	
	 		String cookieName = URLDecoder.decode(cookies[i].getName());//쿠키이름
			List<String> allPro_list = new ArrayList<String>();
			for(int idnum=0; idnum<allId.size(); idnum++){
			List<Object> goods_list=gdao.goodsList(allId.get(idnum));//해당 아이디 상품목록
 			for(int j=0; j<goods_list.size(); j++){
 				//System.out.println(allId.get(idnum));
 				GoodsBean allPro = (GoodsBean)goods_list.get(j);
 				allPro_list.add(allPro.getProduct());//상품 목록 리스트화
 				//System.out.println(allPro.getProduct());
 			}//end for j
 			for(int pronum=0; pronum<allPro_list.size(); pronum++){
 	 			String idPro=allId.get(idnum)+"/"+allPro_list.get(pronum);
 	 			//System.out.println(idPro);
 	 			if(cookieName.equals(idPro)){
 	 				cookies[i].setMaxAge(0);
 	 				cookies[i].setPath("/");  
	 				response.addCookie(cookies[i]);
 	 			}//end if equuals
			}//end for idnum
		}//end jor j(goods_list)
	}//end for cookies length
}//endfor if cookie

%>
</body>
</html>