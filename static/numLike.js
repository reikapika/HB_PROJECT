$(function () {


    function addLike(evt) {

        $.post("/like_rest.json", {'restaurant_id': restaurantId }, addLikeSuccess);
}

    function addLikeSuccess(result) {

        console.log(result.status);
        $("#like-it").text('Unlike');
        alert('You have already liked it.');
}
    function unLike(evt) {

        $.delete("/like_rest.json", {'restaurant_id': restaurantId }, unLikeSuccess);
}

    function unLikeSuccess(result) {

        console.log(result.status);
        alert('You have already liked it.');
}

    var restaurantId = $("#like-it").val();
    var btnAttr = $('#like-it').text();
    console.log(btnAttr);
        
    if (btnAttr === 'like'){
        $("#like-it").on("click", addLike);
    } else {
        $("#like-it").on("click", unLike);
}
    
});


     // if (result.status === 'added'){
        //     $.delete("/like_rest.json", {'restaurant_id': restaurantId }, addLikeSuccess);
            
        // } else {
        // var num_likes = result.num_likes;
        // $('#num_likes').html('num_likes');
        // $('.glyphicon glyphicon-thumbs-up').attr('glyphicon glyphicon-thumbs-up', 'glyphicon glyphicon-thumbs-down');
        // alert('You have successfully liked this restaurant!');
        // }