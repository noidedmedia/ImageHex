import React from 'react';
import UJS from '../../react_ujs';

class ImageBrowserForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      order: props.order
    }
  }

  render() {
    return <form action="/images/" method="get" className="browse-form">
      <div className="order-select-container">
        <label htmlFor="order">Order</label>
        <select value={this.state.order} name="order"
          onChange={this.changeOrder.bind(this)}>
          <option value="creation">Creation</option>
          <option value="creation_reverse">Creation (reversed)</option>
          <option value="popularity">Popularity</option>
        </select>
      </div>
      <input type="submit" value="Go"/>
    </form>;
  }

  changeOrder(event) {
    console.log(event.target.value);
    this.setState({
      order: event.target.value
    });
  }
}
UJS.register("ImageBrowserForm", ImageBrowserForm);

export default ImageBrowserForm;
