<%@page import="store.StoreBean"%>
<%@page import="store.StoreDAO"%>
<%@page import="store.MygoodsBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="store.GoodsDAO"%>
<%@page import="store.MemberBean"%>
<%@page import="store.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->

<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]--> 


</head>
<body>
<div id="wrap"><jsp:include page="../inc/snsbar.jsp"/>
<jsp:include page="../inc/top.jsp"/>


<%request.setCharacterEncoding("utf-8"); %>
<%
String id=(String)session.getAttribute("id");
StoreDAO sdao = new StoreDAO();
MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.infoMember(id);
GoodsDAO gdao = new GoodsDAO();
List<Object> list = new ArrayList<Object>();
list=gdao.mygoodsList(id);
if(id==null){%>
	<script>
	alert('로그인을 해주세요');
	location.href="../member/clientLoginForm.jsp"
	</script>
	
<%}
%>
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->

<!-- 본문 들어가는 곳 -->
<nav id="sub_menu">
<ul>
<li><a href="clientInfo.jsp">회원 정보 확인</a></li>
<li><a href="clientInfoUpdate.jsp">회원 정보 수정</a></li>
<li><a href="clientInfoDeleteForm.jsp">회원 탈퇴</a></li>
<li><a href="mygoods.jsp">찜 리스트</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문 들어가는 곳 -->


<article>
<h1>찜 리스트</h1>
</article>

	<table border="1" class="center_table">
	
	
	
 	<%for(int i=0; i<list.size();i++){
 	MygoodsBean mgb = (MygoodsBean)list.get(i);
 	StoreBean sb = sdao.storeSearch(mgb.getGoods_id());
 	if(i==0||i%4==0){%>
 		<tr>
 		<%}%>
 	<td><img src="../upload/<%=mgb.getPic()%>" height="80px" width="80px"></a><br>
 	<hr>
 	상품명: <%=mgb.getProduct() %><br>
 	가격: <%=mgb.getPrice() %><br>
 	<input type = "button" value="스토어 방문" onclick="location.href='../search/storeSearchMain.jsp?storeId=<%=mgb.getGoods_id()%>&address=<%=sb.getAddress()%>'"><br>
 	<input type = "button" value="찜해제" onclick="location.href='deleteMygoods.jsp?id=<%=mgb.getId()%>&product=<%=mgb.getProduct()%>&goods_id=<%=mgb.getGoods_id()%>'">
 	
 	

	<%
	if(i%4==3){%>
	</tr>
	<%}} %> 
	
	
	<%//}%> 

	</table>


<!-- 메뉴 들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>