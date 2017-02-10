function checkIfEmpty() {
  $(".input:not(.react-input)").each(function() {
    if ( $(this).val() === "" ) {
      $(this).siblings("label").addClass("input-empty");
    } else {
      $(this).siblings("label").removeClass("input-empty");
    }    
  });
  $(".input:not(.react-input)").on("input", function() {
    if ( $(this).val() === "" ) {
      $(this).siblings("label").addClass("input-empty");
    } else {
      $(this).siblings("label").removeClass("input-empty");
    }    
  });
}


var ready = function() {
  checkIfEmpty();
};

document.addEventListener("turbolinks:load", ready);
