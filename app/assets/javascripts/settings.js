function avatarUploader() {
  $("#avatar-uploader").on("change", avatarUploaderPreview);
}

function avatarUploaderPreview(event) {
  var files = event.target.files || (event.originalEvent.dataTransfer && event.originalEvent.dataTransfer.files);

  console.log(files);

  if (files) {
    var img = document.createElement("img");
    img.src = window.URL.createObjectURL(files[0]);
    img.width = 150;
    img.onload = function() {
      window.URL.revokeObjectURL(this.src);
    };

    $("#avatar-uploader-thumbnail-container").html(img);
  }
}

var ready = function() {
  avatarUploader();
};

document.addEventListener('page:change', ready);
