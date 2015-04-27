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

// Functions run when the document is "ready".
$(document).ready(function() {
  deleteButtonAlert();
  cancelReportButton();
});
