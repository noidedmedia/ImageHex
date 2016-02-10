document.addEventListener("page:change", function(){
  var container = document.getElementById("fullfill-picker-container");
  if(! container){
    console.log("No fullfilment picker here");
    return;
  }
  var id = container.dataset.userId;
  console.log("Got picker container",container,"and user id",id);
  var collection = User.creationsCollectionFor(id);
  ReactDOM.render(<CommissionFullfillmentPicker
    creationsCollection={collection} />, container);
});
