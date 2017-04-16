import React, { Component } from 'react';
import $ from 'jquery';

class ScrollSigil extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    return <span ref={(r) => this.pageElement = r}></span>;
  }

  componentDidMount() {
    let listener = this.getListenerName();
    $("body").on(listener, this.scrollWindow.bind(this));
  }

  getListenerName() {
    if(this.listenerName) {
      return this.listenerName;
    }
    else if(this.props.listenerName) {
      let name = this.props.listenerName;
      this.listenerName = `scroll.${name} touchmove.${name}`;
      return this.listenerName;
    }
    else {
      let name = `sigil-${Math.random()}`;
      this.listenerName = `scroll.${name} touchmove.${name}`;
      return this.listenerName;
    }
  }

  scrollWindow(event) {
    let rect = this.pageElement.getBoundingClientRect();
    if(! this.props.hasFurther) {
      $("body").off(this.getListenerName());
    }
    if(rect.bottom - 500 <= window.innerHeight) {
      this.fireFetch();
    }
  }

  fireFetch() {
    this.props.fetchFurther();
  }
}

export default ScrollSigil;
