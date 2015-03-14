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

  $(".mark-all-read").on("click", function() {
    $(".notifications-unread-count a").html("0");
    $(".header-notifications").removeClass("unread");
  });
}

var ready = function() {
  notificationsDropdown();
};

$(document).ready(ready);