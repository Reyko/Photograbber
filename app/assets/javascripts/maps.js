var map;
function initialize(){
  var latitude = $(".photo").data("latitude");
  var longitude = $(".photo").data("longitude");

  var mapOptions = {
    center: new google.maps.LatLng(latitude, longitude),
    zoom: 8,
    scrollwheel: false
  };
  var location = document.getElementById("map-canvas");

  map = new google.maps.Map(location,mapOptions);
  addMarker(latitude, longitude);
}

function addMarker(lat,lng){
  var marker = new google.maps.Marker({
    position: new google.maps.LatLng(lat,lng),
    map:map
  })
}

$(document).ready(initialize);