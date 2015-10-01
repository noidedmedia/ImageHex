function JustifyGallery(){
  $("#image-gallery").justifiedGallery({
    rowHeight: 230,
    margins: 10,
    sizeRangeSuffixes : {
      lt100 : "_small",
      lt240 : "_small",
      lt320 : "_medium",
      lt500 : "_large",
      lt640 : "_large",
      lt1024 : "_huge"
    }
  })
}

$(JustifyGallery);
