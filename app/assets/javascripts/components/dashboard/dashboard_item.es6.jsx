import React, { Component } from 'react';
import ImageItem from './image_item.es6.jsx';
import NoteItem from './note_item.es6.jsx';
import ScrollSep from './scroll_sep.es6.jsx';

class DashboardItem extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    let { item } = this.props;
    if(item.type == "image") {
      return <ImageItem {...item} />;
    }
    else if(item.type == "note") {
      return <NoteItem {...item} />;
    }
    else if(item.type == "scroll_sep") {
      return <ScrollSep {...item} />
    }
    else {
      return <div className="error">
        Something in our JavaScript went bad.
      </div>;
    }
  }
}

export default DashboardItem;
