function fileUpload() {
  $("#file-field").on("dragenter", function() {
    // Add "hover" styles for dragging-and-dropping images.
  });

  $("#file-field").on("dragleave", function() {
    // Remove "hover" styles on dragleave.
  });

  $("#file-field").on("drop", addedFiles);
}

function addedFiles(event) {

  var files = event.originalEvent.dataTransfer.files;

  // console.log(files);

  if (files) {
    handleFiles(files);
  }
}

function handleFiles(files) {
  var uploadcontainer = $(".upload-container").clone();

  for (var i = 0; i < files.length; i++) {
    // console.log(i);
    // console.log(uploadcontainer);

    var uploadcontainerid = "upload-container-" + i;

    $(uploadcontainer)
      .attr('id', uploadcontainerid)
      .insertBefore(".new-upload-container");

    uploadcontainer = $("#upload-container-" + i).clone();

    // Display upload container.
    $("#" + uploadcontainerid).addClass("active");

    // Display submit button.
    $("#upload-submit-button").addClass("active");

    $("#" + uploadcontainerid + " .image-file-name").html(files[i].name);

    var img = document.createElement("img");
    img.src = window.URL.createObjectURL(files[i]);
    img.width = 348;
    img.onload = function() {
      window.URL.revokeObjectURL(this.src);
    };

    $("#" + uploadcontainerid + " .image-thumbnail").html(img);
  }
}

var ready = function() {
  if (window.location.href.search("images/new") >= 0) {
    console.log("Upload page only!");
    fileUpload();
  }
};

$(document).ready(ready);
