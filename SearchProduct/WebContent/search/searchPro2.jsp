<%@page import="java.util.ArrayList"%>
<%@page import="store.StoreDAO"%>
<%@page import="java.util.List"%>
<%@page import="store.StoreBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
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
<title>Insert title here</title>

</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>

<!-- 본문 들어가는 곳 -->
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->

<!-- 내용 -->
<%
String product = request.getParameter("product");
StoreDAO sdao = new StoreDAO();
List list = sdao.storeList(product);
List adId_list = new ArrayList();
List ad_list = new ArrayList();
String ad = "부산역";
%>
<!--테이블-->


	<table border="1" class="center_table">
	<th>스토어 이름</th><th>주소</th><th>주소 아이디</th>
	<%for(int i=0; i<list.size(); i++){
	StoreBean sb = (StoreBean)list.get(i);
	%>
	<tr><td><a href="#" id="ad_href"><%=sb.getName() %></a></td>
	<td><%=sb.getAddress() %></td>
	<td><%=sb.getAd_id()%></td>
	<td><input type="button" value="방문하기" onclick="map('<%=sb.getAd_id()%>','<%=sb.getAddress()%>')"></td>
	<td><input type="button" value="테스트" onclick="list()"></td>
	<%adId_list.add(sb.getAd_id()); %>
	<%ad_list.add(sb.getAddress()); %>

	</tr>
<%} %>
<%
System.out.println(ad);
%>
	</table>
	<div id="map_view2" class="text_center">
	<embed type="text/html" src="mapId3.jsp?address=<%=ad %> "  height="400px" width="500px">
	</div>
	<div id="map_view"></div>
	<script>
	

		function map(ad_id, address){
		var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() {
			    if (this.readyState == 4 && this.status == 200) {
			      document.getElementById("map_view").innerHTML = this.responseText;
			    }
			  };
		xhttp.open("GET", "map2.jsp?ad_id="+ad_id+"&address="+address, true);
		xhttp.send();
		}
		
		function list(){
			alert("hi");
		/*var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() {
			    if (this.readyState == 4 && this.status == 200) {
			      //document.getElementById("map_view").innerHTML = this.responseText;
			    }
			  };
		xhttp.open("GET", "map2.jsp?adId_list="+adId_list, true);
		xhttp.send();*/
		}
	
	
	
	</script>


<!-- 내용 -->
<!-- 본문 들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>