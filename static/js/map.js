
var userLatlng = {lat: {{ rest_info['coordinates']['latitude'] }},
                  lng: {{ rest_info['coordinates']['longitude'] }}};
var map;
function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: userLatlng.lat, lng: userLatlng.lng},
    zoom: 12
    // zoomControl: true,
  });
  var marker = new google.maps.Marker({
    position: userLatlng,
    icon: 'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_local_restaurant_48px-32.png',
    map: map
  });

  var contentString = '<div><h3>{{ rest_info['name'] }}</h3></div>' + 
           '<div><p>{{ rest_info['location']['address1'] }}</p>' +
           '<p>{{ rest_info['location']['city'] }}, {{ rest_info['location']['state'] }}</p></div>'
           + '<a>Direction</a>';
  var infowindow = new google.maps.InfoWindow({
  content: contentString
  });

  marker.addListener('click', function() {
  infowindow.open(map, marker);
  });

 }
