function metadataParse() {
  EXIF.getData(this, function() {
    console.log(EXIF.pretty(this));

    var image = this;

    populateInfo(image);
  });
};

function populateInfo(image) {
  if ( EXIF.getTag(image, "ImageWidth") != undefined ) {
    var width = EXIF.getTag(image, "ImageWidth"),
        height = EXIF.getTag(image, "ImageHeight");
  } else if ( EXIF.getTag(image, "PixelXDimension") != undefined ) {
    var width = EXIF.getTag(image, "PixelXDimension"),
        height = EXIF.getTag(image, "PixelYDimension");
  } else {
    console.log("So it has come to this.");
  }

  console.log("Dimensions: " + width + "x" + height);
}

var ready = function() {
  $(".image > img").on("load", metadataParse);
};

$(document).ready(ready);
