

var map;
var directionsDisplay;
var directionsService;

function initMap() {
    
    directionsDisplay = new google.maps.DirectionsRenderer;
    directionsService = new google.maps.DirectionsService;
    map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: restLatlng.lat, lng: restLatlng.lng},
          zoom: 12
    });
    directionsDisplay.setMap(map);


    if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      
      var pos = {
                 lat: position.coords.latitude,
                 lng: position.coords.longitude
      };


    var selectedMode = document.getElementById('mode').value;
      
    directionsService.route({
        origin: pos,
        destination: restLatlng,
      // Note that Javascript allows us to access the constant
      // using square brackets and a string value as its
      // "property."
      travelMode: google.maps.TravelMode[selectedMode]
    }, function(response, status) {
      if (status == 'OK') {
        directionsDisplay.setDirections(response);
      } else {
        window.alert('Directions request failed due to ' + status);
      }
    });

  }, function() {
        handleLocationError(true, infoWindow, map.getCenter());
      });
    } else {
      // Browser doesn't support Geolocation
      handleLocationError(false, infoWindow, map.getCenter());
    }
  }

initMap();

 // var infowindow = new google.maps.InfoWindow({
 //      content: contentString
 //    });

 //      marker.addListener('click', function() {
 //      infowindow.open(map, marker);
 //    });


  function handleLocationError(browserHasGeolocation, infoWindow, pos) {
    infoWindow.setPosition(pos);
    infoWindow.setContent(browserHasGeolocation ?
                          'Error: The Geolocation service failed.' :
                          'Error: Your browser doesn\'t support geolocation.');
  }

  

















//WORKING GOOGLE MAP
// var userLatlng = {lat: {{ rest_info['coordinates']['latitude'] }},
//                   lng: {{ rest_info['coordinates']['longitude'] }}};
// var map;
// function initMap() {
//   map = new google.maps.Map(document.getElementById('map'), {
//     center: {lat: userLatlng.lat, lng: userLatlng.lng},
//     zoom: 12
//     // zoomControl: true,
//   });
//   var marker = new google.maps.Marker({
//     position: userLatlng,
//     icon: 'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_local_restaurant_48px-32.png',
//     map: map
//   });

//   var contentString = '<div><h3>{{ rest_info['name'] }}</h3></div>' + 
//            '<div><p>{{ rest_info['location']['address1'] }}</p>' +
//            '<p>{{ rest_info['location']['city'] }}, {{ rest_info['location']['state'] }}</p></div>'
//            + '<a>Direction</a>';
//   var infowindow = new google.maps.InfoWindow({
//   content: contentString
//   });

//   marker.addListener('click', function() {
//   infowindow.open(map, marker);
//   });

//  }
