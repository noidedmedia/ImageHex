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
  var uploadcontainer = $(".upload-container").clone();

  for (var i = 0; i < files.length; i++) {
    console.log(i);

    console.log(uploadcontainer);

    var uploadcontainerid = "upload-container-" + i;

    $(uploadcontainer)
      .attr('id', uploadcontainerid)
      .insertBefore(".new-upload-container");

    uploadcontainer = $(".upload-container-" + i).clone();

    console.log("Display upload container.");
    $(uploadcontainerid).addClass("active");

    console.log("Display submit button.");
    $("#upload-submit-button").addClass("active");

    console.log("Test1.");

    $(uploadcontainerid + " .image-file-name").html(files[i].name);

    console.log("Test2.");

    var img = document.createElement("img");
    img.src = window.URL.createObjectURL(files[i]);
    img.width = 348;
    img.onload = function() {
      window.URL.revokeObjectURL(this.src);
    };

    console.log("Test3.");

    $(uploadcontainerid + " .image-thumbnail").html(img);
  }
}

var ready = function() {
  if (window.location.href.search("images/new") >= 0) {
    console.log("Upload page only!");
    fileUpload();
  }
};

$(document).ready(ready);
