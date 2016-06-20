import { polyfill } from 'es6-promise';
polyfill();
import 'whatwg-fetch';
var NM = {};

window.NM = NM;

NM.flatten = function(array) {
  var ret = [];
  array.forEach((elem) => {
    if(Array.isArray(elem)) {
      ret = ret.concat(NM.flatten(elem));
    }
    else {
      ret.push(elem);
    }
  });
  return ret;
}

/**
 * Turn an array into a normalized object.
 * Will use the `sel` parameter of each object as the key, and the object
 * as the value.
 */
NM.shallowNormalize = function(array, sel) {
  var obj = {};
  array.forEach(o => obj[o[sel]] = o);
  return obj;
}

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
  var f = window.fetch(url, {
    credentials: 'same-origin',
    headers: {
      'Accept': "application/json",
      'Content-Type': "application/json"
    }
  }).then(parseJSON)
  if(callback) {
    f = f.then(callback);
  }
  return f;
};


function parseJSON(resp) {
  return resp.json();
}

NM.deleteJSON = function(url, success, failure) {
  window.fetch(url, {
    method: 'delete',
    credentials: 'same-origin',
    headers: {
      'Accept': 'application/json',
      'X-CSRF-TOKEN': NM.getCSRFToken()
    }
  }).then(checkStatus)
  .then(parseJSON)
  .then(success)
  .catch(failure);
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
  window.fetch(url, {
    method: 'put',
    credentials: 'same-origin',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(data)
  }).then(checkStatus)
  .then(parseJSON)
  .then(callback)
  .catch(error); 
};

function checkStatus(response) {
  if (response.status >= 200 && response.status < 300) {
    return response
  } else {
    var error = new Error(response.statusText)
    error.response = response
    throw error
  }
}


NM.postJSON = function(url, data, callback, error) {
  data.authenticity_token = NM.getCSRFToken();
  var f = window.fetch(url, {
    method: 'post',
    credentials: 'same-origin',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(data)
  }).then(checkStatus)
  .then(parseJSON)
  if(callback) {
    f.then(callback)
  }
  if(error) {
    f.catch(error);
  }
  return f;
};


export default NM;
