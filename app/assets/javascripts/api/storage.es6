// create proxies to LocalStorage and SessionStorage which work properly

var ss = {};

ss.setItem = function(key, value){
  sessionStorage.setItem(key, JSON.stringify(value));
}

ss.getItem = function(key){
  var item = sessionStorage.getItem(key);
  if(item){
    return JSON.parse(item);
  }
  return item;
}

var ls = {};

ls.setItem = function(key, value){
  localStorage.setItem(key, JSON.stringify(value));
}

ls.getItem = function(key){
  var item = localStorage.get(key);
  if(item){
    return JSON.parse(item);
  }
  return item;
}

NM.sessionStorage = ss;
NM.localStorage = ls;
