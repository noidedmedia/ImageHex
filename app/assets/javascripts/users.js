function tabbedMenu() {  
  $('ul#user-page-header-tabs li').click(function() {
    var tabid = $(this).attr('data-tab');

    $('ul#user-page-header-tabs li').removeClass('current');
    $('.tab-content').removeClass('current');

    $(this).addClass('current');
    $('.tc-' + tabid).addClass('current');
  });
}

var ready = function() {
  tabbedMenu();
};

$(document).ready(ready);