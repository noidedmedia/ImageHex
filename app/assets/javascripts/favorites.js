// When an AJAX request is sent successfully, the "favorited" class
// is toggled on the element.
function favoriteImage() {

  $("#img-action-favorite a[data-remote]").on("ajax:success", toggleFavoriteActive);
  $("#img-action-favorited a[data-remote]").on("ajax:success", toggleFavoriteActive);
}

function toggleFavoriteActive() {
  var imageActionFavorite = document.querySelector("#img-action-favorite").classList,
      imageActionFavorited = document.querySelector("#img-action-favorited").classList;

  imageActionFavorite.toggle('active');
  imageActionFavorite.toggle('inactive');
  imageActionFavorited.toggle('active');
  imageActionFavorited.toggle('inactive');
}

var ready = function() {
  favoriteImage();
};

document.addEventListener('page:change', ready);
