// When an AJAX request is sent successfully, the "favorited" class
// is toggled on the element.
function favoriteImage() {
  $("#img-action-favorite").parent("a[data-remote]").on("ajax:success", function(e, data, status, xhr) {
    $("#img-action-favorite").toggleClass("favorited");
  });
}

var ready = function() {
  favoriteImage();
};

$(document).ready(ready);
