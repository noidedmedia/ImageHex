document.addEventListener("page:change", function(){
  var view = document.getElementById("example-image-picker");
  if(! view){
    return;
  }
  console.log("Got example image picker",view);
  var userId = view.dataset.userId;
  console.log("Also got user id", userId);
  var collection = User.creationsCollectionFor(userId);
  console.log("Got collection", collection);
  ReactDOM.render(<ExampleImagePicker
    creationsCollection={collection}/>, view);
});