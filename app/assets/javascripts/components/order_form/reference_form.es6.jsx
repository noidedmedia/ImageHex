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
    return <div className="reference-group-fields">
      <div className="fields-section">
        <label htmlFor={fieldName("description")}>
          Description
        </label>
        <textarea name={fieldName("description")}
          defaultValue={reference.description} />
      </div>
      <input type="hidden"
        name={fieldName("listing_category_id")}
        value={this.props.category.id} />
      <ul className="reference-image-list">
        {imgs}
      </ul>
      <button onClick={this.addImage.bind(this)}
        type="button">
        Add Image
      </button>
      <button onClick={this.props.removeSelf}
        type="button"
        className="remove-button">
        Remove
      </button>
    </div>;
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
