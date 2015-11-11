function notificationsDropdownDisplay() {
  document.querySelector(".notifications-dropdown").classList.toggle("active");
  document.querySelector(".notifications-dropdown").classList.toggle("inactive");
  document.querySelector(".header-notifications").classList.toggle("active");

  document.querySelector(".notifications-dropdown").addEventListener("focusout", function(e) {
    document.querySelector(".notifications-dropdown").classList.remove("active")
    document.querySelector(".notifications-dropdown").classList.add("inactive");
    document.querySelector(".header-notifications").classList.remove("active");

    document.querySelector('.header-notifications').removeEventListener("focusout");
  });
}

function markAllRead() {
  document.querySelector(".mark-all-read").addEventListener("click", function() {
    document.querySelector(".notifications-unread-count a").textContent = "0";
    document.querySelector(".header-notifications").classList.remove("unread");

    document.querySelector(".notifications-dropdown").classList.remove("active");
    document.querySelector(".notifications-dropdown").classList.add("inactive");
    document.querySelector(".header-notifications").classList.remove("active");
    document.querySelector('.header-notifications').removeEventListener("focusout");
  });
}

function notificationsDropdownGet() {
  document.querySelector(".notifications-unread-count a").addEventListener("click", function(e) {
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

  var windowwidth = window.innerWidth;

  // Only run if the browser window doesn't imply a mobile device.
  if (windowwidth > '750' && document.getElementsByTagName('body')[0].classList.contains('signed-in')) {
    notificationsDropdownGet();
    markAllRead();
  }
};

document.addEventListener('page:change', ready);
