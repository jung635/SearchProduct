<%@page import="java.sql.Timestamp"%>
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
 <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
 <script type="text/javascript">
 function sample6_execDaumPostcode() {
     new daum.Postcode({
         oncomplete: function(data) {
             // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

             // 각 주소의 노출 규칙에 따라 주소를 조합한다.
             // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
             var fullAddr = ''; // 최종 주소 변수
             var extraAddr = ''; // 조합형 주소 변수

             // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
             if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                 fullAddr = data.roadAddress;

             } else { // 사용자가 지번 주소를 선택했을 경우(J)
                 fullAddr = data.jibunAddress;
             }

             // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
             if(data.userSelectedType === 'R'){
                 //법정동명이 있을 경우 추가한다.
                 if(data.bname !== ''){
                     extraAddr += data.bname;
                 }
                 // 건물명이 있을 경우 추가한다.
                 if(data.buildingName !== ''){
                     extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                 }
                 // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                 fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
             }

             // 우편번호와 주소 정보를 해당 필드에 넣는다.
             document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
             document.getElementById('address').value = fullAddr;

             // 커서를 상세주소 필드로 이동한다.
             document.getElementById('phone').focus();
         }
     }).open();
 }
 function submitCheck(){
 	
 	
 	//////이름 체크
 	if(document.fr.name.value==""){
 		alert("이름을 입력해 주세요!");
 		document.fr.name.focus();
 		return false;
 	}
 	//////이메일 체크
 	if(document.fr.email.value==""){
 		alert("이메일을 입력해 주세요!");
 		document.fr.name.focus();
 		return false;
 	}
 	
 	


 }

 </script>
</head>
<body>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<!-- 본문 들어가는 곳 -->
<%request.setCharacterEncoding("utf-8");
String id =request.getParameter("id");
String name = request.getParameter("name");
String address = request.getParameter("address");
String postcode = request.getParameter("postcode");
String phone = request.getParameter("phone");
String email = request.getParameter("email");
String pass=(String)session.getAttribute("pass");

%>

<%
String sessionId=(String)session.getAttribute("id");
%>
<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="clientInfo.jsp">회원 정보 확인</a></li>
<li><a href="clientInfoUpdate.jsp">회원 정보 수정</a></li>
<li><a href="clientInfoDeleteForm.jsp">회원 탈퇴</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>InFo</h1>
<form action="recheckUpdateForm.jsp" id="join" name="fr" onsubmit="return submitCheck()">
<fieldset>
<legend>Basic Info</legend>
<label>User ID</label>
<input type="text" name="id" class="id" value=<%=sessionId %> readonly><br>
<label>Name</label>
<input type="text" name="name" value=<%=name %>><br>
<label>E-Mail</label>
<input type="email" name="email" value=<%=email %>><br>
<label>Address</label>
<input type="text" name="postcode" id="postcode" placeholder="우편번호" value="<%=postcode%>">
<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
<label></label>
<input type="text" name="address" id="address" placeholder="주소" value="<%=address%>"><br>
<label>Phone Number</label>
<input type="text" name="phone" id="phone" value="<%=phone%>"><br>
</fieldset>



<div class="clear"></div>
<div id="buttons">
<input type="submit" value="Submit" class="submit">
<input type="button" value="Cancel" class="cancel">
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>