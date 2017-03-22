
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
 <%
String id=(String)session.getAttribute("id");
String pass=(String)session.getAttribute("pass");
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = (String)request.getParameter("pageNum");
BoardDAO bdao = new BoardDAO();
CommentBean cb = null;
bdao.updateReadcount(num);
BoardBean bb = bdao.getDetail(num);
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
 $(document).ready(function(){
	 
    $("#qa_reply_content #re_reply_button").click(function(){
    	var num=this.alt;
        $("#re_reply_content"+num).toggle();
    });
}); 
 
 function re_view(board_num, renum){
		var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() {
			    if (this.readyState == 4 && this.status == 200) {
			      document.getElementById("re_re_detail"+renum).innerHTML = this.responseText;
			    }
			  };
			xhttp.open("GET", "re_redetail.jsp?board_num="+board_num+"&renum="+renum+"&pageNum="+<%=pageNum%>, true);
			xhttp.send();
		}

</script>


</head>
<body>
<!-- 오른쪽 슬라이더 -->
<jsp:include page="../inc/right.jsp"/>
<!-- 오른쪽 슬라이더 -->
<div id="wrap">
<jsp:include page="../inc/snsbar.jsp"/>
<jsp:include page="../inc/top.jsp"/>
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 본문들어가는 곳 -->
<!-- 글내용 -->
<table class="border_table">
<tr>
<td>글번호</td><td><%=bb.getNum() %></td>
<td>이름</td><td><%=bb.getName() %></td>
</tr>
<tr>
<td>조회수</td><td><%=bb.getReadcount() %></td>
<td>작성 날짜</td><td><%=bb.getDate() %></td>
</tr>
<tr>
<td>제목</td><td colspan="5"><%=bb.getSubject() %></td>
</tr>
<tr>
<td style="height: 300px;">내용 </td>
<td colspan="5">
<%=bb.getContent() %>
<%if(bb.getFile()==null){ %>

<%}else{ %>
<div style="margin: 22px; position:relative;">
<img src="../boardPic/<%=bb.getFile() %>" style="max-width: 350px;">
<a href="../boardPic/<%=bb.getFile() %>" style="position: absolute; right: 0;bottom: 0;">파일열기</a>
	<a href="file_down.jsp?file_name=<%=bb.getFile() %>" style="position:absolute; right: 55px;bottom: 0;">파일다운</a>
</div>
<%} %>
</td>
</tr>
</table>
<!-- 글내용 -->

<!-- 댓글내용 -->
<%List relist=bdao.getReDetail(num);%>
<table id="qa_reply_content">
	<th>아이디</th><th style="width: 400px;">내용</th><th>시간</th>
<%for(int i=0; i<relist.size(); i++){
	cb = (CommentBean)relist.get(i);
%>
	<tr>
		<td><%=cb.getName() %></td>
		<td ><%=cb.getContent() %></td>
		<td><%=cb.getDate() %></td>
		<td>
			<input type="button" id="re_reply_button" value="댓글" alt="<%=cb.getRenum()%>" onclick="re_view(<%=cb.getBoard_num()%>,<%=cb.getRenum()%>)">
			<input type="button" id="re_delete_btn" value="X" onclick="location.href='re_delete.jsp?board_num=<%=cb.getBoard_num()%>&renum=<%=cb.getRenum()%>&name=<%=cb.getName()%>&pageNum=<%= pageNum %>'">
		</td>
	</tr>
	<!-- 대댓글내용 -->
	<tr id="re_reply_content<%=cb.getRenum()%>" style="display: none;">
		<td colspan="4"><div id="re_re_detail<%=cb.getRenum()%>"></div>
		<!-- 대댓글작성 -->
		<textarea cols="60" rows="2" id="re_re_text<%=cb.getRenum()%>"></textarea><input type="button" id="re_reply_content" value="댓글등록"
		onclick="re_reply(<%=cb.getRenum()%>)">
		<!-- 대댓글작성 -->
		</td>
	<!-- 대댓글내용 -->
	<script>
	function re_reply(renum){
	var id='<%=id%>';
		var text = document.getElementById('re_re_text'+renum).value;
	if(id==null){
		alert('로그인을 해주세요');
		location.href="../member/clientLoginForm.jsp"
	}else if(text==""){
		alert("내용을 입력해 주세요");
	}else{
		//window.open("re_rewritePro.jsp?num=<%=num%>&re_seq=<%=cb.getRe_seq()%>&pageNum=<%=pageNum%>&renum="+renum+"&content="+text);
		
		var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() {
			    if (this.readyState == 4 && this.status == 200) {
			      document.getElementById("re_re_detail"+renum).innerHTML = this.responseText;
			      
			    }
			  };
		xhttp.open("GET", "re_rewrite.jsp?num=<%=num%>&re_seq=<%=cb.getRe_seq()%>&pageNum=<%=pageNum%>&renum="+renum+"&content="+text, true);
		xhttp.send();
		document.getElementById('re_re_text'+renum).value="";
	}
	}
	</script>
<%}%>
<!-- 댓글내용 -->
<!-- 댓글작성 -->
<tr>
<td colspan="4">
<form action="rewritePro.jsp">
<input type="hidden" name="num" value="<%=num%>">
<input type="hidden" name="board_num" value="<%=num%>">
<input type="hidden" name="pageNum" value="<%=pageNum%>">
<input type="hidden" name="pass" value="<%=pass%>">
<input type="hidden" name="name" value="<%=id%>">
<textarea name="content" cols="60" rows="2"></textarea>
<input type="submit" value="댓글등록">
</form>
</td>
</tr>
</table>
<!-- 댓글작성 -->
<!-- 글내용 bottom -->
<div id="content_btn">
<input type="button" value="글수정" onclick="location.href='updateForm.jsp?pageNum=<%=pageNum%>&num=<%=num%>'">
<input type="button" value="글삭제" onclick="location.href='deleteForm.jsp?pageNum=<%=pageNum%>&num=<%=num%>&name=<%=bb.getName()%>&file=<%=bb.getFile()%>'">
<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%=pageNum%>'">
</div> 
<!-- 글내용 bottom -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>