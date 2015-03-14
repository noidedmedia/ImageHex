function notificationsDropdown() {
  $(".notifications-unread-count a").on("click", function(event) {
    event.preventDefault();
    $(".notifications-dropdown").toggleClass("active");

    $(".header-notifications").bind("clickoutside", function() {
      $(".notifications-dropdown").removeClass("active");

      $('.header-notifications').unbind("clickoutside");
    });
  });
}

var ready = function() {
  notificationsDropdown();
};

$(document).ready(ready);