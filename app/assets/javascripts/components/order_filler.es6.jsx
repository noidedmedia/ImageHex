import ImagePicker from './image_picker/image_picker.es6.jsx';
import NM from '../api/global.es6';
import ReactUJS from '../react_ujs';
import React, { Component } from 'react';

class OrderFiller extends Component {
  constructor(props) {
    super(props);
    this.state = {
      page: 1,
      selectedImages: [],
      activeImages: []
    };
  }

  render() {
    return <div>
      <div className="fill-header">
        <h3>Fill Order</h3>
        <div className="description">
          <span>To fill this order, </span>
          <a href="/images/new">upload a new image</a>,
          then select it here.
        </div>
      </div>
      <ImagePicker
        imageCollection={this.state.activeImages}
        selectedImages={this.state.selectedImages}
        changeSelected={this.changeSelected.bind(this)} />
      {this.formField}
      {this.submitButton}
    </div>;
  }

  changeSelected(newSelected) {
    let ns = newSelected[newSelected.length - 1];
    this.setState({
      selectedImages: [ns]
    });
  }

  get formField() {
    if(this.state.selectedImages.length > 0) {
      let img = this.state.selectedImages[0];
      return <input type="hidden"
        name="image_id"
        value={img.id} />;
    }
    return <span></span>;
  }
  get submitButton() {
    if(this.state.selectedImages.length > 0) {
      return <button type="submit"
        className="checkmark-submit-button">
        Fill Order
      </button>
    }
    return <span></span>
  }

  componentDidMount() {
    this.fetchImages();
  }

  async fetchImages() {
    this.setState({
      fetching: true
    });
    let { page } = this.state;
    let id = window.CURRENT_USER_ID;
    let date = new Date(this.props.chargeTime);
    let url = `/users/${id}/creations.json?page=${page}`;
    url += `&created_after=${date.getTime() / 1000}`;
    console.log("Fetching with url",url);
    let resp = await NM.getJSON(url);
    this.setState({
      activeImages: resp.images,
      fetching: false,
      page: resp.current_page,
      total_pages: resp.total_pages
    });
  }
}

ReactUJS.register("OrderFiller", OrderFiller);
