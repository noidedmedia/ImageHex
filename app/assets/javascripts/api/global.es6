var NM = {};

NM.getJSON = function(url, callback) {
  aja()
  .url(url)
  .header("Accept", "application/json")
  .on("success", callback)
  .go();
};

NM.deleteJSON = function(url, success, failure) {
  aja()
  .url(url)
  .method("delete")
  .header("Accept", "application/json")
  .header("X-CSRF-TOKEN", NM.getCSRFToken())
  .on("success", success)
  .on("failure", failure)
  .go();
};

NM.getCSRFToken = function() {
  var metas = document.getElementsByTagName("meta");
  var token;
  for (var m = 0; m < metas.length; m++) {
    var meta = metas[m];
    if (meta.getAttribute("name") == "csrf-token") {
      return meta.getAttribute("content");
    }
  }
};
NM.putJSON = function(url, data, callback, error) {

  data.authenticity_token = NM.getCSRFToken();
  aja()
  .method("put")
  .url(url)
  .header("Content-Type", "application/json")
  .header("Accept", "application/json")
  .body(data)
  .on("200", callback)
  .on("40*", error)
  .go();
};

NM.postJSON = function(url, data, callback, error) {
  data.authenticity_token = NM.getCSRFToken();
  aja()
  .method("post")
  .url(url)
  .header("Content-Type", "application/json")
  .header("Accept", "application/json")
  .body(data)
  .on("200", callback)
  .on("40*",error)
  .go();
};
