function avatarUploader() {
  document.querySelector("#avatar-uploader").addEventListener("change", avatarUploaderPreview);
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

    var thumb = document.getElementById("avatar-uploader-thumbnail");
    thumb.replaceChild(img, thumb.firstChild);
  }
}

var ready = function() {
  if (document.querySelector("#avatar-uploader")) {
    avatarUploader();
  }
};

document.addEventListener('page:change', ready);
