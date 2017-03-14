<%@page import="java.util.ArrayList"%>
<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="java.util.List"%>
<%@page import="store.StoreDAO"%>
<html>
  <head>
    <title>Place details</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <style>
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #map {
        height: 80%;
      }
    </style>


  </head>
  <body>
        <%request.setCharacterEncoding("utf-8");
       	String ad_list = request.getParameter("ad_list");
         System.out.println("ad_list:"+ad_list);
         List<String> list = new ArrayList<String>();

         StringTokenizer tokenizer = new StringTokenizer(ad_list, ",");
         int count=tokenizer.countTokens();
   %>
   <script>
   var address2 = [];
   var i =0;
   <% while(tokenizer.hasMoreTokens()){
       //System.out.println("Token is : "+ tokenizer.nextToken());
   		list.add(tokenizer.nextToken());    
   }%>
   for(i=0; i<<%=count%>; i++){
	   address2[i]=<%=list.get(1)%>;
   }
   


   </script>
   <div id="floating-panel">
      <input id="address" type="textbox" value="부산역">
      <input id="submit" type="button" value="Geocode">
    </div>
    <div id="map"></div>
    <script>


function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 8,
    center: {lat: -34.397, lng: 150.644}
  });
  var geocoder = new google.maps.Geocoder();

  document.getElementById('submit').addEventListener('click', function() {
    geocodeAddress(geocoder, map);
  });
}

function geocodeAddress(geocoder, resultsMap) {
	var address = document.getElementById('address').value;
	

	alert(address2[1]);
  geocoder.geocode({'address': address}, function(results, status) {
    if (status === google.maps.GeocoderStatus.OK) {
      resultsMap.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
        map: resultsMap,
        position: results[0].geometry.location
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });

}

    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAroo00lZc2VzIMzy0o8Aj4QSTYB-WW5_0&callback=initMap"
        async defer></script>
  </body>


</html>