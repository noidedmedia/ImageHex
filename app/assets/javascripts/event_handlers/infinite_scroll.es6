document.addEventListener("page:change", function(){
  console.log("Looking to start infinite scroll");
  var e = document.getElementById("image-show-stub");
  if(e){
    console.log("Have a show stub with dataset",e.dataset);
    if(e.dataset.infiniteScroll == "true"){
      console.log("Using infinite scroll");
      var is = new InfiniteScroller(e, e.dataset.currentPage);
      is.go();
    }
  }
});

console.log("Test");
