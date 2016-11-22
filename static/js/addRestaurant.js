$(function () {
  
  //Getting user location from browser
    
  $("#myBtn").on("click", function(evt){
      evt.preventDefault();

      var name = $('#name').val();

        // if (navigator.geolocation) {
        //     navigator.geolocation.getCurrentPosition(function(position){
        //     var pos = {lat: position.coords.latitude,
        //          lng: position.coords.longitude,
        //          name: name
        //          };

      $.post("/check_restaurant.json", {'name': name}, checkRestaurantSuccess);

    });


    function checkRestaurantSuccess(result){
      console.log(result);
      
      if (result.status==='prohibited'){
          alert("Sorry, you don't have access to this. Please log in.");
      
      } else {
          $("#myModal").modal({backdrop: true});

          if (result.status==='True'){
            var restaurant = result.restaurant;
            console.log(restaurant.categories[0].title);
            console.log(restaurant.name);
            $('#restaurant').html(restaurant.name);
            $('#address').html(restaurant.location.address1 + ' ' + restaurant.location.address2);
            $('#citystate').html(restaurant.location.city + ', ' + restaurant.location.state + ' ' + restaurant.location.zipcode);
            $('#phone').html(restaurant.phone);
            $('#img1').attr('src', restaurant.image_url);
            document.getElementById('cuisine').value = restaurant.categories[0].title;

          } else if (result.status==='Not Found'){
              $('#restaurant').html('Please enter a valid restaurant name.');
     
          } else{
              $('#restaurant').html('Please enter an Asian restaurant and try again.');
          }
      }
  }

  ///when user confirms, add this restaurant to database.
    $('#confirm').on('click', addRestaurant);

    function addRestaurant(evt){
        evt.preventDefault();
        var restaurant = $('#name').val();
        var cuisineId = $('#cuisine').val();
        console.log(cuisineId);

        var data = {name: restaurant,
                    cuisine: cuisineId
                  };

        console.log(data);

        $.post("/add_restaurant.json", data, addRestaurantSuccess);
    }

    function addRestaurantSuccess(result){
        console.log(result);
        $('#myModal').modal('hide');
    }
});