function dropzoneCreate() {
  new Dropzone(document.body, { // Make the whole body a dropzone
    url: "/images", // Set the url
    previewsContainer: "#image-thumbnail", // Define the container to display the previews
    clickable: "#click-choose-file" // Define the element that should be used as click trigger to select files.
  });
}

var ready = function() {
  if (window.location.href.search("images/new") >= 0) {
    console.log("Upload page only!");
    dropzoneCreate();
  }
};

$(document).ready(ready);
