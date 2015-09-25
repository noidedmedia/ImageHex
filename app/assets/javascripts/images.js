// Function adds a confirmation dialog to the "Delete" button on images.
function deleteButtonAlert() {
  $("#img-action-delete").on("click", function() {
    return confirm("Delete this image?");
  });
}

// If the "Cancel" button is pressed in the Report tooltip, the tooltip will be closed.
function cancelReportButton() {
  $("#report-cancel-button").on("click", function() {
    $("#img-action-report-tooltip").toggleClass('active').toggleClass('inactive');
  });
}

function addToCollection() {
  // Intercepts submission of the "Add to Collection" button press and does it remotely.
  $(".add-to-collection-form").submit(function(e) {   
    e.preventDefault();
    
    // For use in the AJAX request below.
    var _this = this;

    // http://api.jquery.com/jquery.ajax/
    $.ajax({
      type: "POST",
      url: this.action,
      data: $(this).serialize(),
      success: function() {
        // Hides the Collection Tooltip once the request has completed.
        $("#img-action-collection-tooltip").removeClass("active").addClass("inactive");

        // Use this once the Collection List function checks to see if the image
        // is already a member of each collection.
        // $(_this).addClass("check");
      }
    });
  });
}

// Functions run when the document is "ready".
$(document).ready(function() {
  deleteButtonAlert();
  cancelReportButton();
  addToCollection();
});
