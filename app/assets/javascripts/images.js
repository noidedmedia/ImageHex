// Stage 1: Click to resize the image within a reasonable width
var stageone = function() {
  console.log("Power to stage one emitters in 3... 2... 1...");
  var maxwidth = $(this).width();
  var image = $(this).find("img");
  // Unforunately, due to JavaScript being bad, we gotta load this
  // image again
  var newimg = new Image();
  newimg.src = $(this).find("img").attr("src");
  var realw = newimg.naturalWidth;
  var realh = newimg.naturalHeight;
  // TERRIBLE HACK INCOMING
  // JQuery doesn't easily let you remove rules set in stylesheets.
  // It does, however, let you over-ride them
  // So we just set max-height to a REALLY BIG NUMBER. Just in case.
  image.css("width", image.width());
  image.css("max-height", 1231231231231);
  if (maxwidth > realw) {
    image.stop().animate({ width: realw}, 250, "linear", function() {
      $(this).parent().unbind("click");
      $(this).parent().on("click", stagethree);
    });
  }
  else { 
    image.stop().animate({width: maxwidth}, 250, "linear", function() {
     console.log("Animation over");
     $(this).parent().unbind("click");
     $(".image").on("click", stagetwo);
    }); 
  } 
};

var stagetwo = function() {
  var image = $(this).find("img");
  // Same gross hack from before
  image.css("max-width", 212312312312323123);
  image.css("width", "");
  $(this).parent().unbind("click");
  $(".image").on("click", stagethree);
};

var stagethree = function() {
  console.log("STAGE THREE");
  var image = $(this).find("img");

  image.css("width", "");
  image.animate({'max-width': '75vw', 'max-height': '80vh'}, 250, function() {
  $(this).parent().unbind("click");
  $(".image").on("click", stageone);
  });
};

var ready = function() {
  $(".image").on("click", stageone);
};

$(document).on("ready", ready);
