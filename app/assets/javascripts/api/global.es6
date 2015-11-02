var NM = {};
NM.getJSON = function(url, callback){
  aja()
    .url(url)
    .header("Accept", "application/json")
    .on('success', callback)
    .go();
};
