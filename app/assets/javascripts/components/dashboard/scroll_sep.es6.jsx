import React, { Component } from 'react';
import $ from 'jquery';

class ScrollSep extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    return <span ref={(r) => this.pageElement = r}></span>;
  }

  componentDidMount() {
    let listeners = this.getListenerName();
    $("body").on(listeners, this.scrollWindow.bind(this));;
  }

  getListenerName() {
    let sid = `dashboard-${this.props.id}`;
    return `scroll.${sid} touchmove.${sid}`;
  }

  scrollWindow() {
    let rect = this.pageElement.getBoundingClientRect();
    if(! this.props.hasFurther) {
      $("body").off(this.getListenerName());
    }
    if(rect.bottom - 1000 <= window.innerHeight) {
      this.fireFetch();
    }
  }

  fireFetch() {
    this.props.store.fetchFurther();
  }
}

export default ScrollSep;
