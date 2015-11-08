/*
 * The purpose of this function is to prevent the display of certain dialogs
 * if the user isn't signed in, determined by whether or not a "signed-in"
 * class existing on the body element.
 * The function will pass all divs with the "data-signed-in" attribute to be
 * processed and evaluated to prevent 
 */
var signedin = function() {
  // If the body element doesn't have the "signed-in" class, the variable
  // is declared. Otherwise, nothing happens.
  if ( $("body").hasClass("signed-in") === false ) {
    var signedindiv = $("div, button, form").filter(function(index) {
      // Returns all "div" elements with the data-signed-in attribute.
      return $(this).data("signed-in");
    });
    
    signedindiv.each(function() {
      var _this = this;
      
      // If the element has a "data-signed-in" property set to "showon",
      // this implies that the element also has a "data-showon" property
      // which is then utilized to prevent the button from being toggled by
      // its respective partner element. Following that, the signInDialog
      // function is called.
      if ( $(_this).data("signed-in") === "showon" ) {
        $(_this).addClass("not-signed-in");

        var showontoggle = $( $(_this).data("showon") );
        $(showontoggle).on("click", function(e) {
          e.preventDefault();
          signInDialog();
          return false;
        });
      }
      
      // If the element represented by "_this" sends an AJAX request, and
      // requires being signed in, the "data-signed-in" property should
      // be set to "ajax" and the following function will call the
      // signInDialog function and prevent the AJAX request from returning
      // a "true" value.
      else if ( $(_this).data("signed-in") === "ajax" ) {
        if ( $(_this).is("div") ) {
          $(_this).on("click", function(e) {
            e.preventDefault();
            signInDialog();
            return false;
          });
        } else if ( $(_this).is("form") ) {
          $(_this).children().on("click", function(e) {
            e.preventDefault();
            signInDialog();
            return false;
          });
        }
      }
    });
  }
};

// This function is called when the user isn't signed in and attempts to 
// complete an action that shouldn't be available to a user without an
// account (e.g. favoriting an image or following another user).
// 
// It creates a modal dialog that tells the user that they're "not able to
// complete that action" without signing in, and directs them to either the
// Sign In or Create Account pages.
function signInDialog() {
  $("body").addClass("modal-open");
  $("#modal-overlay").addClass("active");
  $("#modal-dialog").bind("clickoutside", function() {
    $("body").removeClass("modal-open");
    $("#modal-overlay").removeClass("active");
    $("#modal-overlay").unbind("click");
  });
  // $("#modal-dialog > p").html("This action requires an account, please sign in.");
}

var ready = function() {
  signedin();
};

document.addEventListener('page:change', ready);
