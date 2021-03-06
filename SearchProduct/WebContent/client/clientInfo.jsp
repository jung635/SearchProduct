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
<!-- 오른쪽 슬라이더 -->
<jsp:include page="../inc/right.jsp"/>
<!-- 오른쪽 슬라이더 -->
<div id="wrap">
<jsp:include page="../inc/snsbar.jsp"/>
<jsp:include page="../inc/top.jsp"/>
<%request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");
MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.infoMember(id);

if(id==null){%>
	<script>
	alert('로그인을 해주세요');
	location.href="../member/clientLoginForm.jsp"
	</script>
<%}
%>
<!-- 본문 들어가는 곳 -->
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="clientInfo.jsp">회원 정보 확인</a></li>
<li><a href="clientInfoUpdate.jsp">회원 정보 수정</a></li>
<li><a href="clientInfoDeleteForm.jsp">회원 탈퇴</a></li>
<li><a href="mygoods.jsp">찜 리스트</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->

<div class="text_center">
<h1>client 회원정보</h1>
<table border="1" class="info_table">
<tr><td>아이디</td><td><%=id%></td></tr>
<tr><td>비밀번호</td><td><%=mb.getPass()%></td></tr>
<tr><td>이름</td><td><%=mb.getName()%></td></tr>
<tr><td>가입 날짜</td><td><%=mb.getReg_date()%></td></tr>
<tr><td>주소</td><td><%=mb.getAddress()%></td></tr>
<tr><td>우편 번호</td><td><%=mb.getPostcode()%></td></tr>
<tr><td>휴대폰번호</td><td><%=mb.getPhone()%></td></tr>
<tr><td>email</td><td><%=mb.getEmail()%></td></tr>
</table>
</div>
<!-- 본문내용 -->
<!-- 본문 들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>