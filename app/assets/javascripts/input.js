function checkIfEmpty() {
  $(".input").each(function() {
    if ( $(this).val() === "" ) {
      $(this).siblings("label").addClass("input-empty");
      $(this).on("input", function() {
        console.log("test");
        if ( $(this).val() === "" ) {
          $(this).siblings("label").addClass("input-empty");
        } else {
          $(this).siblings("label").removeClass("input-empty");
        }    
      });
    } else {
      $(this).siblings("label").removeClass("input-empty");
    }    
  });
}

// Functions run when the document is "ready".
$(document).ready(function() {
  checkIfEmpty();
});
