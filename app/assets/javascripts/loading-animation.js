Turbolinks.ProgressBar.setDelay(0);

$(document).on("page:before-change", function() {
  var w = $("#header-logo .hexagons");
  w.addClass("rotating");
});

$(document).on("page:change", function() {
  window.requestAnimationFrame(function() {
    $("#header-logo .hexagons").removeClass("rotating");
  });
});
