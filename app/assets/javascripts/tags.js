var selectedelement = function(selection) {
  // Text inside the box
  var box = $("#header-search-input").val();
  // turn that into an array of tags
  var split = box.split(",");
  // Get the last tag, replace it with the selected tag
  split[split.length - 1] = selection;
  // join it back into a big screen
  var list = split.join(", ") + ", ";
  // Replace the input box's value with the new list.
  // We also replace any instances of 2 or more spaces with one space
  $("#header-search-input").val(list.replace(/\s{2,}/g," "));
  // Reutrn focus to the input box
  $("#header-search-input").focus();
};

var loadsuggestions = function(names) {
  console.log("Loading suggestions");
  console.log(names);
  // parent we're adding everything to
  var parent = $("#header-search-suggestions-fillable");
  // get rid of previous suggestions
  parent.empty();
  // Make each element an <li> with an onclick handler which adds it to the
  // list.
  for (name in names) {
    var element = document.createElement("li");
    element.innerHTML = names[name];
    console.log(element);
    parent.append(element);
    element.onclick = function(){
      var selected = this.innerHTML;
      selectedelement(selected);
    };
  }
};

// Load suggestions for a partial tag
var suggest = function(name){
  url = "/tags/suggest?name=" + name;
  // Get the AJAX from the query
  $.get(url, function(data, status){
    console.log(data);
    // if, for some god forsaken reason, we get no data, just give up
    if(!data) return;
    loadsuggestions(data);
  }, "json");
};


$(document).ready(function(){
  console.log("ready");
  $("#header-search-input").on("input", function(){
    var str = $(this).val();
    // Extract a lsit of tags
    var tags = str.split(",");
    // We do suggestions on the last tag in the list
    var tag = tags[tags.length -1];
    // equivalent of .strip.squish in ruby
    // Removes trailing and leading whitespace, then replaces any
    // instance of 2-or-more spaces with one space.
    // You need the "g" flag on that regex. No idea why, but you do.
    tag = $.trim(tag).replace(/\s{2,}/g, " ");
    if(tag !== ""){
      suggest(tag);
    }
  });
});
