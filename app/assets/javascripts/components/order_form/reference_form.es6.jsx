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
    const reference = this.props.reference;
    const fieldName = this.fieldName.bind(this);
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
      </div>
      <input type="hidden"
        name={fieldName("listing_category_id")}
        value={this.props.category.id} />
      <h3>Reference Images</h3>
      <span>
        Provide images that will help the artist fullfil this commission.
      </span>
      <ul className="reference-image-list">
        {this.referenceImageFields()}
        <li onClick={this.addImage.bind(this)}
          className="add-reference-image-button third-box">
          <span>+</span>
        </li>
      </ul>
      <hr/>
      <a onClick={this.props.removeSelf}
        className="reference-remove-button">
        <span>Remove</span>
      </a>
    </li>;
  }

  fieldName(name) {
    const {reference} = this.props;
    return `order[references_attributes][${reference.index}][${name}]`
  }

  referenceImageFields() {
    const reference = this.props.reference;
    const fieldName = this.fieldName.bind(this);
    if(this.state.images.length !== 0) {
      return this.state.images.map((img, index) => {
        return <ImageField
          image={img}
          baseFieldName={fieldName("images_attributes") + index}
          removeSelf={this.removeImage.bind(this, index)}
          key={img.id || img.key}/>;

      });
    }
    else {
      return <div></div>;
    }
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
