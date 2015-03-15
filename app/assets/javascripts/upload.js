function fileUpload() {
  $("#file-field").on("dragenter", function() {
    console.log("Drag entered.");
  });

  $("#file-field").on("dragleave", function() {
    console.log("Drag left.");
  });

  $("#file-field").on("drop", addedFiles);
}

function addedFiles(event) {
    console.log("Drop.");

    var files = event.originalEvent.dataTransfer.files;

    handleFiles(files);
  }

function handleFiles(files) {
  if (files) {
    console.log("Display upload container.");
    $(".upload-container").addClass("active");

    console.log("Display submit button.");
    $("#upload-submit-button").addClass("active");
  }
}

var ready = function() {
  if (window.location.href.search("images/new") >= 0) {
    console.log("Upload page only!");
    fileUpload(); 
  }
};

$(document).ready(ready);
