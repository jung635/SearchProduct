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
 <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
 <script type="text/javascript">
 var authMailClicked=false;
 var authCheckChecked=false;
 var authNumCheck=false;
 var idDubClicked=false;
 var id_reg=  /^(?=.*[a-zA-Z])(?=.*[0-9]).{5,10}$/;
 var pass_reg =/^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[~,!,@,#,$,*,(,),=,+,_,.,|]).{10,20}$/;
 var authnum =(Math.floor)(Math.random()*1000000);
 //이메일 전송
 function sendmail(){
	 authMailClicked=true;
	 var email=document.fr.email.value;
	 var url = "mailPro.jsp?email="+email+"&authNum="+authnum;
	 window.open(url,'sendmail',"height=400 width=400");
}
 //이메일 인증 체크
function authCheck(){
 	authCheckChecked=true;
	authInputNum = document.fr.authInputNum.value;
 	if(authInputNum==authnum){
		alert('인증성공!');
		authNumCheck=true;
	}else{
		alert('인증실패!'); 
		authNumCheck=false;
	}  
}
 
 //아이디 중복 체크
 function idDupCheck(){
	 idDubClicked = true;
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
	 	}else if(!id_reg.test(document.fr.id.value)){
			alert("아이디는 영어,숫자조합 5-10자리로 구성해주세요");
			document.fr.id.focus();
			return false;

		}else if(!idDubClicked){
			alert("아이디 중복확인을 해주세요");
			return false;
		}else if(document.fr.idDubOk.value=="no"){
			alert("중복된 아이디는 사용 할 수 없습니다");
			document.fr.id.focus();
			return false;
		} 	
	 	//////비밀번호 유형 체크
	 	if(document.fr.pass.value==""){
	 		alert("비밀번호를 입력해 주세요!");
	 		document.fr.pass.focus();
	 		return false;
	 	}else if(!pass_reg.test(document.fr.pass.value)){
	 		alert("비밀번호는 영어대, 소문자, 숫자, 특수문자 조합 10-20자리로 구성해주세요.");
	 		document.fr.pass.focus();
	 		return false;
	 	}
		//////비밀번호 일치 체크
	 	if(document.fr.pass2.value==""){
	 		alert("비밀번호를 확인해 주세요!");
	 		document.fr.pass2.focus();
	 		return false;
	 	}else if(document.fr.pass.value!=document.fr.pass2.value){
	 		alert("비밀번호가 일치하지 않습니다!");
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
	 		document.fr.name.focus();
	 		return false;
	 	}else if(!authMailClicked){
			alert("메일 인증을 해주세요");
			return false;
	 	}else if(document.fr.authInputNum.value==""){
	 		document.fr.authInputNum.focus();
			alert("메일 인증번호를 입력해주세요");
			return false;
	 	}else if(!authCheckChecked){
			alert("인증번호를 확인해주세요");
			return false;
		}else if(!authNumCheck){
			alert("인증번호가 맞지 않습니다.");
			document.fr.authInputNum.focus();
			return false;
		}
	 	
 	//////주소 체크
 	if(document.fr.address.value==""){
 		alert("주소를 입력해 주세요!");
 		document.fr.address.focus();
 		return false;
 	}
 	

 }


	//비밀번호 일치 체크 디스플레이
	 function passCheck(){
	 	if(document.fr.pass.value==document.fr.pass2.value){
	 		document.getElementById("passdbCheckDisplay").innerHTML="비밀번호가 일치합니다";
	 	}else{
	 		document.getElementById("passdbCheckDisplay").innerHTML="비밀번호가 일치하지 않습니다."; 	
	 }	
	 }

	//비밀번호 유형 체크 디스플레이
	 function passFormCheck(){
	 	var pwd=document.fr.pass.value;	
	 	if(!pass_reg.test(pwd)){
	 		document.getElementById("passCheckDisplay").innerHTML="비밀번호는 영어대, 소문자, 숫자, 특수문자 조합 10-20자리로 구성해주세요.";	
	 	}else{
	 		document.getElementById("passCheckDisplay").innerHTML="OK!";	 		
	 	}
	 }

	//아이디 유형 체크 디스플레이
	 function idCheck(){
	 	var id=document.fr.id.value;
	 		if(!id_reg.test(id)){
	 			document.getElementById("idCheckDisplay").innerHTML="아이디는 영어,숫자조합 5-10자리로 구성해주세요";

	 		}else{
	 			document.getElementById("idCheckDisplay").innerHTML="OK!";
	 		}
	 	
	 }
	
	//우편번호 검색
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
		             document.getElementById('address').focus();
		         }
		     }).open();
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
<input type="hidden" name="idDubOk">
<input type="hidden" name="type" value="store">

<fieldset>
<legend>Basic Info</legend>
<label>User ID</label>
<input type="text" name="id" class="id" onkeyup="idCheck()">
<input type="button" value="dup. check" class="dup" onclick="idDupCheck()"><span id="idCheckDisplay"></span><br>

<label>Password</label>
<input type="password" name="pass" onkeyup="passFormCheck()"><span id="passCheckDisplay"></span><br>
<label>Retype Password</label>
<input type="password" name="pass2"  onkeyup="passCheck()"><span id="passdbCheckDisplay"></span><br>
<label>Name</label>
<input type="text" name="name"><br>
<label>E-Mail</label>
<input type="email" name="email"><input type="button" value="인증메일 발송" onclick="sendmail()"><br>
<label></label>
<input type="text" name="authInputNum"><input type="button" value="인증확인" onclick="authCheck()"><br>
<label>Address</label>
<input type="text" name="postcode" id="postcode" placeholder="우편번호">
<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
<label></label>
<input type="text" name="address" id="address" placeholder="주소"><br>

<div class="clear"></div>
<div id="buttons">
<input type="submit" value="Submit" class="submit">
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