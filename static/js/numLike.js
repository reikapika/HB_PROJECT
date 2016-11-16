$(function () {


  function addLike(evt) {

    var formValue = $('#like-it').val();
    $.post("/like_rest.json", {'restaurant_id': formValue }, addLikeSuccess);
  }

  function addLikeSuccess(result){
    console.log(result);
    console.log(result.status);
    if (result.status === "ok") {
      $('#fake-flash').html('I"m loving it!!');
      $('#like').html('Unlike');
      $('#num_likes').html(result.num_likes);
    } else {
      $('#fake-flash').html('Um, I"m no longer with them');
      $('#like').html('Like');
      $('#num_likes').html(result.num_likes);
    }
  }

  $('#like-it').on('click', addLike);

});

