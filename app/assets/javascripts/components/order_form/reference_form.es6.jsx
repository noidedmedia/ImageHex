import ImageField from './image_field.es6.jsx';
import TagGroupFieldsEditor from '../tag_groups/fields_editor.es6.jsx';

class ReferenceForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      images: [...(props.images || []), {key: 0}],
      className: "reference-group-fields",
      style: undefined
    };
    this.imageKey = -1;
  }

  render() {
    const categoryName = this.props.category.name;
    const reference = this.props.reference;
    const fieldName = this.fieldName.bind(this);
    return <li className={this.state.className}>
      <div className="fields-section">
        <label htmlFor={fieldName("description")}
          className="reference-group-section-header">
          Description
        </label>
        <div className="reference-group-section-description">
          Describe this {categoryName}
        </div>
        <textarea name={fieldName("description")}
          defaultValue={reference.description} 
          className="reference-description" />
      </div>
      <input type="hidden"
        name={fieldName("listing_category_id")}
        value={this.props.category.id} />
      <div className="reference-group-section-header">
        Reference Images
      </div>
      <div className="reference-group-section-description">
        Provide images that will help the artist depict this {categoryName}
      </div>
      <ul className="reference-image-list">
        {this.referenceImageFields()}
      </ul>
      <div className="reference-group-section-header">
        Tags
      </div>
      <div className="reference-group-section-description">
        Provide tags to describe this {categoryName}
      </div>
      <div className="reference-tag-group-editor">
        <TagGroupFieldsEditor
          initialTags={this.props.tags}
          fieldName={fieldName("tag_ids")} />
      </div>
      <div className="column-right-align">
        <a onClick={this.removeSelf.bind(this)}
          eref="#"
          className="commission-remove-button">
          Remove {categoryName}
        </a>
      </div>
    </li>;
  }

  removeSelf(e) {
    e.preventDefault();
    const cb = () => {
      setTimeout(() => {
        this.props.removeSelf();
      }, 1000);
    };
    this.setState({
      className: "reference-group-fields removed"
    }, cb);
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
          key={img.id || img.key}
          addImage={this.addImage.bind(this)}
          />;

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
