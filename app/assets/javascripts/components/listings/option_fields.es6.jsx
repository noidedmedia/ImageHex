import {CurrencyInputField} from '../currency_input.es6.jsx';


class OptionFields extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      checked: props.reference_category
    };
  }

  render() {
    var {option, index, quoteOnly, removeSelf} = this.props;
    function fieldName(name) {
      return `listing[options_attributes][${index}][${name}]`;
    }

    var priceFieldClass = "price-field-section";
    if(quoteOnly) {
      priceFieldClass += " inactive";
    }
    else {
      priceFieldClass += " active";
    }
    var idField = "";
    if(option.id) {
      idField = <input type="hidden"
        value="option.id"
        name={fieldName("id")}
      />;
    }

    return <li className="option-fields-section">
      <div className="fields-section">
        <label>
          Name
        </label>
        <input type="text"
          initialValue={option.name}
          name={fieldName("name")} />
      </div>
      <div className="fields-section">
        <label>
          Description
        </label>
        <textarea
          initialValue={option.description}
          name={fieldName("description")} />
      </div>
      <div className="row-fields-section">
        <div className={"fields-section " + priceFieldClass} >
          <label>
            Price
          </label>
          <CurrencyInputField
            initialValue={option.price}
            name={fieldName("price")} />
        </div>

        <div className="fields-section">
          <label>
            Number free
          </label>
          <input type="number"
            name={fieldName("free_count")}
            min={0}
            step={1}
            initialValue={option.free_count || "0"} />
        </div>

        <div className="fields-section">
          <label>
            Maximum Allowed
          </label>
          <input type="number"
            name={fieldName("max_allowed")}
            min={1}
            initialValue={option.max_allowed || "50"} />
        </div>
      </div>
      <div className="row-fields-section">
        <div>
          <label htmlFor={fieldName("reference_category")}
            className="button-side-label">
            Reference Category?
          </label>
          <input
            type="checkbox"
            name={fieldName("reference_category")}
            onChange={this.changeCheck.bind(this)}
            value={this.state.checked} />
        </div>
        <a onClick={removeSelf}
          className="remove-option-button"
          href="#">
          Remove
        </a>
      </div>
      {idField}
    </li>;
  }
  changeCheck(event) {
    console.log("Got an event with value:",event.target.checked);
    if(event.target.checked) {
      console.log("Adding a ref cat");
      this.props.addRefCat();
    }
    else {
      console.log("Removing a ref cat");
      this.props.removeRefCat();
    }
    this.setState({
      checked: event.target.checked
    });
  }

  componentWillUnmount() {
    if(this.state.checked) {
      this.props.removeRefCat();
    }
  }
}

export default OptionFields;
