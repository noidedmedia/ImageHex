import React from 'react';
import ExampleImageSection from './example_image_section.es6.jsx';
import ReactUJS from '../../react_ujs';

class ListingForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      ...props,
    };
    this.categoryFakeId = -1;
    this.fakeOptionId = -1;
  }

  render() {
    return <div id="listing-form">
      <ExampleImageSection />
    <button type="submit"
      className="checkmark-submit-button">
      Save Listing
    </button>
    </div>;
  }
}

ListingForm.childContextTypes = {
  quoteOnly: React.PropTypes.bool
};


ReactUJS.register("ListingForm", ListingForm);

export default ListingForm;
