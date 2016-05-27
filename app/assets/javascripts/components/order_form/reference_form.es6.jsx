class ReferenceForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      images: props.images || []
    };
  }

  render() {
    const {reference} = this.props;
    const fieldName = (name) => (
      `order[references_attributes][${reference.index}][${name}]`
    );
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

      <button onClick={this.props.removeSelf}
        type="button"
        className="remove-button">
        Remove
      </button>
    </div>;
  }
}

export default ReferenceForm;
