import $ from 'jquery';

function tabbedMenu() {
  var tabs = document.querySelectorAll("ul.user-page-header-tabs li");
  for (var i = 0; i < tabs.length; i++) {
    tabs[i].addEventListener("click", function(e) {
      var tabid = e.target.getAttribute("data-tab");

      // De-emphasize currently selected tab.
      document.querySelector(".user-page-header-tabs li.current").classList.remove("current");

      // Hide current tab contents.
      document.querySelector(".tab-content.current").classList.remove("current");

      // Set tab element that was clicked to the current tab.
      e.target.classList.add("current");

      // Display it's respective tab contents.
      document.querySelector(".tc-" + tabid).classList.add("current");
    });
  }
}

function followUser() {
  $("#user-follow").parent().on("ajax:success", toggleUserFollowButtons);
  $("#user-unfollow").parent().on("ajax:success", toggleUserFollowButtons);
}

function toggleUserFollowButtons() {
  $("#user-follow").toggleClass("active").toggleClass("inactive");
  $("#user-unfollow").toggleClass("active").toggleClass("inactive");
}

var ready = function() {
  if (document.querySelector(".user-page-header-tabs")) {
    tabbedMenu();
    followUser();
  }
};

document.addEventListener("turbolinks:load", ready);
