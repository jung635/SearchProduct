<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Geocoding service</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <style>
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #map {
        height: 100%;
        width: 100%;
      }
#floating-panel {
  position: absolute;
  top: 10px;
  left: 25%;
  z-index: 5;
  background-color: #fff;
  padding: 5px;
  border: 1px solid #999;
  text-align: center;
  font-family: 'Roboto','sans-serif';
  line-height: 30px;
  padding-left: 10px;
}

    </style>
  </head>
  <body>
        <%request.setCharacterEncoding("utf-8");
       	String ad_list = request.getParameter("ad_list");
         List<String> list = new ArrayList<String>();

         StringTokenizer tokenizer = new StringTokenizer(ad_list, ",");
         //String count=Integer.toString(tokenizer.countTokens());
        
         int count=tokenizer.countTokens();
        
   %>
   <script>
   

   
   var i =0;
	var address2 = [];

   <% while(tokenizer.hasMoreTokens()){
       //System.out.println("Token is : "+ tokenizer.nextToken());
   		list.add(tokenizer.nextToken());    
   }
   
   %>
   
   <%for(int i=0; i<list.size(); i++){
	   System.out.println("list:" +list.get(i));
   %>
   address2[<%=i%>]='<%=list.get(i)%>';
   <%}%>
   </script>

    <div id="map"></div>
    <script>



function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 16,
    center: {lat: -34.397, lng: 150.644}
  });
  var geocoder = new google.maps.Geocoder();

  for(i=0; i<address2.length; i++){
  geocoder.geocode({'address': address2[i]}, function(results, status) {
    if (status === google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      
      var marker = new google.maps.Marker({
        map: map,
        position: results[0].geometry.location
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
  }
  
}



    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAroo00lZc2VzIMzy0o8Aj4QSTYB-WW5_0&callback=initMap"
        async defer></script>
  </body>
</html>