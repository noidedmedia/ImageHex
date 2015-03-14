function dropzoneCreate() {

  Dropzone.autoDiscover = false;

  $("#dropzone-form").dropzone({
    url: "/images", // Set the url
    previewsContainer: ".image-thumbnail", // Define the container to display the previews
    autoProcessQueue: false,
    paramName: "image",
    clickable: ".file-upload-coverup",
    addRemoveLinks: true,
    uploadMultiple: false,
    init: function() {
      this.on("addedfile", function(file) {
        $(".upload-container").addClass("active");
      });
    }
  });
}

var ready = function() {
  if (window.location.href.search("images/new") >= 0) {
    console.log("Upload page only!");

    dropzoneCreate();
  }
};

$(document).ready(ready);
