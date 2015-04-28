// When an AJAX request is sent successfully, the "active" class
// is toggled on both elements.
function followCollection() {
  $("#collection-follow").parent().on("ajax:success", toggleCollectionFollowButtons);
  $("#collection-unfollow").parent().on("ajax:success", toggleCollectionFollowButtons);
}

function toggleCollectionFollowButtons() {
  $("#collection-follow").toggleClass("active").toggleClass("inactive");
  $("#collection-unfollow").toggleClass("active").toggleClass("inactive");
}

var ready = function() {
  followCollection();
};

$(document).ready(ready);
