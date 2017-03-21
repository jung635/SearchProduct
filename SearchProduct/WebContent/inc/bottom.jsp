<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 푸터 -->
<footer>
<hr>
<div id="copy">All contents Copyright 2011 FunWeb 2011 FunWeb 
Inc. all rights reserved<br>
Contact mail:funweb@funwebbiz.com Tel +82 64 123 4315
Fax +82 64 123 4321</div>
<%
String id=(String)session.getAttribute("id");
String pass=(String)session.getAttribute("pass");
if(id==null){%>
<div id="login"><a href="../member/storeLoginForm.jsp">store login</a> | <a href="../member/storeJoinForm.jsp">store join</a></div>
<div class="clear"></div>
<div id="login" style="margin: -8px 64px 0 0;"><a href="../member/adminLoginForm.jsp">admin login</a></div>
<%}else{%>
<%}%>
</footer>
<!-- 푸터 -->