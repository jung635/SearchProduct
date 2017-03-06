<!DOCTYPE html>
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
       <%
   String ad_id= request.getParameter("ad_id");
   %>
    <script>
    var ad_id='<%=ad_id%>';
function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -33.866, lng: 151.196},
    zoom: 15
  });

  var infowindow = new google.maps.InfoWindow();
  var service = new google.maps.places.PlacesService(map);

  service.getDetails({
	 placeId: ad_id
    //placeId: 'ChIJ0RmaiWXraDUR6zFpyz0rv-w'
  }, function(place, status) {
    if (status === google.maps.places.PlacesServiceStatus.OK) {
      var marker = new google.maps.Marker({
        map: map,
        position: place.geometry.location
      });
      if (place.geometry.viewport) {
          map.fitBounds(place.geometry.viewport);
        } else {
          map.setCenter(place.geometry.location);
          map.setZoom(17);
        }
      google.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent(place.name);
        infowindow.open(map, this);
      });
    }
  });
}

    </script>
  </head>
  <body>

    <div id="map"></div>
    <script
src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAroo00lZc2VzIMzy0o8Aj4QSTYB-WW5_0&libraries=places&callback=initMap" async defer></script>

  </body>
</html>