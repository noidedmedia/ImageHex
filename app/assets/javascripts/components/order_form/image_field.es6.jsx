class ImageField extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      imgURL: props.image.url,
      hasUploaded: !! props.image.url,
      containerClass: "reference-image-fields"
    };
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
      preview = <div className="preview-inner">
        <img src={this.state.imgURL} />
      </div>;
    }
    else {
      className = className + " inactive";
      preview = <div className="preview-inner">
        <div>Click or drag to upload</div>
      </div>;
    }
    return <li className={className}>
      {this.idField()}
      <div className="reference-image-preview-section">
        {preview}
        <input name={fieldName("img")}
          onChange={this.change.bind(this)}
          type="file" />;
      </div>
      <div className="reference-image-info-section">
        <label 
          className="larger-label"
          for={fieldName("description")}>
          Description
        </label>
        <textarea 
          name={fieldName("description")}
          defaultValue={this.props.image.description} />
        <div className="column-right-align">
          <a href="#"
            onClick={this.remove.bind(this)}
            className="commission-remove-button">
            Remove Reference Image
          </a>
        </div>
      </div>
    </li>;
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
    this.setState({
      containerClass: this.state.containerClass + " removed"
    }, () => {
      // Kill after animation finishes
      window.setTimeout(() => {
        this.props.removeSelf();
      }, 990);
    });
  }

  idField() {
    if(this.props.image.id > 0) {
      return <input
        type="hidden"
        name={`${this.props.baseFieldName}[id]`}
        value={this.props.image.id} />;
    }
    return <span></span>;
  }
}

export default ImageField;
