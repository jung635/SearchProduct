<%@page import="store.BoardBean"%>
<%@page import="store.BoardDAO"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
BoardDAO bdao = new BoardDAO();

//전체 글의 개수 구하기
//현페이지가 몇페이지인지 가져오기
int count = bdao.getListCount();
String pageNum = request.getParameter("pageNum");
if(pageNum==null)	pageNum="1";
int currentPage=Integer.parseInt(pageNum);
int pageSize=10;
int start=0;
int end=0;
//시작행 구하기
	start = (pageSize*(currentPage-1));
	//start = 1+(pageSize*(currentPage-1));
	end = start+pageSize-1;
	List<?> list = null ;
 	if(count!=0){
 		//list = bdao.boardList(start, end);
 		list = bdao.boardList(start, pageSize);
 		
	} 
	
	//최근글이 위로 re_ref 그룹별 내림차순 정렬 re_ref desc, re-seq  오름차순 asc
	//글 잘라오기 limit 시작행-1,개수

%>

<table border="1">
<th>글번호</th><th>이름</th><th>제목</th><th>조회수</th><th>작성일</th>
<%
for(int i=0; i<list.size(); i++){
	BoardBean bb = (BoardBean)list.get(i);
%>
<tr><td><%=bb.getNum() %></td><td><%=bb.getName() %><td>
<%
//답글 들여쓰기 모양
int width = 0;
if(bb.getRe_lev()>0){
	width=10*bb.getRe_lev();
	
	%>
	<img alt="답글 레벨" src="level.gif" width="<%=width%>" height="15px">	
	<img alt="답글 이미지" src="re.gif">	
<%}
%>
<a href="content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>"><%=bb.getSubject() %></a></td>
<td><%=bb.getReadcount() %></td><td><%=bb.getDate() %></td>
</tr>
<%} %>
</table>
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
//이전
//1...10
//다음
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
	<%
	}else{%>
	
	<a href="list.jsp?pageNum=<%=i %>">[<%=i %>]</a>&nbsp;
	<%
	}
}
%>

<%if(endPage<pageCount){ %>
[다음]
<%}else{ %>
<a href="list.jsp?pageNum=<%=startPage+pageBlock %>">[다음]</a>&nbsp;
<%}
}

%>


<input type="button" value="글쓰기" onclick="location.href='write.jsp'">
count: <%=count %>
start: <%=start %>
end: <%=end %>
</body>
</html>