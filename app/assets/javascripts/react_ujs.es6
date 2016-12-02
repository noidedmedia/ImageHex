import React from 'react';
import ReactDOM from 'react-dom';
import $ from 'jquery';

let ReactUJS = {};
ReactUJS.componentMap = {};

ReactUJS.register = function(str, component) {
  ReactUJS.componentMap[str] = component;
};

ReactUJS.getComponent = function(str) {
  return ReactUJS.componentMap[str];
};

ReactUJS.getDOMNodes = function() {
  return $("[data-react-class]");
};

ReactUJS.mountComponents = function() {
  console.log("Mounting components");

  var nodes = ReactUJS.getDOMNodes();
  for(var i = 0; i < nodes.length; ++i) {
    let node = nodes[i];
    let key = node.getAttribute("data-react-class");
    let constructor = ReactUJS.getComponent(key);
    let propsJSON = node.getAttribute("data-react-props");
    let props = propsJSON && JSON.parse(propsJSON);
    if(typeof(constructor) === "undefined") {
      let msg = `Cannot find component ${key}.`;
      if(console && console.error) { console.error("ReactUJS: " + msg); }
    } else {
      ReactDOM.render(React.createElement(constructor, props), node);
    }
  }
};

function isPermanent(node) {
  return $(node).parents("[data-turbolinks-permanent]").length !== 0;
};

ReactUJS.unmountComponents = function() {
  var nodes = ReactUJS.getDOMNodes();
  for(let i = 0; i < nodes.length; ++i) {
    var node = nodes[i];
    if(isPermanent(node)) {
      console.log("Node is permanent, not unmounting", node);
    }
    else {
      ReactDOM.unmountComponentAtNode(node);
    }
  }
}


ReactUJS.setup = function() {
  console.log("Setting up react ujs");
  $(document).on("turbolinks:load", () => ReactUJS.mountComponents());
  $(document).on("turbolinks:before-render",() => ReactUJS.unmountComponents());
};

export default ReactUJS;
