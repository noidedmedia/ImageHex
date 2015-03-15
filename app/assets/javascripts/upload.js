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

    console.log(files);

    if (files) {
      handleFiles(files);
    }
  }

function handleFiles(files) {
  console.log("Display upload container.");
  $(".upload-container").addClass("active");

  console.log("Display submit button.");
  $("#upload-submit-button").addClass("active");

  for (var i = 0; i < files.length; i++) {
    $(".image-file-name").html(files[i].name);

    var img = document.createElement("img");
    img.src = window.URL.createObjectURL(files[i]);
    img.width = 348;
    img.onload = function() {
      window.URL.revokeObjectURL(this.src);
    }

    $(".image-thumbnail").html(img);
  }
}

var ready = function() {
  if (window.location.href.search("images/new") >= 0) {
    console.log("Upload page only!");
    fileUpload();
  }
};

$(document).ready(ready);
