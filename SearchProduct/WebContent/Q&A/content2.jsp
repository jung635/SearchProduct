
<%@page import="store.CommentBean"%>
<%@page import="java.util.List"%>
<%@page import="store.BoardBean"%>
<%@page import="store.BoardDAO"%>
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
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
 $(document).ready(function(){
	 
    $("#qa_reply_content #re_reply_button").click(function(){
    	var num=this.alt;
        $("#re_reply_content"+num).toggle();
    });
}); 
 

</script>
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 본문들어가는 곳 -->
<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = (String)request.getParameter("pageNum");
BoardDAO bdao = new BoardDAO();
CommentBean cb = null;
//조회수증가 readcount 1증가 update readcount=readcount+1
//메서드 호출 updateReadcount(num)
bdao.updateReadcount(num);
BoardBean bb = bdao.getDetail(num);
%>

<table class="border_table">
<tr>
<td>글번호</td><td><%=bb.getNum() %></td>
</tr>
<tr>
<td>이름</td><td><%=bb.getName() %></td>
</tr>
<tr>
<td>제목</td><td colspan="3"><%=bb.getSubject() %></td>
</tr>
<tr>
<td>내용 </td><td colspan="3"><%=bb.getContent() %></td>
</tr>
<tr>
<td>첨부파일 </td><td colspan="3"><%
if(bb.getFile()==null){
%>
첨부파일 없음
<%}else{ %>
<a href="../boardPic/<%=bb.getFile() %>" >
<%=bb.getFile() %></a></td>
</tr>
<tr>
<td colspan="3" align="center">
<img src="../boardPic/<%=bb.getFile() %>" width="100px" height="100px">
</td>
</tr>
<%} %>
</table>


<!-- 댓글 -->

<%List relist=bdao.getReDetail(num);%>
 	<table id="qa_reply_content">
 	<th>아이디</th><th style="width: 400px;">내용</th><th>시간</th>
	<%for(int i=0; i<relist.size(); i++){
	cb = (CommentBean)relist.get(i);
	%>
	
	<tr>
	<td><%=cb.getName() %></td>
	<td><%=cb.getContent() %></td>
	<td><%=cb.getDate() %></td>
	<td><input type="button" id="re_reply_button" value="댓글달기" alt="<%=cb.getRe_seq()%>"></td>
	</tr>
	<tr id="re_reply_content<%=cb.getRe_seq()%>" style="display: none;">
	<td colspan="4"><textarea cols="60" rows="2" id="re_re_text"></textarea><input type="button" id="re_reply_content" value="댓글등록"
	onclick="re_reply()">
	</td>
	</tr>
	<script>
	function re_reply(){
		text = document.getElementById('re_re_text').value;
		window.open("re_rewritePro.jsp?num=<%=num %>&re_seq=<%=cb.getRe_seq() %>&pageNum=<%=pageNum %>&re_lev=<%=cb.getRe_lev() %>&content="+text);
	}
	</script>

<%} %>

<%
String id=(String)session.getAttribute("id");
String pass=(String)session.getAttribute("pass");
%>
<tr>
<td colspan="4">
<form action="rewritePro2.jsp">
<input type="hidden" name="re_ref" value="<%=num%>"> 
<input type="hidden" name="num" value="<%=num%>">
<input type="hidden" name="pageNum" value="<%=pageNum%>">
<input type="hidden" name="pass" value="<%=pass%>">
<input type="hidden" name="name" value="<%=id%>">
<textarea name="content" cols="60" rows="2"></textarea>
<input type="submit" value="댓글등록">

</form>
</td>
</tr>
	</table>
>

<%
//String id=(String)session.getAttribute("id");
//String pass=(String)session.getAttribute("pass");
%>
<%-- <div id="reply_form">
<form action="rewritePro.jsp">
<input type="hidden" name="re_ref" value="<%=num%>"> 
<input type="hidden" name="num" value="<%=num%>">
<input type="hidden" name="pageNum" value="<%=pageNum%>">
<input type="hidden" name="pass" value="<%=pass%>">
<input type="hidden" name="name" value="<%=id%>">
<textarea name="content" cols="60" rows="2"></textarea>
<input type="submit" value="댓글등록">

</form>

</div> --%>
<div id="content_btn">
<input type="button" value="글수정" onclick="location.href='updateForm.jsp?pageNum=<%=pageNum%>&num=<%=num%>'">
<input type="button" value="글삭제" onclick="location.href='deleteForm.jsp?pageNum=<%=pageNum%>&num=<%=num%>'">
<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%=pageNum%>'">
</div> 

<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>