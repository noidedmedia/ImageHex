function headerSearch() {
  var headersearch = document.querySelector("#header-search");
  var headersearchinput = document.querySelector("#header-search-input");
  var windowwidth = window.innerWidth;

  // Only run if the browser window size doesn't imply a mobile device.
  if (windowwidth >= 700) {
    // Runs the function when the header-search input is the focused element.
    headersearchinput.addEventListener('focus', function() {
      
      // Checks to make sure the "header-search" div doesn't already have an "active" class.
      if (!headersearch.classList.contains('active')) {
        headersearch.classList.add('active');
      }

      // Binds any click outside the headersearch div to removing the "active" class
      // and therefore hidings the header's search dropdown.
      headersearch.addEventListener('clickoutside', function(event) {
        // The following sets the max-height of the element to the
        // height of the element itself, because CSS transitions won't
        // work if the height is set to auto. So this is the 
        // work-around.
        var searchheight = headersearch.outerHeight();

        headersearch.style = 'max-height: ' + searchheight;
        headersearch.style = 'max-height: 40px;';
        headersearch.classList.remove('active');

        // Unbinds the function so it can only happen once.
        headersearch.removeEventListener('clickoutside');
      });
    });

    headersearch.addEventListener('transitionend', function(e) {
      if (e.target == headersearch) {
        if (headersearch.classList.contains('active')) {
          headersearch.style = "max-height: 240px;";
        } else {
          headersearch.removeAttribute('style');
        }
      }
    });
  }

  // Only run if the browser window size implies a mobile device.
  if (windowwidth <= 700) {
    document.querySelector('#mobile-search-icon').addEventListener('click', function() {
      document.getElementsByTagName('body')[0].addEventListener('touchmove', function(e) {
        e.preventDefault();
      });

      // Checks to make sure the "header-search" div doesn't already have an "active" class.
      if (!headersearch.classList.contains('active')) {
        document.querySelector('#header-search').classList.toggle('active');
      }
    });
  }
}

function closeHeaderSearchMobile() {
  var headersearch = document.querySelector("#header-search");

  document.querySelector("#close-mobile-search-icon").addEventListener('click', function() {
    headersearch.classList.remove('active');
    document.getElementsByTagName('body')[0].removeEventListener('touchmove');
  });
}

function addSearchBox(toaddcount) {
  var toAdd = $(".page-search-full").last().clone();
  var list = toAdd.find(".page-suggestions");
  $(".page-search-full").last().after(toAdd);
  $(toAdd).attr('id', "page-search-full" + toaddcount);
  toAdd.find("input").on("input", searchSuggestion(list, null)).val("").focus();
}

var ready = function() {
  headerSearch();
  

  if (document.querySelector(".page-search-full")) {
    // We have to set this up here since the first search box is
    // already on the page when we start the search
    var firstSearch = document.querySelector(".page-search-full");
    var firstBox = firstSearch.closest("input");
    var firstList = firstSearch.closest("ul");
    firstBox.addEventListener("input", searchSuggestion(firstList, null));
  }

  if (document.querySelector("#add-group-button")) {
    var toaddcount = 0;
    document.querySelector("#add-group-button").addEventListener("click", function(e) {
      e.preventDefault();
      addSearchBox(toaddcount);
      toaddcount = toaddcount + 1;
    });
  }
  
  var windowwidth = window.innerWidth;

  // Only run if the browser window size implies a mobile device.
  if (windowwidth <= 700) {
    closeHeaderSearchMobile();
  }
};

document.addEventListener('page:change', ready);
