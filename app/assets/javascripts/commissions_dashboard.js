import $ from 'jquery';

$(document).on("click", ".dashboard-subcategory", function(ev) {
  var className = $(ev.target).attr("class");
  console.log("Clicked on: ", className);
  var category = className.match(/dashboard-subcategory-(\w|-)+/)[0];
  console.log("Replacing CSS: ", category);
  var sc = category.replace("dashboard-subcategory", "dashboard-content");
  console.log("Activating: ", sc);
  $(".dashboard-subcategory.active").removeClass("active");
  $(".dashboard-content-inner.active").removeClass("active");
  $(ev.target).addClass("active");
  $("." + sc).addClass("active");
});
