function shareButtons() {
  var currenturl = window.location.href;
  var facebook = "https://www.facebook.com/sharer.php?u=";
  var twitter = "https://twitter.com/intent/tweet?text=Check+out+this+image&amp;hashtags=ImageHex&amp;url=";
  var googleplus = "https://plus.google.com/share?url=";
  var tumblr = "https://www.tumblr.com/share/link?url=";
  var pinterest = "https://pinterest.com/pin/create/button/?url=";

  $("#share-facebook > a").attr("href", facebook + currenturl);
  $("#share-twitter > a").attr("href", twitter + currenturl);
  $("#share-google-plus > a").attr("href", googleplus + currenturl);
  $("#share-tumblr > a").attr("href", tumblr + currenturl);
  $("#share-pinterest > a").attr("href", pinterest + currenturl);

  $("#share-facebook > a, #share-twitter > a, #share-google-plus > a, #share-tumblr > a, #share-pinterest > a").on("click", function(e) {
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
