$(function () {


  function addLike(evt) {

    $.post("/like_rest.json", {'restaurant_id': restaurantId }, addLikeSuccess);
}

  
});
$(".like-Unlike").click(addLike(result) {
  if ($(this).html() == "Like") {
      $(this).html('Unlike');
  }
  else {
      $(this).html('Like');
  }
  return false;
});​