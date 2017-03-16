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
       	String name_list1 = request.getParameter("name_list");
         List<String> list = new ArrayList<String>();
         List<String> add_list = new ArrayList<String>();
         List<String> list2 = new ArrayList<String>();
         List<String> name_list = new ArrayList<String>();

         StringTokenizer tokenizer = new StringTokenizer(ad_list, ",");
         StringTokenizer tokenizer_name = new StringTokenizer(name_list1, ",");
         //String count=Integer.toString(tokenizer.countTokens());
        
         int count=tokenizer.countTokens();
         int count_name=tokenizer.countTokens();
        
   %>
   <script>


   //주소 배열 만들기

	var address2 = [];
	var name_view = [];

   <% while(tokenizer.hasMoreTokens()){
       //System.out.println("Token is : "+ tokenizer.nextToken());
   		list.add(tokenizer.nextToken());    
   }
   
   %>
   
   <%
   String result_ad="";
   for(int i=0; i<list.size(); i++){
	   //System.out.println("list:" +list.get(i));
	   
	   String add=list.get(i);
	   
	   boolean open = false;
		for(int j=0; j<add.length(); j++){
		
			if(add.charAt(j)=='['||add.charAt(j)==']'){
			}else{
				if(add.charAt(j)=='('){
					open=true;
				}else if(add.charAt(j)==')'){
					open=false;
				}
				result_ad+=add.charAt(j);
			}
			
		}
		if(!open){
		//result_ad+="/";
		//System.out.println(result_ad);
		add_list.add(result_ad);
		result_ad="";
		}
   %>
   //address2[<%=i%>]='<%=list.get(i)%>';
   <%}
   //System.out.println(result_ad);
   for(int adcount=0; adcount<add_list.size(); adcount++){
	   System.out.println("addlist:"+add_list.get(adcount));%>
	   address2[<%=adcount%>]='<%=add_list.get(adcount)%>';
   <%}
   %>
   
   //이름 배열 만들기
	

   <% while(tokenizer_name.hasMoreTokens()){
       //System.out.println("Token is : "+ tokenizer.nextToken());
   		list2.add(tokenizer_name.nextToken());    
   }
   
   %>
   
   
   <%
   String result_name="";
   for(int i=0; i<list2.size(); i++){
	   
	   String name_tmp=list2.get(i);
	   
	   boolean open = false;
		for(int j=0; j<name_tmp.length(); j++){
		
			if(name_tmp.charAt(j)=='['||name_tmp.charAt(j)==']'){
			}else{
				if(name_tmp.charAt(j)=='('){
					open=true;
				}else if(name_tmp.charAt(j)==')'){
					open=false;
				}
				result_name+=name_tmp.charAt(j);
			}
			
		}
		if(!open){
		//result_ad+="/";
		//System.out.println(result_ad);
		name_list.add(result_name);
		result_name="";
		}
   %>
   <%}
   for(int namecount=0; namecount<name_list.size(); namecount++){
	   System.out.println("name_list:"+name_list.get(namecount));%>
	   name_view[<%=namecount%>]='<%=name_list.get(namecount)%>';
   <%}
   %>
   function name2(){
	   alert(name_view[0]);
   }
 
   </script>
<input type="button" onclick="name2()" value="name">
    <div id="map"></div>
    <script>



function initMap() {

  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 16,
    center: {lat: -34.397, lng: 150.644}
  });
  //내위치 찾기
  
  var infoWindow = new google.maps.InfoWindow({map: map});
  var infowindow2 = new google.maps.InfoWindow();

/*   if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        var pos = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };

        infoWindow.setPosition('hi');
        infoWindow.setContent('Location found.');
        map.setCenter(pos);
      }, function() {
        handleLocationError(true, infoWindow, map.getCenter());
      });
    } else {
      // Browser doesn't support Geolocation
      handleLocationError(false, infoWindow, map.getCenter());
    } */


 
  
//지오코더
  var geocoder = new google.maps.Geocoder();
  var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';


  for(i=0; i<address2.length; i++){

  geocoder.geocode({'address': address2[i]}, function(results, status) {
	  for(j=0; j<name_view.length; j++){
    if (status === google.maps.GeocoderStatus.OK) {
    	
      map.setCenter(results[0].geometry.location);
     
       var marker = new google.maps.Marker({
        map: map,
        position: results[0].geometry.location,
        label: name_view[i],
      }); 
/*       for (var i = 0, result; result = results[i]; i++) {
    	    addMarker(result);
    	  }
      function addMarker(place) {
    	  var marker = new google.maps.Marker({
    		  map: map,
    	        position: results[0].geometry.location
    	  });

    	  google.maps.event.addListener(marker, 'click', function() {
    	  	    service.getDetails(place, function(result, status) {
    	  	      if (status !== google.maps.places.PlacesServiceStatus.OK) {
    	  	        console.error(status);
    	  	        return;
    	  	      }
    	  	      infoWindow2.setContent('hi');
    	  	      //result.name
    	  	      infoWindow2.open(map, marker);
    	  	    });
    	  	  });
    	} */
     

      
       google.maps.event.addListener(marker, 'click', function() {
    	  infowindow2.setContent(name_view[j]);
    	  infowindow2.open(map, this);
    	  }); 
    
    } else {
    	//alert(address2[i]);
    }
	  }//j if
  });
  }
  
}
function handleLocationError(browserHasGeolocation, infoWindow, pos) {
    infoWindow.setPosition(pos);
    infoWindow.setContent(browserHasGeolocation ?
                          'Error: The Geolocation service failed.' :
                          'Error: Your browser doesn\'t support geolocation.');
  }




    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAroo00lZc2VzIMzy0o8Aj4QSTYB-WW5_0&callback=initMap"
        async defer></script>
  </body>
</html>