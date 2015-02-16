var selected_element = function(selection){
  var box = $("#header-search-input").val();
  var split = box.split(",");
  split[split.length - 1] = selection;
  var list = split.join(", ") + ", ";
  $("#header-search-input").val(list.replace(/\s{2,}/g," "));
  $("#header-search-input").focus();
}

var load_suggestions = function(names){
  console.log("Loading suggestions");
  console.log(names);
  var parent = $("#header-search-suggestions-fillable");
  parent.empty();
  for(name in names){
    var element = document.createElement("li");
    element.innerHTML = names[name];
    console.log(element);
    parent.append(element);
    element.onclick = function(){
      var selected = this.innerHTML;
      selected_element(selected);
    }
  }
}


var suggest = function(name){
  url = "/tags/suggest?name=" + name;
  // Get the AJAX from the query
  $.get(url, function(data, status){
    console.log(data);
    if(!data) return;
    load_suggestions(data);
  }, "json");
}


$(document).ready(function(){
  console.log("ready");
  $("#header-search-input").on("input", function(){
    var str = $(this).val();
    var tags = str.split(",");
    // We do suggestions on the last tag in the list
    var tag = tags[tags.length -1];
    // equivalent of .strip.squish in ruby
    tag = $.trim(tag).replace(/\s{2,}/g, " ");
    if(tag != ""){
      suggest(tag);
    }
  });
});
