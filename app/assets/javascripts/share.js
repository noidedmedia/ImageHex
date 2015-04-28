function shareButtons() {
  var currenturl = window.location.href;
  var twitter = "https://twitter.com/intent/tweet?text=Check+out+this+image&amp;hashtags=ImageHex&amp;url=";
  var googleplus = "https://plus.google.com/share?url=";

  $("#share-twitter > a").attr("href", twitter + currenturl);
  $("#share-google-plus > a").attr("href", googleplus + currenturl);

  $("#share-google-plus > a, #share-twitter > a").on("click", function(e) {
    e.preventDefault();
    e.stopPropagation();
    window.open(this.href, 'newwindow', 'width=600, height=500');
    return false;
  });
}

var ready = function() {
  shareButtons();
};

$(document).ready(ready);
