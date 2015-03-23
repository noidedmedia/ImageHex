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

    $(".notifications-dropdown").removeClass("active").addClass("inactive");
    $(".header-notifications").removeClass("active");
    $('.header-notifications').unbind("clickoutside");
  });
}

var ready = function() {

  var windowwidth = $(window).width();

  // Only run if the browser window doesn't imply a mobile device.
  if (windowwidth > '750') {
    notificationsDropdown();
  }
};

$(document).ready(ready);