function headerMenu() {
  document.querySelector('#mobile-menu-icon').addEventListener('click', function() {
    $('body').bind('touchmove', function(e) {
      e.preventDefault();
    });
    
    document.querySelector('#header-right').classList.toggle('active');
    document.querySelector('#mobile-menu-icon').classList.toggle('active');
    document.querySelector('#mobile-menu-overlay').classList.toggle('active');

    if (document.querySelector('#mobile-menu-icon').classList.contains('active')) {
      document.querySelector('#mobile-menu-icon').addEventListener('click', function() {
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
  document.querySelector('#header-right').classList.remove('active');
  document.querySelector('#mobile-menu-icon').classList.remove('active');
  document.querySelector('#mobile-menu-overlay').classList.remove('active');
  $('body').unbind('touchmove');
}

var ready = function() {
  var windowwidth = window.innerWidth;

  // Only run if the browser window implies a mobile device.
  if (windowwidth < '750') {
    headerMenu();
  }
};

document.addEventListener('page:change', ready);
