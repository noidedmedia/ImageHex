// When an AJAX request is sent successfully, the "favorited" class
// is toggled on the element.
function favoriteImage() {
  $("#img-action-favorite").parent("a[data-remote]").on("ajax:success", function(e, data, status, xhr) {
    if ($("#img-action-favorite").hasClass("favorited")) {
      $("#img-action-favorite").toggleClass("favorited");
      $("#img-action-favorite").html("Favorite");
    } else {
      $("#img-action-favorite").toggleClass("favorited");
      $("#img-action-favorite").html("Favorited");
    }
  });
}

var ready = function() {
  favoriteImage();
};

$(document).ready(ready);
