class ImageField extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      imgUrl: props.url
    };
  }

  render() {
    const fieldName = (name) => (
      `${this.props.baseFieldName}[${name}]`
    );
    const removeButton = <button
      type="button"
      onClick={this.props.removeSelf}>
      Remove
    </button>;

    return <div>
      <input type="file"
        name={fieldName("img")} />
      {removeButton}
    </div>;
  }
}

export default ImageField;
