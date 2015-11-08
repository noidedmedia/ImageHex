function tabbedMenu() {
  var tabs = document.querySelectorAll('ul#user-page-header-tabs li');
  for (var i = 0; i < tabs.length; i++) {
    tabs[i].addEventListener('click', function(e) {
      var tabid = e.target.getAttribute('data-tab');

      document.querySelectorAll('ul#user-page-header-tabs li').classList.remove('current');
      document.querySelectorAll('.tab-content').classList.remove('current');

      document.querySelector(e.target).classList.add('current');
      document.querySelector('.tc-' + tabid).classList.add('current');
    });
  };
}

var ready = function() {
  if (document.querySelector("#user-page-header-tabs")) {
    tabbedMenu();
  }
};

document.addEventListener('page:change', ready);
