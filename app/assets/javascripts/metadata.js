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

    var width = (image.naturalWidth),
        height = (image.naturalHeight);
  }

  console.log("Dimensions: " + width + "x" + height);

  if ( EXIF.getTag(image, "GPSLatitude") != undefined && EXIF.getTag(image, "GPSLongitude") != undefined ) {
    // Both of these are arrays with three numbers.
    // Degrees, minutes, and seconds, where minutes
    // are 1/60th of a degree and seconds are 1/60th
    // of a minute. Each item in the arrays have 
    // "numberator" and "denominator" numbers, which
    // pretty much do what you'd expect. A numerator
    // of "1" and denominator of "4" would be "0.25".
    var latitude = EXIF.getTag(image, "GPSLatitude"),
        longitude = EXIF.getTag(image, "GPSLongitude");

    console.log(latitude);
    console.log(longitude);

    console.log("Latitude: " + latitude);
    console.log("Longitude: " + longitude);
  }
}

var ready = function() {
  $(".image > img").on("load", metadataParse);
};

$(document).ready(ready);
