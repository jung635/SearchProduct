<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
 <script type="text/javascript">
 function idDupCheck(){
	 var id=document.fr.id.value;
	 var url = "dupStoreIdCheck.jsp?id="+id;
	 window.open(url,'idCheck',"height=400 width=400");
 }
 
 function submitCheck(){
	
 	//////아이디 체크
 	if(document.fr.id.value==""){
 		alert("아이디를 입력해 주세요!");
 		document.fr.id.focus();
 		return false;
 	}else if(document.fr.id.value.length<6||document.fr.id.value.length>11){
 		alert("아이디는 5자이상 10자 이하로 해주세요");
 		document.fr.id.focus();
 		return false;
 	}
 	
 	//////비밀번호 체크
 	if(document.fr.pass.value==""){
 		alert("비밀번호를 입력해 주세요!");
 		document.fr.pass.focus();
 		return false;
 	}
 	else if(document.fr.id.value.length<6||document.fr.id.value.length>11){
 		alert("아이디는 5자이상 10자 이하로 해주세요");
 		document.fr.id.focus();
 		return false;
 	}
 	
 	if(document.fr.pass2.value==""){
 		alert("비밀번호를 확인해 주세요!");
 		document.fr.pass2.focus();
 		return false;
 	}
 	
 	
 	//////이름 체크
 	if(document.fr.name.value==""){
 		alert("이름을 입력해 주세요!");
 		document.fr.name.focus();
 		return false;
 	}
 	//////이메일 체크
 	if(document.fr.email.value==""){
 		alert("이메일을 입력해 주세요!");
 		document.fr.eamil.focus();
 		return false;
 	}
 	//////주소 체크
 	if(document.fr.address.value==""||document.fr.ad_id.value==""){
 		alert("주소를 입력해 주세요!");
 		document.fr.address.focus();
 		return false;
 	}
 	

 	


 }


 function passCheck(){
 	
 	
 	if(document.fr.pass.value==document.fr.pass2.value){
 		document.getElementById("passCheckDisplay").innerHTML="비밀번호가 일치합니다";
 	}else{
 		document.getElementById("passCheckDisplay").innerHTML="비밀번호가 일치하지 않습니다.";
 	
 }	
 }

 function passFormCheck(){
 	var pwd=document.fr.pass.value;
 	reg =/^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[~,!,@,#,$,*,(,),=,+,_,.,|]).{10,20}$/;
 	if(!reg.test(pwd)){
 		document.getElementById("passCheckDisplay").innerHTML="비밀번호는 영어대, 소문자, 숫자로 10-20자리로 구성해주세요.";	
 	}else{
 		document.getElementById("passCheckDisplay").innerHTML="OK!";	
 		
 	}
 }


 function idCheck(){
 	var id=document.fr.id.value;
 	reg=  /^(?=.*[a-zA-Z])(?=.*[0-9]).{5,10}$/;
 		if(!reg.test(id)){
 			document.getElementById("idCheckDisplay").innerHTML="아이디는 영어,숫자조합 5-10자리로 구성해주세요";

 		}else{
 			document.getElementById("idCheckDisplay").innerHTML="OK!";
 		}
 	
 }

 </script>
</head>
<body>
 <%
 String place=request.getParameter("placeId");
 System.out.println(place);
 %>

<div id="wrap">
<jsp:include page="../inc/top.jsp"/>

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>Join Us</h1>
<form action="storeJoinPro.jsp" id="join" name="fr" onsubmit="return submitCheck()">
<input type="hidden" name="type" value="store">
<fieldset>
<legend>Basic Info</legend>
<label>User ID</label>
<input type="text" name="id" class="id" onkeyup="idCheck()">
<input type="button" value="dup. check" class="dup" onclick="idDupCheck()"><span id="idCheckDisplay"></span><br>

<label>Password</label>
<input type="password" name="pass" onkeyup="passFormCheck()"><br>
<label>Retype Password</label>
<input type="password" name="pass2"  onkeyup="passCheck()"><span id="passCheckDisplay"></span><br>
<label>Name</label>
<input type="text" name="name"><br>
<label>E-Mail</label>
<input type="email" name="email"><br>
<label>Address</label>
<input type="text" name="address"><input type="button" value="주소 찾기" onclick='window.open("idFinder.jsp", "idfinder", "width=600,height=500");'><br>
<label>address id</label>
<input type="text" name="ad_id">
<!-- 'location.href="idFinder.jsp"' -->
<!-- window.open("idFinder.jsp", "idfinder", "width=600,height=500"); -->



<div class="clear"></div>
<div id="buttons">
<input type="button" value="Submit" class="submit" onclick="submit()">
<input type="button" value="Cancel" class="cancel" onclick="history.back()">
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