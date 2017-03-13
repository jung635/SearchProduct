<%@page import="store.StoreDAO"%>
<%@page import="java.util.List"%>
<%@page import="store.StoreBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<title>Insert title here</title>

</head>
<body>
<%String ad_id= request.getParameter("ad_id");
String address=request.getParameter("address");

%>

<%-- <iframe src="mapId2.jsp?ad_id=<%=ad_id %>" height="400px" width="500px"></iframe> --%>
<div class="text_center"><embed type="text/html" src="mapId2.jsp?ad_id=<%=ad_id %>"  height="400px" width="500px">
</div>
<div class="text_center">주소: <%=address %></div>




</body>
</html>