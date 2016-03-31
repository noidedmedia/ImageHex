function shareButtons() {
  var currenturl = window.location.href;
  var facebook = "https://www.facebook.com/sharer.php?u=";
  var twitter = "https://twitter.com/intent/tweet?text=Check+out+this+image&amp;hashtags=ImageHex&amp;url=";
  var googleplus = "https://plus.google.com/share?url=";
  var tumblr = "https://www.tumblr.com/share/link?url=";
  var pinterest = "https://pinterest.com/pin/create/button/?url=";

  document.querySelector("#share-facebook > a").setAttribute("href", facebook + currenturl);
  document.querySelector("#share-twitter > a").setAttribute("href", twitter + currenturl);
  document.querySelector("#share-google-plus > a").setAttribute("href", googleplus + currenturl);
  document.querySelector("#share-tumblr > a").setAttribute("href", tumblr + currenturl);
  document.querySelector("#share-pinterest > a").setAttribute("href", pinterest + currenturl);

  var shareArray = ["#share-facebook > a", "#share-twitter > a", "#share-google-plus > a", "#share-tumblr > a", "#share-pinterest > a"];
  
  for (var i = 0; i < shareArray.length; i++) {
    document.querySelector(shareArray[i]).addEventListener("click", function(e) {
      e.preventDefault();
      e.stopPropagation();
      window.open(this.href, "_blank", "width=500,height=400,resizable");
      return false;
    });
  }
}

var ready = function() {
  if (document.querySelector("#img-action-share")) {
    shareButtons();
  }
};

document.addEventListener("page:change", ready);
