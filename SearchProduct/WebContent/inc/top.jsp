<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일들어가는 곳 -->
<header>
<%
String id=(String)session.getAttribute("id");
String pass=(String)session.getAttribute("pass");
String type=(String)session.getAttribute("type");
if(id==null||type==null){%>
<div id="login"><a href="../member/clientLoginForm.jsp">login</a> | <a href="../member/clientJoinForm.jsp">join</a></div>
<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><a href="../main/main.jsp"><img src="../images/logo2.png" width="265" height="62" alt="Fun Web"></a></div>
<!-- 로고들어가는 곳 -->
<div class="nav_container">
  <a href="../hot/hotlist.jsp">HOT</a>
  <a href="../news/list.jsp">NEWS</a>
  <div class="dropdown">
  <button class="dropbtn">SEARCH▼</button>
  	<div class="dropdown-content">
 		 <a href="../search/stores.jsp">STORES</a>
  		<a href="../search/products.jsp">PRODUCTS</a>
 	 </div>
  </div> 
  <a href="../client/clientInfo.jsp">MY INFO</a>
  <a href="../Q&A/list.jsp">BOARD</a>
  <a href="../contact/contact.jsp">CONTACT US</a>
</div>
</header>
<!-- 헤더파일들어가는 곳 -->
<%}else{
if(type.equals("client")||type.equals("admin")){
%>
<div id="login"><%=id %>님 환영합니다! | <a href="../member/logout.jsp">logout</a></div>
<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><a href="../main/main.jsp"><img src="../images/logo2.png" width="265" alt="Fun Web"></a></div>
<!-- 로고들어가는 곳 -->
<div class="nav_container">
  <a href="../hot/hotlist.jsp">HOT</a>
  <a href="../news/list.jsp">NEWS</a>
  <div class="dropdown">
    <button class="dropbtn">SEARCH▼</button>
    <div class="dropdown-content">
      <a href="../search/stores.jsp">STORES</a>
      <a href="../search/products.jsp">PRODUCTS</a>
    </div>
  </div> 
  <a href="../client/clientInfo.jsp">MY INFO</a>
  <a href="../Q&A/list.jsp">BOARD</a>
  <a href="../contact/contact.jsp">CONTACT US</a>
</div>
</header>
<!-- 헤더파일들어가는 곳 -->
<%}else if(type.equals("store")){%>
<div id="login"><%=id %>님 환영합니다! | <a href="../member/logout.jsp">logout</a></div>
<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><a href="../main/main.jsp"><img src="../images/logo2.png" width="265" height="62" alt="Fun Web"></a></div>
<!-- 로고들어가는 곳 -->
<div class="nav_container">
  <a href="../store/storeMain.jsp">STORE HOME</a>
  <a href="../store/goodsList.jsp">MY PRODUCT</a>
  <a href="../store/storeInfo.jsp">MY INFO</a>
  <a href="../contact/contact.jsp">CONTACT US</a>
</div>
</header>
<!-- 헤더파일들어가는 곳 -->
<%}}%>

