function deleteButtonAlert() {
  $("#img-action-delete").on("click", function(e) {
    return confirm("Are you sure?");
  });
}

// Function runs when the document is "ready".
$(document).ready(function(){
  deleteButtonAlert();
});
