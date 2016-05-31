class ImageField extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      imgUrl: props.url,
      containerClass: "reference-image-fields"
    };
  }

  render() {
    const fieldName = (name) => (
      `${this.props.baseFieldName}[${name}]`
    );
    const removeButton = <button
      type="button"
      onClick={this.remove.bind(this)}>
      Remove
    </button>;
    var preview;
    if(this.state.imgURL) {
      preview = <div>
        <img src={this.state.imgURL} />
      </div>;
    }
    else {
      preview = <div>Click or drag to upload</div>;
    }
    return <li className={this.state.containerClass}>
      <div className="reference-preview-section">
        <div className="reference-image-preview">
          {preview}
        </div>
        <input type="file"
          name={fieldName("img")}
          onChange={this.change.bind(this)} />
      </div>
      <div className="fields-section">
        <label htmlFor={fieldName("description")}>
          Description (optional)
        </label>
        <textarea name={fieldName("description")} />
      </div>
      {removeButton}
    </li>;
  }

  change(event) {
    const file = event.target.files[0];
    var reader = new FileReader();
    reader.addEventListener("load", () => {
      this.setState({
        imgURL: reader.result
      });
    }, false);

    if(file) {
      reader.readAsDataURL(file);
    }
  }

  remove() {
    this.setState({
      containerClass: this.state.containerClass + " removed"
    }, () => {
      // Kill after animation finishes
      window.setTimeout(() => {
        this.props.removeSelf();
      }, 500);
    });
  }
}

export default ImageField;
