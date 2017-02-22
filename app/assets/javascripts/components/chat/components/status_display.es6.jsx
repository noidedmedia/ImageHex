import React from 'react';
import { activate, deactivate } from '../actions.es6';

export default class StatusDisplay extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    var color;
    var click = () => {};
    if(this.props.online) {
      color = "#7CBA5B";
    }
    else {
      color = "#E72244";
    }
    if(this.props.active) {
      click = this.deactivate.bind(this);
    }
    else {

      click = this.activate.bind(this);
    }
    return <div className="status-display"
      onClick={click}>
      <svg id="chat-svg"
        viewBox="0 0 228.87575 180.80291"
        version="1.1">
        <g id="layer1" 
          transform="matrix(.87768 0 0 1 -195.54 -152.52)">
          <path id="path3338" 
            fillRule="evenodd"
            fill={color}
            d="m222.79 234.51 60 81.981h120l80.775 16.841-20.778-98.822-60-81.981h-120z"/>
        </g>
        <text id="text3342" fontSize="40px" 
          y="107.89626" x="100.377853" 
          fontFamily="sans-serif"
          textAnchor="middle"
          fill="#000000">
          <tspan id="tspan3344" 
            fontSize="80px" 
            fill="#ffffff">
            {this.props.unreadCount}
          </tspan>
        </text>
      </svg>
    </div>;
  }

  activate() {
    this.context.dispatch(activate());
  }

  deactivate() {
    this.context.dispatch(deactivate());
  }
}

StatusDisplay.contextTypes = {
  store: React.PropTypes.object,
  dispatch: React.PropTypes.func
};


