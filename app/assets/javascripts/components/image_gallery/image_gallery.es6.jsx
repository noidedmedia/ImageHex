import React, { Component } from 'react';
import ReactUJS from '../../react_ujs';
import Store from './store';
import Image from './image';
import ScrollSigil from './scroll_sigil';

class ImageGallery extends Component {
  constructor(props) {
    super(props);
    this.store = new Store(props);
    this.store.addChangeHandler((s) => this.setState(s), false);
    this.state = this.store.getState();
  }


  render() {
    let imgs = this.state.images.map((i) => <Image {...i} key={i.id} />);
    let scrollSigil = <ScrollSigil
      hasFurther={this.state.hasFurther}
      fetchFurther={this.fetchFurther.bind(this)}
      listenerName="gallery-listener" />;
    let fetch = <span></span>;
    if(this.state.fetching) {
      fetch = <progress className="image-progress" />;
    }
    return <ul className="image-gallery">
      {imgs}
      {scrollSigil}
      {fetch}
    </ul>;
  }

  async fetchFurther() {
    this.store.fetchFurther();
  }
};

ReactUJS.register("ImageGallery", ImageGallery);

export default ImageGallery;
