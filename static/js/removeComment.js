$(function () {


  $(".remove").on("click", function(evt){
      evt.preventDefault();
      
      id = $(this).data('comment-id');

      console.log(id);
      $.post("/remove_comment.json", {'id': id}, removeCommentSuccess);

    });

  function removeCommentSuccess(result){

      var id = result.id;
      console.log(id);
      $('#comment-' + id).fadeOut();

      }

});