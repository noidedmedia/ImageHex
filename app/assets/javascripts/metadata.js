function metadataTest() {
  console.log(EXIF);

  EXIF.getData(this, function() {
    console.log(EXIF.pretty(this));

    // var make = EXIF.getTag(this, "Make"),
    //     model = EXIF.getTag(this, "Model");
    // console.log("I was taken by a " + make + " " + model);
  });
};

var ready = function() {
  $(".image > img").on("click", metadataTest);
};

$(document).ready(ready);
