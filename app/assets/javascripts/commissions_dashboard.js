$(document).on("click", ".dashboard-subcategory", function(ev) {
  var className = $(ev.target).attr("class");
  console.log(className);
  var category = className.match(/dashboard-subcategory-(\w|-)+/)[0];
  console.log(category);
  var sc = category.replace("dashboard-subcategory", "dashboard-content");
  console.log(sc);
  $(".dashboard-subcategory.active").removeClass("active");
  $(".dashboard-content-inner.active").removeClass("active");
  $(ev.target).addClass("active");
  $("." + sc).addClass("active");
});
