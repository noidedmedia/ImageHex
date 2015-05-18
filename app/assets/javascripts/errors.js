// Close the Alert dialog when the close icon is clicked.
function hideError() {
  $("#alert-close").on("click", function() {
    $(".alert").css("display", "none");
  });
}

var ready = function() {
  hideError();
};

$(document).ready(ready);
