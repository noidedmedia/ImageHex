function headerMenu() {
  $('#mobile-menu-icon').on('click', function() {
    $('body').bind('touchmove', function(e) {
      e.preventDefault();
    });
    
    $('#header-right').toggleClass('active');
    $('#mobile-menu-icon').toggleClass('active');
    $('#mobile-menu-overlay').toggleClass('active');

    if( $('#mobile-menu-icon').hasClass('active') ) {
      $('#mobile-menu-icon').on('click', function() {
        $('#mobile-menu-overlay').unbind('click');
      });
    }

    setTimeout(clickOverlay, 200);
  });
}

function clickOverlay() {
  $('#mobile-menu-overlay').bind('click', function() {
    headerMenuClose();
    $('#mobile-menu-overlay').unbind('click');
  });
}

// This function binds clicking outside of the dropdown to closing the dropdown.
function headerMenuClose() {
  $('#header-right').removeClass('active');
  $('#mobile-menu-icon').removeClass('active');
  $('#mobile-menu-overlay').removeClass('active');
  $('body').unbind('touchmove');
}

// Function runs when the document is "ready".
$(document).ready(function() {

  var windowwidth = $(window).width();

  // Only run if the browser window implies a mobile device.
  if (windowwidth < '750') {
    headerMenu();
  }
});
