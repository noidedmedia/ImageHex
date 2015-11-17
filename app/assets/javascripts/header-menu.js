function headerMenu() {
  document.querySelector('#mobile-menu-icon').addEventListener('click', function() {
    document.getElementsByTagName('body')[0].addEventListener('touchmove', function(e) {
      e.preventDefault();
    });
    
    document.querySelector('#header-right').classList.toggle('active');
    document.querySelector('#mobile-menu-icon').classList.toggle('active');
    document.querySelector('#mobile-menu-overlay').classList.toggle('active');

    if (document.querySelector('#mobile-menu-icon').classList.contains('active')) {
      document.querySelector('#mobile-menu-icon').addEventListener('click', function() {
        document.querySelector('#mobile-menu-overlay').removeEventListener('click');
      });
    }

    setTimeout(clickOverlay, 200);
  });
}

function clickOverlay() {
  document.querySelector('#mobile-menu-overlay').addEventListener('click', function() {
    headerMenuClose();
    document.querySelector('#mobile-menu-overlay').removeEventListener('click');
  });
}

// This function binds clicking outside of the dropdown to closing the dropdown.
function headerMenuClose() {
  document.querySelector('#header-right').classList.remove('active');
  document.querySelector('#mobile-menu-icon').classList.remove('active');
  document.querySelector('#mobile-menu-overlay').classList.remove('active');
  document.getElementsByTagName('body')[0].removeEventListener('touchmove');
}

var ready = function() {
  var windowwidth = window.innerWidth;

  // Only run if the browser window implies a mobile device.
  if (windowwidth < '750') {
    headerMenu();
  }
};

document.addEventListener('page:change', ready);
