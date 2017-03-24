<%@page import="java.util.StringTokenizer"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="store.GoodsBean"%>
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
    overflow-y: hidden;
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
z-index: 1;
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



#user_img{
text-align: center;
margin-top: 38px;
}


#visit_table a{
color: black;
font-size: 1em;
padding: 0px;
text-align: center;
}
#visit_pro{
width: 252px;
margin: 29px auto 0 auto;
text-align: center;
}
#visit_pro a{
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
if(id==null){%>
<div id="welcome_top">
	<span>로그인을 해주세요</span>
</div>
<div id="user_img">
<img src="../images/user_none.png" width="100px">
</div>
<%}else{%>
<div id="welcome_top">
<span><%=id %>님의 메뉴</span>
</div>
<div id="user_img">
<img src="../images/user_none.png" width="100px">
</div>

<!-- 최근 방문 스토어 -->
<div id="visit">
<h1 style="text-align: center;line-height: 30px;">최근 방문한 스토어</h1>
*방문을 원할 시 이름을 클릭하세요
	<table id="visit_table" style="margin: 27px auto 0 auto;">	
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
 			<td><a href="../search/storeSearchMain.jsp?storeId=<%=sb.getId()%>&address=<%=sb.getAddress()%>"><%=sb.getName() %></a></td>
 			<td><%=sb.getAddress() %></td>
 		</tr>
 		<%}//end if equals
 			}//end for idnum
 		%>
 			<%if(count>6){
 				break;
 			}//end count 4 break
 		}//end for cookies
 	}//end if cookie null
 	if(count==0){%>
 	<tr><td colspan="2">방문한 목록이 없습니다</td></tr>
 	<%} %>

	</table>
</div>
<!-- 최근 방문 스토어 -->
<!-- 최근 본 상품 -->
<div id="visit">
<h1 style="text-align: center;line-height: 30px;">최근 본 상품</h1>
*상품위에 마우스를 올리시면 크게볼 수 있습니다
	<table id="visit_pro">	
		<tr><th>상품사진</th><th>이름</th><th>가격</th></tr>
 	<%
 	int count_pro=0;
 	String cookie_pro = request.getHeader("Cookie");
 	if(cookie!=null){
 	Cookie[] cookies = request.getCookies(); //쿠키를 받아온다.
 	for(int i=0; i<cookies.length;i++){	
 		String cookieName = URLDecoder.decode(cookies[i].getName());
 		for(int idnum=0; idnum<allId.size(); idnum++){
 			List<Object> goods_list=gdao.goodsList(allId.get(idnum));
 			List<String> allPro_list = new ArrayList<String>();
 			for(int j=0; j<goods_list.size(); j++){
 				//System.out.println(allId.get(idnum));
 				GoodsBean allPro = (GoodsBean)goods_list.get(j);
 				allPro_list.add(allPro.getProduct());
 				//System.out.println(allPro.getProduct());
 			}//end for j
 			for(int pronum=0; pronum<allPro_list.size(); pronum++){
 			//System.out.println(allPro_list.get(pronum));
 			String idPro=allId.get(idnum)+"/"+allPro_list.get(pronum);
 			//System.out.println(idPro);
 			if(cookieName.equals(idPro)){
 				//System.out.println("test");
 				count_pro++;
 				
 				List<String> idPro_list = new ArrayList<String>();
 				/////System.out.println(idPro);
 				StringTokenizer idPro_token = new StringTokenizer(idPro,"/");
 				while(idPro_token.hasMoreTokens()){
 					idPro_list.add(idPro_token.nextToken());
 				}
 				GoodsBean result_gb=gdao.searchGoods(idPro_list.get(0), idPro_list.get(1));
 				StoreBean sb_add = sdao.storeSearch(idPro_list.get(0));
 				//sb = sdao.storeSearch(cookies[i].getValue());%>
 		<tr>
 			<!--  -->
 			<td>
 			<a href="../search/proDetail.jsp?storeId=<%=result_gb.getId()%>&product=<%=result_gb.getProduct()%>"><img src="../upload/<%= result_gb.getPic()%>" height="20px" width="20px" onmouseover="imageOn_r('../upload/<%=result_gb.getPic()%>', <%=i%>)" onmouseout="imageOut_r(<%=i%>)"></a>
 			<div id="up_r<%=i %>" style="position:absolute; width:80%; left:40px; display:none; z-index: 50;">
			<img id="upImg_r<%=i %>" src="" width="100%" height="100%" style="max-width: 300px; max-height: 250px; z-index: 100;"/></div>
 			</td>
 			<td><a href="../search/proDetail.jsp?storeId=<%=result_gb.getId()%>&product=<%=result_gb.getProduct()%>"><%= result_gb.getProduct()%></a></td>
 			<td><%= result_gb.getPrice()%></td>
 			<td><a href="../search/storeSearchMain.jsp?storeId=<%=result_gb.getId()%>&address=<%=sb_add.getAddress()%>">>>visit</a></td>
 			
 		</tr>
 		<%}//end if equals
 			}//end for pronum
 			}//end for idnum
 		%>
 			<%if(count>6){
 				break;
 			}//end count 4 break
 		}//end for cookies
 	}//end if cookie null
 	if(count==0){%>
 	<tr><td colspan="4">최근 본 상품이 없습니다.</td></tr>
 	<%} //end if count
 	
 	}//end if(session)%>

	</table>
</div>
<!-- 최근 본 상품 -->


</div>
</body>
</html>