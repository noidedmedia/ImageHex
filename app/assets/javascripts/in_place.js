// A simple library to do a lot of things in-place with AJAX.
// Commented heavily so as to properly explain how it works.

/*
 *  The show-on property hides a DOM node until another node is clicked.
 *  To use, simply set the data-showon attribute with the Jquery selector
 *  for the node which will show whatever is initially hidden. 
 */
var show_on = function(){
  var hide =  $("div").filter(function(index){
    return $(this).data("showon");
    // Elements with data in the "showon" property are hidden from the start,
    // appearing only when the selector specified by showon is clicked
  });
  hide.each(function(){
    var that = this;
    $(this).hide();
    var toggle = $($(this).data("showon"));
    $(toggle).on("click", function(){
      console.log("toggled!");
      $(that).show();
    });
  });
};
var load_form = function(node){
  return function(){
    node.load(node.data("editform"), function(){
      console.log(this);
      $('form').fadeIn("normal");
    });
  };
};
// This function fins all elements with the data-editform attribute set.
// It will load the provided form when the provided toggle (in data-toggle)
// is clicked.
var form_prep = function(){
  var nodes = $("div").filter(function(index){
    return $(this).data("editform");
  });
  nodes.each(function(index){
    // Set the toggle here:
    var toggle = $(this).find($(this).data("toggle"));
    // load_form returns a closure which loads the form
    toggle.on("click", load_form($(this)));
  });
};
var ready;
ready = function(){
  show_on();
  form_prep();
}
$(document).ready(ready);
$(document).on("page:load",ready);

