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
    $(_this).addClass("inactive").removeClass("active");
    
    // "data-showon" should have a value with the name (e.g. class or id) of
    // the button that toggles the element with the "data-showon" property.
    // The following line sets "toggle" equal to a jQuery selector for said
    // value.
    var toggle = $( $(_this).data("showon") );
    $(toggle).on("click", function() {
      $(toggle).toggleClass("active");
      $(_this).toggleClass("active").toggleClass("inactive");

      // If the element being pressed is an "image-action" (or is the child of 
      // such an element, for compatibility reasons) in the image page sidebar,
      // all other open image-action tooltips will be closed when the element
      // is pressed.
      if ( $(toggle).hasClass("image-actions") || $(toggle).children().hasClass("image-actions") ) {
        $(".image-actions-tooltip").not(_this).removeClass("active").addClass("inactive");
      }

      // If data-clickoutside="true" then the clickoutside event is binded to the
      // relevant element.
      if ( $(_this).data("clickoutside") === true ) {

        // This prevents "bubbling up" of the click event when it's within the
        // dialog, to prevent "clickoutside" from erroneously running the
        // active toggle function when the click is within the dialog.
        $(_this).bind("click", function(event) {
          event.stopPropagation();
        });

        // Binds a function to toggle the active/inactive classes on the dialog
        // to clicking outside the button that toggles the dialog.
        // Binding "clickoutside" to the dialog itself doesn't work, because
        // the toggle is technically outside the dialog and the dialog's
        // active classes are removed before it's able to display.
        $(toggle).bind("clickoutside", function() {
          $(_this).removeClass("active").addClass("inactive");
          $(_this).unbind("clickoutside");
        });
      }
    });
  });
};

var loadform = function(node) {
  return function() {
    node.load(node.data("editform"), function() {
      console.log(this);
      $("form").fadeIn("normal");
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

document.addEventListener("turbolinks:load", ready);
