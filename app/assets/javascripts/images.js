// Function adds a confirmation dialog to the "Delete" button on images.
function deleteButtonAlert() {
  $("#img-action-delete").on("click", function(e) {
    return confirm("Delete this image?");
  });
}

// If the "Cancel" button is pressed in the Report tooltip, the tooltip will be closed.
function cancelReportButton() {
  document.querySelector("#report-cancel-button").addEventListener("click", function() {
    document.querySelector("#img-action-report-tooltip").classList.toggle("active");
    document.querySelector("#img-action-report-tooltip").classList.toggle("inactive");
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
        var tooltip = document.querySelector("#img-action-collection-tooltip");

        // Hides the Collection Tooltip once the request has completed.
        tooltip.classList.remove("active");
        tooltip.classList.add("inactive");
      }
    });
  });
}

var ready = function() {
  deleteButtonAlert();

  if (document.querySelector("#report-cancel-button")) {
    cancelReportButton();
  }
  
  if (document.querySelector(".add-to-collection-form")) {
    addToCollection();
  }
};

document.addEventListener("page:change", ready);
