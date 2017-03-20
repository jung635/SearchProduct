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
	<script>
	

		function map(address){
		var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() {
			    if (this.readyState == 4 && this.status == 200) {
			      document.getElementById("map_view").innerHTML = this.responseText;
			    }
			  };
		xhttp.open("GET", "single_ad_map.jsp?address="+address, true);
		xhttp.send();
		}
	
	
	
	</script>
</head>
<body>
<div id="wrap"><jsp:include page="../inc/snsbar.jsp"/>
<jsp:include page="../inc/top.jsp"/>

<!-- 본문 들어가는 곳 -->
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->

<!-- 내용 -->
<%
String store = request.getParameter("store");
StoreDAO sdao = new StoreDAO();
int count = sdao.getStoreSearchCount(store);
String pageNum_store = request.getParameter("pageNum_store");
if(pageNum_store==null)	pageNum_store="1";
int currentPage=Integer.parseInt(pageNum_store);
int pageSize=5;
int start=0;
int end=0;
//시작행 구하기
	start = (pageSize*(currentPage-1));
	//start = 1+(pageSize*(currentPage-1));
	end = start+pageSize-1;
	List<?> list = null ;
 	if(count!=0){
 		//list = bdao.boardList(start, end);
 		list = sdao.storeSearchList(store, start, pageSize);
 		
	} 

List<Object> ad_list = new ArrayList<Object>();
List<Object> name_list = new ArrayList<Object>();
%>
<!--테이블-->


	<table class="center_table">
	<th>스토어 이름</th><th>주소</th>
	<%
	try{
	for(int i=0; i<list.size(); i++){
	StoreBean sb = (StoreBean)list.get(i);
	%>
	<tr><td><a href="storeSearchMain.jsp?&address=<%=sb.getAddress() %>&storeId=<%=sb.getId() %>" id="ad_href"><%=sb.getName() %></a>
	</td>
	<td><%=sb.getAddress() %></td>
	<td><input type="button" value="위치보기" onclick="map('<%=sb.getAddress()%>')"></td>
	<td><input type="button" value="방문하기" onclick='location.href="storeSearchMain.jsp?&address=<%=sb.getAddress() %>&storeId=<%=sb.getId() %>"'></td>
	<%//ad_list.add(sb.getAddress()); %>
	</tr>

<%} }catch(Exception e){%>

<tr><td colspan="4">찾으시는 상품이 없습니다.</td></tr>
<%}
	%>
	</table>
	
		<div id="page_control">
<%
if(count!=0){
//전체 페이지 수 구하기
 	pageNum_store = request.getParameter("pageNum_store");
	//int maxPage=(int)Math.ceil((float)count/pageSize);
	int pageCount = count/pageSize+(count%pageSize==0?0:1);
//한 화면에 보여줄 페이지 번호 개수
	int pageBlock=10;
//시작페이지 번호 구하기
	int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;

//끝페이지 번호 구하기
	int endPage = startPage+pageBlock-1;
	System.out.println(pageCount);
//이전
//1...10
//다음
if(endPage > pageCount){
	endPage=pageCount;
}
if(currentPage<=10){ %>
[이전]
<%}else{ %>
<a href="storeSearchList.jsp?store=<%=store %>&pageNum_store=<%=startPage-pageBlock %>">[이전]</a>&nbsp;

<%}
for(int i=startPage; i<=endPage; i++){
	if(i==currentPage){%>
	
	[<%=i %>]
	<%
	}else{%>
	
	<a href="storeSearchList.jsp?store=<%=store %>&pageNum_store=<%=i %>">[<%=i %>]</a>&nbsp;
	<%
	}
}
%>

<%if(endPage<=pageCount){ %>
[다음]
<%}else{ %>
<a href="storeSearchList.jsp?store=<%=store %>&pageNum_store=<%=startPage+pageBlock %>">[다음]</a>&nbsp;
<%}
}

%>
</div>
	<%
	list = sdao.storeSearchList(store, 0, 100);
	for(int i=0; i<list.size(); i++){
	StoreBean sb = (StoreBean)list.get(i);
	ad_list.add(sb.getAddress());
	name_list.add(sb.getName());
	} %>
	<div id="map_view" class="text_center">
	<embed type="text/html" src="multiple_map2.jsp?ad_list=<%=ad_list %>&name_list=<%=name_list %>" id ="map_view"  height="400px" width="500px">
	</div>
<!--테이블-->
<!-- 내용 -->
<!-- 본문 들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>