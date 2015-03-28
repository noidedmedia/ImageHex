// A simple library to do a lot of things in-place with AJAX.
// Commented heavily so as to properly explain how it works.

/*
 *  The show-on property hides a DOM node until another node is clicked.
 *  To use, simply set the data-showon attribute with the Jquery selector
 *  for the node which will show whatever is initially hidden. 
 */
var showon = function() {
  var showondiv = $("div").filter(function(index) {
    return $(this).data("showon");
    // Elements with data in the "showon" property are hidden from the start,
    // appearing only when the selector specified by showon is clicked
  });
  showondiv.each(function() {
    var _this = this;
    $(_this).addClass('inactive').removeClass('active');
    var toggle = $($(_this).data("showon"));
    $(toggle).on("click", function() {
      $(_this).toggleClass('active').toggleClass('inactive');

      if ( $(toggle).hasClass("image-actions") || $(toggle).children().hasClass("image-actions") ) {
        console.log("test.");
        $(".image-actions-tooltip").not(_this).removeClass('active').addClass('inactive');
      }
    });
  });
};

var loadform = function(node) {
  return function() {
    node.load(node.data("editform"), function() {
      console.log(this);
      $('form').fadeIn("normal");
    });
  };
};

// This function finds all elements with the data-editform attribute set.
// It will load the provided form when the provided toggle (in data-toggle)
// is clicked.
var formprep = function() {
  var nodes = $("div").filter(function(index) {
    return $(this).data("editform");
  });
  nodes.each(function(index) {
    // Set the toggle here:
    var toggle = $(this).find($(this).data("toggle"));
    // load_form returns a closure which loads the form
    toggle.on("click", loadform($(this)));
  });
};

var ready = function() {
  showon();
  formprep();
};

$(document).ready(ready);
