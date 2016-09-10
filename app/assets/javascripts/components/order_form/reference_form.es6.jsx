import ImageField from './image_field.es6.jsx';
import RemovedImageField from './removed_image_field.es6.jsx';
import TagGroupFieldsEditor from '../tag_groups/fields_editor.es6.jsx';

class ReferenceForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      images: [...(props.reference.images || []), {key: 0}],
      className: "reference-group-fields",
      style: undefined,
      removedImages: []
    };
    this.imageKey = -1;
  }

  render() {
    const categoryName = this.props.category.name;
    const reference = this.props.reference;
    const fieldName = this.fieldName.bind(this);
    return <li className={this.state.className}>
      {this.idField()}
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
          className="rounded-text-area" />
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
          initialTags={this.props.reference.tags}
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

  idField() {
    if(this.props.reference.id > 0) {
      return <input type="hidden"
        name={this.fieldName("id")}
        value={this.props.reference.id} />;
    }
    return <span></span>;
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
    let index = 0;
    if(this.state.images.length !== 0) {
      let alive = this.state.images.map((img, i) => {
        index++;
        return <ImageField
          image={img}
          baseFieldName={fieldName("images_attributes") + `[${index}]`}
          removeSelf={this.removeImage.bind(this, i)}
          key={img.id || img.key}
          addImage={this.addImage.bind(this)}
          />;
      });
      let dead = this.state.removedImages
        .map((i) => {
          index++;
          return <RemovedImageField
            id={i.id}
            key={i.id || i.key}
            baseFieldName={fieldName("images_attributes") + `[${index}]`}
          />;
        });
      return [...alive, ...dead];
    }
    else {
      return <div></div>;
    }
  }

  removedReferenceImageFields() {
    const reference = this.props.reference;
    const fieldName = this.fieldName
  }

  addImage() {
    this.setState({
      images: [...this.state.images, {key: this.imageKey}]
    });
    this.imageKey = this.imageKey - 1;
  }

  removeImage(index) {
    console.log("removing index", index);
    let {images} = this.state;
    const img = images.splice(index, 1);
    this.setState({
      images: images,
      removedImages: [...this.state.removedImages, ...img]
    });
  }
}

export default ReferenceForm;
