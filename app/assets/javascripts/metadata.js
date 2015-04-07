// function metadataParse() {
//   EXIF.getData(this, function() {
//     console.log(EXIF.getAllTags(this));

//     var image = this;

//     populateInfo(image);
//   });
// };

// function populateInfo(image) {
//   if ( EXIF.getTag(image, "ImageWidth") != undefined ) {
//     var width = EXIF.getTag(image, "ImageWidth"),
//         height = EXIF.getTag(image, "ImageHeight");
//   } else if ( EXIF.getTag(image, "PixelXDimension") != undefined ) {
//     var width = EXIF.getTag(image, "PixelXDimension"),
//         height = EXIF.getTag(image, "PixelYDimension");
//   } else {
//     console.log("https://xkcd.com/1022/");

//     var width = (image.naturalWidth),
//         height = (image.naturalHeight);
//   }

//   console.log("Dimensions: " + width + "x" + height);

//   if ( EXIF.getTag(image, "GPSLatitude") != undefined && EXIF.getTag(image, "GPSLongitude") != undefined ) {
//     // Both of these are arrays with three numbers.
//     // Degrees, minutes, and seconds, where minutes
//     // are 1/60th of a degree and seconds are 1/60th
//     // of a minute. Each item in the arrays have 
//     // "numberator" and "denominator" numbers, which
//     // pretty much do what you'd expect. A numerator
//     // of "1" and denominator of "4" would be "0.25".
//     var latitude = EXIF.getTag(image, "GPSLatitude"),
//         longitude = EXIF.getTag(image, "GPSLongitude"),
//         latituderef = EXIF.getTag(image, "GPSLatitudeRef"),
//         longituderef = EXIF.getTag(image, "GPSLongitudeRef");

//     console.log(latitude);
//     console.log(longitude);
//     console.log(latituderef);
//     console.log(longituderef);

//     var latitudedegrees = (latitude[0].numerator / latitude[0].denominator),
//         latitudeminutes = (latitude[1].numerator / latitude[1].denominator),
//         latitudeseconds = (latitude[2].numerator / latitude[2].denominator),
//         longitudedegrees = (longitude[0].numerator / longitude[0].denominator),
//         longitudeminutes = (longitude[1].numerator / longitude[1].denominator),
//         longitudeseconds = (longitude[2].numerator / longitude[2].denominator);


//     console.log("Latitude: " + latitudedegrees + "° " + latitudeminutes + "' " + latitudeseconds + "\" " + latituderef);
//     console.log("Longitude: " + longitudedegrees + "° " + longitudeminutes + "' " + longitudeseconds + "\" " + longituderef);
//   }
// }

// var ready = function() {
//   $(".image > img").on("load", metadataParse);
// };

// $(document).ready(ready);
