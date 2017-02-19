import React, { Component }  from 'react';
import TextareaInput from '../shared/textarea_input';
import TagGroupFieldsEditor from '../tag_groups/fields_editor';
import TransitionGroup from 'react-addons-css-transition-group';
import ImageField from './image_field';


class ReferenceGroupForm extends Component {
  constructor(props) {
    super(props);
    let imgs = (props.group.images || []);
    imgs = imgs.map(img => Object.assign({}, img, {key: img.id}));
    this.state = {
      images: [...imgs, {key: 0}],
      removedImageIds: []
    };
    this.imgKey = -1;
  }

  fieldName(name) {
    return `${this.props.baseFieldName}[${name}]`;
  }

  render() {
    let images = this.state.images.map((img, index) => {
      let fname = `${this.fieldName("images_attributes")}[${index}]`;
      return <ImageField
        image={img}
        baseFieldName={fname}
        removeSelf={this.removeImage.bind(this, index)}
        key={img.key}
        addImage={this.addImage.bind(this)} />;
    });
    return <li className="reference-group-fields">
      <TransitionGroup
        className="reference-image-list"
        transitionName="order-slide"
        transitionEnterTimeout={500}
        transitionLeaveTimeout={500}>
        {images}
      </TransitionGroup>
      <TextareaInput
        name={this.fieldName("description")}
        required={true}
        label="Group Description" />
      <TagGroupFieldsEditor
        initialTags={this.props.group.tags}
        fieldName={this.fieldName("tag_ids")} />
      <button className="commission-remove-button btn-remove"
        onClick={this.removeSelf.bind(this)}>
        Remove Group
      </button>
    </li>;
  }

  addImage() {
    this.setState({
      images: [...this.state.images, {key: this.imgKey--}]
    });
  }

  removeImage(index) {
    let dup = this.state.images.slice();
    let rem = dup.splice(index, 1);
    let ids = this.state.removedImageIds;
    if(rem.id) {
      ids = [...ids, rem.id];
    }
    this.setState({
      images: dup,
      removedImageIds: ids
    });
  }

  removeSelf(event) {
    event.preventDefault();
    if(confirm("Are you sure?")) {
      this.props.removeSelf();
    }
  }
}

export default ReferenceGroupForm;
