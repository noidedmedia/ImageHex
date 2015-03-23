var selectedelement = function(selection, input, list) {
  $(list).empty();
  var input = $(input);
  // Text inside the box
  var box = $(input).val();
  // turn that into an array of tags
  var split = box.split(",");
  // Get the last tag, replace it with the selected tag
  split[split.length - 1] = selection;
  // join it back into a big screen
  var list = split.join(", ") + ", ";
  // Replace the input box's value with the new list.
  // We also replace any instances of 2 or more spaces with one space
  input.val(list.replace(/\s{2,}/g," "));
  console.log("Setting input value to " + input.val());
  // Return focus to the input box
  input.focus();
  console.log("Focus returned to input box.");
};
/*
 * A function which returns a function (woo)
 * The returned function should be used as an "input" event handler
 * on the box you want suggestions to work on
 * list: a jQuery object representing a <ul> to add suggestions to 
 * toggle: add the "active" class when the user first starts to input stuff,
 * remove it afterwards.
 * The "active" class is added when suggestions are active.
 *
 *
 */

var searchSuggestion = function(list, toggle){
  return function(){
    var str = $(this).val();
    if(toggle){
      if (str === ""){
        toggle.addClass("active");
      }
      else{
        toggle.removeClass("active");
      }
    }
    // Extract a list of tags
    var tags = str.split(",");
    // We do suggestions on the last tag in the list
    var tag = tags[tags.length -1];
    // equivalent of .strip.squish in ruby
    // Removes trailing and leading whitespace, then replaces any
    // instance of 2-or-more spaces with one space.
    // the "g" flag makes the replacement global in the string
    tag = $.trim(tag).replace(/\s{2,}/g, " ");
    if (tag !== "") {
      // User has input something, do suggestions on it
      if(toggle){
        toggle.removeClass("active");
      }
      $(list).addClass("active");
      // "this" is currently the input box
      // we pass it along so later functions can do things with it
      suggest(tag, this, list);
    }
    else{
    }
  };
}
// Load a list of suggestions (got with Jquery) into a given list
// we keep the "input" parameter to pass it along later
var loadsuggestions = function(names, input, list) {
  // get rid of previous suggestions
  list.empty();
  var click = function() {
    var selected = this.innerHTML;
    selectedelement(selected, input, list);
  };
  // Make each element an <li> with an onclick handler which adds it to the
  // list.
  for (name in names) {
    var element = document.createElement("li");
    element.innerHTML = names[name];
    element.onclick = click;
    $(list).append(element);
  }
  console.log("List is:");
  console.log($(list));
  if(!$(list).hasClass("active")){
    console.log("Active class was not applied to list before, doing so now...");
    $(list).addClass("active");
  }
  else{
    console.log("List already active, nothing to do.");
  }
};

// Load suggestions for a partial tag via AJAX
var suggest = function(name, input, list, toggle) {
  url = "/tags/suggest?name=" + name;
  // Get the AJAX from the query
  $.get(url, function(data, status) {
    // if, for some god forsaken reason, we get no data, just give up
    if(!data) return;
    // Display an error message when no suggestions are found
    if(data.length == 0){
      console.log("Found no suggestions");
      $(list).addClass("active");
      $(list).empty();
      $(list).append("No suggestions found");
    }
    else{
      console.log("Found suggetions:");
      console.log(data);
      // Load the suggestions
      loadsuggestions(data, input, list, toggle);
    }
  }, "json");
};

var ready = function() {
  // where to load header suggestions
  var hlist = $("#header-search-suggestions-fillable");
  // what to toggle in the header
  var htoggle = $("#header-search-suggestions-empty");
  $("#header-search-input").on("input", searchSuggestion(hlist, htoggle));
}

$(document).ready(ready);
