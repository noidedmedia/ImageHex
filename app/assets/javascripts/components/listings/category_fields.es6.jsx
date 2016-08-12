import * as Common from './common_fields.es6.jsx';
import { CurrencyInputField } from '../currency_input.es6.jsx';

class CategoryFields extends React.Component {  
  constructor(props) {
    super(props);
    let category = this.props.category || {}
    this.state = {
      name: category.name || "",
      description: category.description || "",
      price: category.price || 0
    };
  }

  render() {
    var {category, index, quoteOnly, removeSelf} = this.props;
    category = category || {};
    const fieldName = (name) => (
      `listing[categories_attributes][${index}][${name}]`
    );
    return <li className="option-fields-section">
      <Common.FieldsSection>
        <label htmlFor={fieldName("name")}>
          Name
        </label>
        {this.nameWarning}
        <input type="text"
          name={fieldName("name")}
          value={this.state.name} 
          onChange={this.changeName.bind(this)} 
          required={true}/>
      </Common.FieldsSection>
      <Common.FieldsSection>
        <label htmlFor={fieldName("description")}>
          Description
        </label>
        <textarea
          name={fieldName("description")}
          defualtValue={this.state.description}
          required={true} />
      </Common.FieldsSection>
      <div className="row-fields-section">
        <Common.FieldsSection
          priceRelevant={true}>
          <label hmtlFor={fieldName("price")}>
            {this.priceLabel}
          </label>
          <CurrencyInputField
            initialValue={this.state.price}
            name={fieldName("price")} />
        </Common.FieldsSection>
        <Common.FieldsSection
          priceRelevant={true}>
          <label>
            Number free
          </label>
          <input type="number"
            name={fieldName("free_count")}
            min={0}
            step={1}
            defaultValue={category.free_count || "0"} />
        </Common.FieldsSection>
        <Common.FieldsSection>
          <label>
            Maximum Allowed
          </label>
          <input type="number"
            name={fieldName("max_count")}
            min={1}
            defaultValue={category.max_count || "10"} />
        </Common.FieldsSection>
        <a onClick={removeSelf}
          className="remove-text-red remove-option-button">
          Remove
        </a>
      </div>
      <input type="hidden"
        name={fieldName("id")}
        value={this.props.id} />
    </li>;
  }

  get priceLabel() {
    let { name } = this.state;
    if(name === "") {
      return "Price";
    }
    else {
      return `Price per ${name}`;
    }
  }

  get nameWarning() {
    let { name } = this.state;
    name = name.trim();
    if(name.endsWith("s")) {
      let ne = name.substring(0, name.length - 1);
      return <div className="field-warning">
        Category names should be singular.
        Consider "{ne}" instead.
      </div>;
    }
    else {
      return "";
    }
  }

  changeName(event) {
    this.setState({
      name: event.target.value
    });
  }
}

CategoryFields.contextTypes = {
  quoteOnly: React.PropTypes.bool
};


export default CategoryFields;
