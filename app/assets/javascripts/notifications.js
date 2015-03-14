function notificationsDropdown() {
  $(".notifications-unread-count a").on("click", function(event) {
    event.preventDefault();
    $(".notifications-dropdown").toggleClass("active").toggleClass("inactive");
    $(".header-notifications").toggleClass("active");

    $(".header-notifications").bind("clickoutside", function() {
      $(".notifications-dropdown").removeClass("active").addClass("inactive");
      $(".header-notifications").removeClass("active");

      $('.header-notifications').unbind("clickoutside");
    });
  });
}

var ready = function() {
  notificationsDropdown();
};

$(document).ready(ready);