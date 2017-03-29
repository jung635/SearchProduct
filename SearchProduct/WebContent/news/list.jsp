<%@page import="store.NewsBean"%>
<%@page import="store.NewsDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
</head>
<body>
<%
String type=(String)session.getAttribute("type");
NewsDAO ndao = new NewsDAO();
int count = ndao.getListCount();
String pageNum = request.getParameter("pageNum");
if(pageNum==null)	pageNum="1";
int currentPage=Integer.parseInt(pageNum);
int pageSize=10;
int start=0;
int end=0;

	start = (pageSize*(currentPage-1));
	end = start+pageSize-1;
	List<?> list = null ;
 	if(count!=0){
 		list = ndao.boardList(start, pageSize);
	}
%>
<div id="wrap">
<jsp:include page="../inc/snsbar.jsp"/>
<jsp:include page="../inc/top.jsp"/>
<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->
<!-- 게시판 -->
<!-- 게시판 list -->
<article id="qa_list">
<h1>NEWS</h1>
<table id="notice">
	<tr><th class="tno">No.</th>
   	 <th class="ttitle">Title</th>
   	 <th class="twrite">Writer</th>
   	 <th class="tdate">Date</th>
  	 <th class="tread">Read</th></tr>
   <%if(list == null){%>
	<tr><td colspan="4">글이 없습니다</td><td>
   <%
   	}else{
   		for (int i = 0; i < list.size(); i++) {
   			NewsBean nb = (NewsBean) list.get(i);
   %>
	<tr>
		<td><%=nb.getNum() %></td>
		<td><a href="content.jsp?num=<%=nb.getNum()%>&pageNum=<%=pageNum%>"><%=nb.getSubject() %></a></td>
		<td><%=nb.getName() %></td><td><%=nb.getDate() %></td><td><%=nb.getReadcount() %></td>
	</tr>
	<%}}%>  
</table>

<div id="table_search">
<form action="news_search.jsp">
	<input type="text" name="search" class="input_box">
	<input type="submit" value="search" class="btn">
</form>
</div>
<!-- 게시판 list -->
<!-- 게시판 bottom -->
<div class="clear"></div>
<div id="page_control">
<%
if(count!=0){
	//전체 페이지 수 구하기
 	pageNum = request.getParameter("pageNum");
	//int maxPage=(int)Math.ceil((float)count/pageSize);
	int pageCount = count/pageSize+(count%pageSize==0?0:1);
	//한 화면에 보여줄 페이지 번호 개수
	int pageBlock=10;
	//시작페이지 번호 구하기
	int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
	//끝페이지 번호 구하기
	int endPage = startPage+pageBlock-1;
	if(endPage > pageCount){
		endPage=pageCount;
		}
	if(currentPage<=10){ %>
		[이전]
	<%}else{ %>
		<a href="list.jsp?pageNum=<%=startPage-pageBlock %>">[이전]</a>&nbsp;
	<%}
	for(int i=startPage; i<=endPage; i++){
		if(i==currentPage){%>
			[<%=i %>]
		<%}else{%>
			<a href="list.jsp?pageNum=<%=i %>">[<%=i %>]</a>&nbsp;
	<%}}//for end%>

	<%if(endPage<=pageCount){ %>
		[다음]
	<%}else{ %>
		<a href="list.jsp?pageNum=<%=startPage+pageBlock %>">[다음]</a>&nbsp;
<%}}//count if end

try{
if(type.equals("admin")){ %>
	<input type="button" value="글쓰기" class="write_btn" onclick="location.href='write.jsp'">
<%}
}catch(Exception e){%>
<%}%>
</div>
</article>
<!-- 게시판 bottom -->
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>