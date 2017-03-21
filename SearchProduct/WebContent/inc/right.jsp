<%@page import="store.StoreBean"%>
<%@page import="store.MygoodsBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="store.GoodsDAO"%>
<%@page import="store.MemberBean"%>
<%@page import="store.MemberDAO"%>
<%@page import="store.StoreDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
.sidenav {
    height: 100%;
    width: 0;
    position: fixed;
    z-index: 1;
    top: 0;
    right: 0;
    background-color:  #7ED2FF;
    overflow-x: hidden;
    transition: 0.5s;
    padding-top: 10px;
}

.sidenav a {
    padding: 8px 8px 8px 32px;
    text-decoration: none;
    font-size: 25px;
    color: #818181;
    display: block;
    transition: 0.3s
}

.sidenav a:hover, .offcanvas a:focus{
    color: #f1f1f1;
}

.sidenav .closebtn {
    position: absolute;
    top: 0;
    right: 25px;
    font-size: 36px;
    margin-left: 50px;
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}

#open{
right: 32px;
position: fixed;
top: 28px;
transition: margin-right .5s;
height: 50px;
background-color: #9cf1ff;
right:0;
border-radius: 19px 0px 0px 18px;
}

#open_ck{
font-size: 30px;
cursor: pointer;
line-height: 1.6;
}

#welcome_top{
text-align: center;
border-bottom: 1px solid darkblue;
border-top: 1px solid darkblue;
line-height: 2;
margin-top: 37px;
}

#welcome_top span{
font-size: 2em;
}

#visit{
margin-top: 30px;
margin-bottom: 30px;
}

#mygoods{
margin-top: 30px;
margin-bottom: 30px;
}

#user_img{
text-align: center;
margin-top: 38px;
}
#mygoods_table a{
color: black;
font-size: 1em;
padding: 0px;
text-align: center;
}

#visit_table a{
color: black;
font-size: 1em;
padding: 0px;
text-align: center;
}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
function openNav() {
    $(document).ready(function(){
        $("#open").click(function(){
        	$("#mySidenav").css("width","250px");
        	$("#open").css("marginRight","250px");
        	$("#open #open_ck").text("▶close");
        	$("#open").attr('onmouseover',"").unbind("click");
        	$("#open").bind("mouseover", function(){closeNav();});

        });
    });
}
 function closeNav() {
    $(document).ready(function(){
        $("#open").click(function(){
        	$("#mySidenav").css("width","0");
        	$("#open").css("marginRight","0");
        	$("#open #open_ck").text("◀open");
        	$("#open").attr('onmouseover',"").unbind("click");
        	$("#open").bind("mouseover", function(){openNav();});      
        });
    });
}

function imageOn_r(path, count){
    var divform = document.getElementById("up_r"+count);
    divform.style.display = '';
    document.getElementById("upImg_r"+count).src = path;
}
function imageOut_r(count){
   	var divform = document.getElementById("up_r"+count);
   	divform.style.display = 'none';
}

</script>
<body>
<div id="open">
	<span id="open_ck" onmouseover="openNav()">◀open</span>
</div>
<div id="mySidenav" class="sidenav">
<%request.setCharacterEncoding("utf-8");
String id=(String)session.getAttribute("id");
StoreDAO sdao = new StoreDAO();
MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.infoMember(id);
GoodsDAO gdao = new GoodsDAO();
List<Object> list = new ArrayList<Object>();
list=gdao.mygoodsList(id);
if(id==null){%>
	로그인을 해주세요
<%}else{%>
<div id="welcome_top">
<span><%=id %>님의 메뉴</span>
</div>
<div id="user_img">
<img src="../images/user_none.png" width="100px">
</div>

<!-- 최근 방문 스토어 -->
<div id="visit">
<h1 style="text-align: center;line-height: 30px;">최근 방문한 스토어 리스트</h1>
*방문을 원할 시 이름을 클릭하세요
	<table id="visit_table" style="margin-top: 27px;">	
		<tr><th>이름</th><th>스토어 주소</th></tr>
 	<%
 	int count=0;
 	List<String> allId = sdao.searchAllId();
 	String cookie = request.getHeader("Cookie");
 	if(cookie!=null){
 	Cookie[] cookies = request.getCookies(); //쿠키를 받아온다.
 	for(int i=0; i<cookies.length;i++){	
 		String cookieName = cookies[i].getName();
 		for(int idnum=0; idnum<allId.size(); idnum++){
 			if(cookieName.equals(allId.get(idnum))){
 				count++;
 				StoreBean sb = sdao.storeSearch(cookies[i].getValue());%>
 		<tr>
 			<td><a href="../search/storeSearchMain.jsp?storeId=<%=sb.getName()%>&address=<%=sb.getAddress()%>"><%=sb.getName() %></a></td>
 			<td><%=sb.getAddress() %></td>
 		</tr>
 		<%}}
 		if(count>4){
 			break;
 			}//end count break 5개 출력
 		}//end for cookies
 	}//end if cookie null%>

	</table>
</div>
<!-- 최근 방문 스토어 -->

<!-- 찜 리스트 -->
<div id="mygoods">
<h1 style="text-align: center;line-height: 30px;">찜 리스트</h1>
*상품위에 마우스를 올리시면 크게볼 수 있습니다.<br>
	<table id="mygoods_table" style="margin: auto; padding-top: 23px;">	
		<tr><th>상품 사진</th><th>상품 이름</th><th>상품 가격</th></tr>
 	<%for(int i=0; i<5;i++){
 	MygoodsBean mgb = (MygoodsBean)list.get(i);
 	StoreBean sb = sdao.storeSearch(mgb.getGoods_id());
 	%>
 		<tr><td><img src="../upload/<%=mgb.getPic()%>" height="20px" width="20px" onmouseover="imageOn_r('../upload/<%=mgb.getPic()%>', <%=i%>)" onmouseout="imageOut_r(<%=i%>)">
 			<div id="up_r<%=i %>" style="position:absolute; width:30%; left:40px; display:none; z-index: 50;">
			<img id="upImg_r<%=i %>" src="" width="100%" height="100%" style="max-width: 300px;z-index: 100;"/></div>
 			</td>
 			<td><%=mgb.getProduct() %></td>
 			<td><%=mgb.getPrice() %></td>
 			<td>
 			<a href="../search/storeSearchMain.jsp?storeId=<%=mgb.getGoods_id()%>&address=<%=sb.getAddress()%>">>>visit</a>
 			</td>
 		</tr>
	<%}}%>
	</table>	
</div>
</div>
<!-- 찜 리스트 -->
</body>
</html>