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
<%
 String id=(String)session.getAttribute("id");
 %>
<script>
var dubClicked=false;
var id = '<%=id%>';
function dupCheck(){
	 dubClicked = true;
	 var product=document.fr.product.value;
	 var url = "dupProductCheck.jsp?id="+id+"&product="+product;
	 window.open(url,'dupCheck',"height=400 width=400");
}
function check(){
	var regNumber =  /[0-9]|\./;
	//상품 확인
	var ori_product = document.fr.ori_product.value;
	var product = document.fr.product.value;
	if(ori_product!=product){
		if(document.fr.product.value==""){
			alert('상품명을 입력해주세요');
			history.back();
			document.fr.product.focus();
			return false;
		}else if(!dubClicked){
			alert("이름 중복확인을 해주세요");
			document.fr.product.focus();
			return false;
		}else if(document.fr.dubOk.value=="no"){
			alert("중복된 이름은 사용 할 수 없습니다");
			document.fr.product.focus();
			return false;
		} 
	}
	//가격 확인
	if(document.fr.price.value==""){
		alert('가격을 입력해주세요');
		history.back();
		document.fr.price.focus();
		return false;
	}else if(!regNumber.test(document.fr.price.value)) {
	    alert('가격은 숫자만 입력 가능합니다');
	    history.back();
		document.fr.price.focus();
		return false;
	}

}
</script>

</head>
<body>
<!-- 오른쪽 슬라이더 -->
<jsp:include page="../inc/right.jsp"/>
<!-- 오른쪽 슬라이더 -->
<%request.setCharacterEncoding("utf-8");
String product = request.getParameter("product");
String pic = request.getParameter("pic");
int price = Integer.parseInt(request.getParameter("price"));
%>
<div id="wrap">
<jsp:include page="../inc/snsbar.jsp"/>
<jsp:include page="../inc/top.jsp"/>
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="goodsList.jsp">상품 목록</a></li>
<li><a href="regGoodsForm.jsp">상품 등록</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문 들어가는 곳 -->

<article>
<h1>상품 수정</h1>
</article>
<form action="goodsUpdatePro.jsp" name="fr" enctype="multipart/form-data" method="POST"  onsubmit="return check()">
<input type="hidden" name="dubOk">
<input type="hidden" name="ori_product" value="<%=product%>">
<input type="hidden" name="ori_pic" value="<%=pic %>">
<table class="table_center" style="margin: auto;">
<tr>
<td>상품 이름</td>
<td><input type="text" name="product"  value="<%=product%>">
<input type="button" value="dup. check" class="dup" onclick="dupCheck()"><br></td>
</tr>
<tr>
<td>가격</td><td> <input type="text" name="price"  value="<%=price%>"></td>
</tr>
<tr>
<td>파일</td><td> <input type="file" name="file"></td>
</tr>
<tr>
<td colspan="2" >
<input type="button" value="취소" onclick="history.back()" style="float: right;">
<input type="button" value="삭제" onclick="location.href='recheckGoodsDelete.jsp?product=<%=product%>&price=<%=price%>'" style="float: right;">
<input type="submit" value="수정" style="float: right;">

</td>
</tr>
</table>
</form>
<!-- 메뉴 들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>