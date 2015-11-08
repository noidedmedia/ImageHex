function notificationsDropdownDisplay() {
  $(".notifications-dropdown").toggleClass("active").toggleClass("inactive");
  $(".header-notifications").toggleClass("active");

  $(".header-notifications").bind("clickoutside", function() {
    $(".notifications-dropdown").removeClass("active").addClass("inactive");
    $(".header-notifications").removeClass("active");

    $('.header-notifications').unbind("clickoutside");
  });
}

function markAllRead() {
  $(".mark-all-read").on("click", function() {
    $(".notifications-unread-count a").html("0");
    $(".header-notifications").removeClass("unread");

    $(".notifications-dropdown").removeClass("active").addClass("inactive");
    $(".header-notifications").removeClass("active");
    $('.header-notifications').unbind("clickoutside");
  });
}

function notificationsDropdownGet() {
  $(".notifications-unread-count a").on("click", function(e) {
    e.preventDefault();

    $.ajax({
      type: "GET",
      url: "/notifications",
      dataType: "json",
      success: function(result) {
        console.log(result);
        notificationsDropdownDisplay();
      }
    });
  });
}

var ready = function() {

  var windowwidth = $(window).width();

  // Only run if the browser window doesn't imply a mobile device.
  if (windowwidth > '750') {
    notificationsDropdownGet();
    markAllRead();
  }
};

document.addEventListener('page:change', ready);
