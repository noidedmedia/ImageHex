// When an AJAX request is sent successfully, the "favorited" class
// is toggled on the element.
function favoriteImage() {
  $("#img-action-favorite").children("a[data-remote]").on("ajax:success", function(e, data, status, xhr) {
    $("#img-action-favorite").toggleClass("active").toggleClass("inactive");
    $("#img-action-favorited").toggleClass("active").toggleClass("inactive");
  });

  $("#img-action-favorited").children("a[data-remote]").on("ajax:success", function(e, data, status, xhr) {
    $("#img-action-favorite").toggleClass("active").toggleClass("inactive");
    $("#img-action-favorited").toggleClass("active").toggleClass("inactive");
  });
}

var ready = function() {
  favoriteImage();
};

$(document).ready(ready);
