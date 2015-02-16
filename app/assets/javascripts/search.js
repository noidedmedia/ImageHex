function headerSearch() {
  var headersearch = $("#header-search");
  var headersearchinput = $("#header-search-input");

  // Runs the function when the header-search input is the focused element.
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

function headerSearchMobile() {
  var headersearch = $("#mobile-header-search");

  // Runs the function when the header-search input is the focused element.
  $("#mobile-search-icon").click(function() {
    $(headersearch).addClass('active');
    $('body').bind('touchmove', function(e){
      e.preventDefault()
    });

    closeHeaderSearchMobile();
  });
}

function closeHeaderSearchMobile() {
  var headersearch = $("#mobile-header-search");

  $("#close-mobile-search-icon").click(function() {
    $(headersearch).removeClass('active');
    $('body').unbind('touchmove');
  });
}

var ready = function() {  
  var windowwidth = $(window).width();

  // Only run if the browser window size doesn't imply a mobile device.
  if (windowwidth >= '700') {
    headerSearch();
  }
  // Only run if the browser window size implies a mobile device.
  else {
    headerSearchMobile();
  }
};

$(document).ready(ready);
