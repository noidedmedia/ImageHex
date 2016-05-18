class OptionForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    return <div className="option-form">
      <div className="header">
        <input type="checkbox"
          checked={this.props.checked}
          onChange={this.props.toggleCheck} />
        <div>
          <h1>{this.props.name}</h1>
          <h2>${this.props.price / 100}</h2>
        </div>
      </div>

      <div className="description">
        {this.description}
      </div>

      {this.aspectFields()}
    </div>;
  }

  /**
   * Grab the actual fields that create an aspect on this order
   */
  aspectFields() {
    var fieldName = (name) => (
      `order[aspects_attributes][${this.props.index}][${name}]`
    );
    if(this.props.originallyChecked) {
      // no longer checked, destroy aspect
      if(! this.props.checked) {
        var id = props.originalAspects[0].id;
        return <div>
          <input name={fieldName("id")}
            value={id} />
          <input name={fieldName("_destroy")}
            value="1" />
        </div>
      }
    }
    // Now checked, create aspect
    else if(this.props.checked) {
      return <div>
        <input name={fieldName("description")}
          value="t" />
        <input name={fieldName("option_id")}
          value={o.id} />
      </div>;
    }
    return <div></div>;
  }
}

export default OptionForm;
