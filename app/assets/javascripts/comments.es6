document.addEventListener("page:change", function() {
  var comments = document.getElementsByClassName("comment-reply");
  if (comments.length == 0) {
    return;
  }

  for (var i = 0; i < comments.length; i++) {
    var comment = comments[i];
    comment.addEventListener("click", function(e) {
      var name = this.dataset.userName;
      var area = document.getElementById("comment_body");
      area.value += "@" + name + " ";
      area.focus();
    });
  }
});
