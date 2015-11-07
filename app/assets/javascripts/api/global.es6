var NM = {};
NM.getJSON = function(url, callback){
  aja()
  .url(url)
  .header("Accept", "application/json")
  .on('success', callback)
  .go();
};

NM.putJSON = function(url, data, callback, error){
  var metas = document.getElementsByTagName('meta');
  var token;
  for(var meta of metas){
    if(meta.getAttribute("name") == "csrf-token"){
      token = meta.getAttribute("content");
    }
  }
  data.authenticity_token = token;
  aja()
  .method('put')
  .url(url)
  .header("Content-Type", "application/json")
  .body(data)
  .on('200', callback)
  .on('40*', error)
  .go();
}
