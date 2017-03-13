<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
 $(function(){

     $("#box .imgst").click(function() {   // box 안의 태그중 클래스가 imgst 인 태그를 클릭하면...
          var num = this.alt;  // alt 에 입력된 값을 가져온다.
     $("#box #toggle_v_"+num).stop().toggle("slow");  // 해당 서브 div 를 토글시킨다.
     });

});
</script>


<div id="box">

 

<a href="#">
<img class='imgst' src='write.png' width='30' height='30' alt='1' /></a>
<br>
<div id="toggle_v_1" style="border:1px solid black; display:none;">Show & View 11</div>

 


<a href="#">
<img class='imgst' src='write.png' width='30' height='30' alt='2' /></a>
<br>
<div id="toggle_v_2" style="border:1px solid black; display:none;">Show & View 22</div>

 

</div>
</body>
</html>