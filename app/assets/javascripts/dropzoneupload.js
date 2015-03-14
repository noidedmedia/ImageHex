

var ready = function() {
  if (window.location.href.search('images/new') >= 0) {
    console.log('Upload page only!');
  }
};

$(document).ready(ready);
