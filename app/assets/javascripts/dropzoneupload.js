function dropzoneCreate() {
  new Dropzone("#upload-dropzone", { // Make the whole body a dropzone
    url: "/images", // Set the url
    previewsContainer: ".image-thumbnail", // Define the container to display the previews
    autoProcessQueue: false,
    paramName: "image[f]",
    clickable: ".file-upload-coverup",
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
