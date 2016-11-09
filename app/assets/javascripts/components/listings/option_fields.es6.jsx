import * as Common from './common_fields.es6.jsx';

class OptionFields extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    var {option, index, quoteOnly, removeSelf} = this.props;
    var priceFieldClass = "price-field-section";
    var fieldName = Common.optionFieldName.bind(null, index);
    return <li className="option-fields-section">
      <Common.NameField
        index={index}
        defaultValue={option.name} />
      <Common.DescriptionField
        index={index}
        defaultValue={option.description} />
      <div className="row-fields-section">
        <Common.PriceField
          defaultValue={option.price}
          index={index} />
        <a onClick={removeSelf}
          className="remove-text-red remove-option-button">
          Remove
        </a>
        {(option && option.id > 0) ? 
          <input type="hidden"
            name={`listing[options_attributes][${index}][id]`}
            value={option.id}/> : <span />}
      </div>
    </li>;
  }
}

OptionFields.contextTypes = {
  quoteOnly: React.PropTypes.bool
};

export default OptionFields;
