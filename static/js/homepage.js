$(function () {

    function stayOnPage(evt){
        evt.preventDefault();

        var data = $("#select-val").val();
        console.log(data);
        $.post("/", {'data': data}, stayOnPageSuccess);
      }

      function stayOnPageSuccess(result){
        // var rand = restaurant_dict;
        console.log(result);
        // for (i = 0; i < restaurants.length; i++) {
        //     $("myCarousel").html(restaurants);
        // }
      }

      $("#cuisine-btn").on("click", stayOnPage);

});