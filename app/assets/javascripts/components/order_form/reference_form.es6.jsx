import ImageField from './image_field.es6.jsx';

class ReferenceForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      images: props.images || []
    };
    this.imageKey = 0;
  }

  render() {
    const {reference} = this.props;
    const fieldName = (name) => (
      `order[references_attributes][${reference.index}][${name}]`
    );
    const imgs = this.state.images.map((img, index) => {
      return <ImageField
        image={img}
        baseFieldName={fieldName("images_attributes") + index}
        removeSelf={this.removeImage.bind(this, index)}
        key={img.id || img.key}/>;

    });
    return <li className="reference-group-fields">
      <div className="reference-group-fields-header">
        <div className="fields-section">
          <label htmlFor={fieldName("description")}
            className="larger-label">
            Description
          </label>
          <textarea name={fieldName("description")}
            defaultValue={reference.description} 
            className="reference-description" />
        </div>
        <a onClick={this.props.removeSelf}
          className="reference-remove-button">
          <span>Remove</span>
        </a>
      </div>
      <input type="hidden"
        name={fieldName("listing_category_id")}
        value={this.props.category.id} />
      <a onClick={this.addImage.bind(this)}
        href="#"
        className="green-add-button">
        Add Reference Image
      </a>
      <ul className="reference-image-list">
        {imgs}
      </ul>

    
    </li>;
  }

  addImage() {
    this.setState({
      images: [...this.state.images, {key: this.imageKey}]
    });
    this.imageKey = this.imageKey - 1;
  }

  removeImage(index) {
    let {images} = this.state;
    const img = images.splice(index, 1);
    this.setState({
      images: images
    });
  }
}

export default ReferenceForm;
