import OptionFields from './option_fields.es6.jsx';

class OptionSection extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      options: props.options,
      deletedOptions: []
    };
  }

  render() {
    var options = this.props.options.map((o, i) => {
      return <OptionFields
        option={o}
        index={i}
        quoteOnly={this.props.quoteOnly}
        removeSelf={this.props.removeOption.bind(null, i)}
        addRefCat={this.props.addRefCat}
        removeRefCat={this.props.removeRefCat}
        key={i} />
    });
    let removed = this.props.removedOptions.map((o, i) => {
      let index = this.props.options.length + 1 + i;
      return <div key={index}>
        <input name={`listing[options_attributes][${index}][id]`}
          type="hidden"
          value={o.id} />
        <input name={`listing[options_attributes][${index}][_destroy]`}
          type="hidden"
          value="true" />
      </div>;
    });
    return <div className="listing-form-section">
      <div className="listing-form-section-header">
        <h1>Options</h1>
        <div className="description">
          Optional features for this commission.
          May include inked linework, proper shading, or anything else you can provide to clients.
          If an option requires reference material, make it a charged reference category instead.
          If an option significently changes a commission in terms of price or time to completion, consider making a new listing instead.
        </div>
        <a 
          className="add-option-button green-add-button"
          onClick={this.props.addOption}>
          Add an Option
        </a>
      </div>
      <ul className="options-container">
        {options}
      </ul>
      {removed}
    </div>;
  }
}

export default OptionSection;
