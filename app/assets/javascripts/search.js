function headerSearch() {
  var headersearch = $("#header-search");
  var headersearchinput = $("#header-search-input");
  var windowwidth = $(window).width();

  // Only run if the browser window size doesn't imply a mobile device.
  if (windowwidth >= 700) {
    // Runs the function when the header-search input is the focused element.
    headersearchinput.on('focus', function() {
      
      // Checks to make sure the "header-search" div doesn't already have an "active" class.
      if (!headersearch.hasClass('active')) {
        headersearch.addClass('active');
      }

      // Binds any click outside the headersearch div to removing the "active" class
      // and therefore hidings the header's search dropdown.
      headersearch.bind('clickoutside', function(event) {
        // The following sets the max-height of the element to the
        // height of the element itself, because CSS transitions won't
        // work if the height is set to auto. So this is the 
        // work-around.
        var searchheight = headersearch.outerHeight();

        $(headersearch).css('max-height', searchheight);
        $(headersearch).css('max-height', 40);

        // Unbinds the function so it can only happen once.
        $(headersearch).unbind('clickoutside');
      });
    });

    headersearch.on('transitionend', function(e) {
      if ($(e.target).is(headersearch)) {

        if (headersearch.hasClass('active')) {
          headersearch.css('max-height', 240);
        } else {
          headersearch.removeAttr('style');
        }
      }
    });
  }

  // Only run if the browser window size implies a mobile device.
  if (windowwidth <= 700) {
    $('#mobile-search-icon').on('click', function() {
      $('body').bind('touchmove', function(e) {
        e.preventDefault();
      });

      // Checks to make sure the "header-search" div doesn't already have an "active" class.
      if (!headersearch.hasClass('active')) {
        // Variable for moving up one in the HTML hierarchy.
        var parentform = headersearchinput.parent('form');

        // Moves up another level to the header-search div.
        parentform.parent('#header-search').toggleClass('active');
      }
    });
  }
}

function closeHeaderSearchMobile() {
  var headersearch = $("#header-search");

  $("#close-mobile-search-icon").click(function() {
    $(headersearch).removeClass('active');
    $('body').unbind('touchmove');
  });
}

function addSearchBox(toaddcount) {
  var toAdd = $(".page-search-full").last().clone();
  var list = toAdd.find(".page-suggestions");
  $(".page-search-full").last().after(toAdd);
  $(toAdd).attr('id', "page-search-full" + toaddcount);
  toAdd.find("input").on("input", searchSuggestion(list, null)).val("");
}

var ready = function() {
  headerSearch();
  // We have to set this up here since the first search box is
  // already on the page when we start the search
  var firstSearch = $(".page-search-full");
  var firstBox = firstSearch.find("input");
  var firstList = firstSearch.find("ul");
  firstBox.on("input", searchSuggestion(firstList, null));
  var toaddcount = 0;
  $("#add-group-button").on("click", function(event) {
    event.preventDefault();
    addSearchBox(toaddcount);
    toaddcount = toaddcount + 1;
  });
  var windowwidth = $(window).width();

  // Only run if the browser window size implies a mobile device.
  if (windowwidth <= 700) {
    closeHeaderSearchMobile();
  }
};

$(document).ready(ready);
