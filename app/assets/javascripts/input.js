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


var ready = function() {
  checkIfEmpty();
};

document.addEventListener("page:change", ready);

