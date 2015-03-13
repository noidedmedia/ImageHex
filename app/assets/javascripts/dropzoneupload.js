function dropzoneCreate() {
  new Dropzone("#dropzone-form", { // Make the whole body a dropzone
    url: "/images", // Set the url
    previewsContainer: ".image-thumbnail", // Define the container to display the previews
    autoProcessQueue: false
  });
}

var ready = function() {
  if (window.location.href.search("images/new") >= 0) {
    console.log("Upload page only!");
    dropzoneCreate();
  }
};

$(document).ready(ready);
