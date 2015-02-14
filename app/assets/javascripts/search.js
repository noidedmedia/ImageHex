function headerSearch() {
  var headersearch = $("#header-search");
  var headersearchinput = $("#header-search-input");

  headersearchinput.on('focus', function() {
    
    // Checks to make sure the "header-search" div doesn't already have an "active" class.
    if (!headersearch.hasClass('active')) {
      // Variable for moving up one in the HTML hierarchy.
      var parentform = headersearchinput.parent('form');

      // Moves up another level to the header-search div.
      parentform.parent('#header-search').toggleClass('active');
    }

    // Binds any click outside the headersearch div to removing the "active" class
    // and therefore hidings the header's search dropdown.
    headersearch.bind('clickoutside', function(event){
      $(this).toggleClass('active');

      // Unbinds the function so it can only happen once.
      $(this).unbind('clickoutside');
    });
  });
}

var ready = function() {
  headerSearch();
};

$(document).ready(ready);
