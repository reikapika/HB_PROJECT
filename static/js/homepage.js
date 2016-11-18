$(function () {

    function stayOnPage(evt){
        evt.preventDefault();

        var data = $("#select-val").val();
        console.log(data);
        $.post("/restaurant_list", {'data': data}, stayOnPageSuccess);
      }

      function stayOnPageSuccess(names){
        var restaurants = names.names;
        for (i = 0; i < restaurants.length; i++) {
            $("#lb1").html(restaurants);
        }
      }

      $("#cuisine-btn").on("click", stayOnPage);

});