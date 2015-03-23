function cookieJar() {
  $.cookie.json = true;
  $.cookie('cookie1337', 'this is a cookie!', { expires: 7 });
  var cookie1337 = $.cookie('cookie1337');
}

var ready = function() {
  cookieJar();
};

$(document).ready(ready);
