import React from 'react';
import TextareaInput from '../shared/textarea_input';

class ImageField extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      imgURL: props.image.medium_url,
      hasUploaded: !! props.image.medium_url,
      containerClass: "reference-image-fields"
    };
  }

  fieldName(name) {
    return `${this.props.baseFieldName}[${name}]`;
  }

  render() {
    const fieldName = (name) => {
      if(this.state.hasUploaded && name == 'img') {
        return "";
      }
      else if(this.state.imgURL) {
        return `${this.props.baseFieldName}[${name}]`;
      }
      else {
        return "";
      }
    }
    var className = this.state.containerClass;
    var preview;
    if(this.state.imgURL) {
      className = className + " active";
      preview = <div className="preview-inner active">
        <img src={this.state.imgURL} />
      </div>;
    }
    else {
      className = className + " inactive";
      preview = <div className="preview-inner inactive">
        <div>Click or drag to add a reference image</div>
      </div>;
    }
    return <div className={className}>
      {this.idField()}
      <div className="reference-image-preview-section">
        {preview}
        <input name={fieldName("img")}
          onChange={this.change.bind(this)}
          type="file" />;
      </div>
      <div className="reference-image-info-section">
        <textarea
          className="reference-image-input"
          placeholder="Image description"
          name={fieldName("description")}
          defaultValue={this.props.image.description} />
        <button
          onClick={this.remove.bind(this)}
          className="commission-remove-button">
          Remove Reference Image
        </button>
      </div>
    </div>;
  }

  change(event) {
    const file = event.target.files[0];
    var reader = new FileReader();
    reader.addEventListener("load", () => {
      if(! this.state.imgURL) {
        this.props.addImage();
      }
      this.setState({
        imgURL: reader.result,
        hasUploaded: false
      });
    }, false);

    if(file) {
      reader.readAsDataURL(file);
    }
  }

  remove(e) {
    e.preventDefault();
    this.props.removeSelf();
  }

  idField() {
    if(this.props.image.id) {
      return <input
        type="hidden"
        name={this.fieldName("id")}
        value={this.props.image.id} />;
    }
    return <span></span>;
  }
}

export default ImageField;
