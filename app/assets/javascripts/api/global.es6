var NM = {};

/**
 * Chunk an array. Works like the Ruby method of the same name, with one
 * difference: if you pass a string, it will do elem[string] for each object.
 */
NM.chunk = function(array, sel) {
  var checkFunc = null;
  if(typeof(sel) == "function") {
    checkFunc = sel;
  }
  else {
    checkFunc = function(elem) {
      return elem[sel];
    }
  }
  var chunked = [];
  for(var i = 0; i < array.length; i++) {
    var elem = array[i];
    var value = checkFunc(elem);
    var tmp = [];
    while(i < array.length && checkFunc(array[i]) === value) {
      tmp.push(array[i]);
      i++;
    }
    chunked.push([value, tmp]);
    i--;
  }
  return chunked;
}

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

export default NM;
