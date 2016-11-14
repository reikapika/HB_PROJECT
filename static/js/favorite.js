$(function () {

    function addFavorite(evt) {

        var restaurantId = $("#fav-restaurant").val();

        $.post("/add_to_favlist.json", {'restaurant_id': restaurantId }, addToFavoritesSuccess);
    }

    function addToFavoritesSuccess(result) {

        console.log(result.status);
        if (result.status === 'added'){
            $('#fav-restaurant').disabled = true;
            alert('You already added this restaurant.');
        } else {
            var restaurantId = result.restaurantId;
            $('#fav-restaurant').css('color', 'grey');
            alert('You have successfully added to My Favorites!');
        }
    }
    
    $("#fav-restaurant").on("click", addFavorite);
});
