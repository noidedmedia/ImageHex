/* 
 * Do stuff
 */

function Search(query){
  this.base_url = "/search.json?" + $.param({query: query});
  this.query = query;
}

Search.prototype.results = function(callback, page){
  var that = this;
  if(page === undefined){
    page = 1;
  }
  $.ajax({
    url: this.base_url + "&page=" + page,
  }).done(function(result){
    callback(new SearchResults(that, result, page));
  });
}

function SearchResults(s, result, page){
  this.search = s;
  this.images = result;
  this.page = page;
  this._img_index = 0;
}

SearchResults.prototype.noMoreImages = function(){
  $(".next-image").replaceWith("NO MORE IMAGES YOU HACK");
}

SearchResults.prototype.nextPage = function(callback){
  var that = this;
  this.search.results(function(page){
    if(page.images.length === 0){
      that.noMoreImages();
    }
    else{
      callback(page);
    }
  }, this.page + 1);
}

SearchResults.prototype.currentImage = function(){
  return this.images[this._img_index];
}
SearchResults.prototype.requireNewPage = function(){
  return (this._img_index >= this.images.length);
}
SearchResults.prototype.load = function(){
  $("#trigger-dynamic").replaceWith($("#controls-dynamic"));
  $("#controls-dynamic").removeClass("hidden-controls");
  this.loadControls();
  if(this.requireNewPage()){
    this.nextPage(function(page){
      page.load();
    });
  }
  else{
    $("#image-show-stub").load("/images/" + this.currentImage().id + " .image");
  }
}

SearchResults.prototype.loadControls = function(){
  console.log("Loading controls");
  var that = this;
  var next = $(".next-image");
  console.log(next);
  next.click(function(){
    that._img_index = that._img_index + 1;
    that.load();
  });
  $(".prev-image").click(function(){
    that._img_index = that._img_index - 1;
    that.load();
  });
}
$(document).ready(function(){
  $("#trigger-dynamic").click(function(){
    var fields = $(".page-search-input");
    var values = []
    fields.each(function(){
      console.log(this);
      values.push( $(this).val());
    });
    var res = new Search(values);
    res.results(function(page){
      page.load();
    });
  });
});
