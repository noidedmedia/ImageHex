import * as Common from './common_fields.es6.jsx';
import { CurrencyInputField } from '../currency_input.es6.jsx';

class CategoryFields extends React.Component {  
  constructor(props) {
    super(props);
  }

  render() {
    var {category, index, quoteOnly, removeSelf} = this.props;
    const fieldName = (name) => (
      `listing[categories_attributes][${index}][${name}]`
    );
    return <li className="option-fields-section">
      <Common.FieldsSection>
        <label htmlFor={fieldName("name")}>
          Name
        </label>
        <input type="text"
          name={fieldName("name")}
          defaultValue={this.props.name} />
      </Common.FieldsSection>
      <Common.FieldsSection>
        <label htmlFor={fieldName("description")}>
          Description
        </label>
        <textarea
          name={fieldName("description")}
          defaultValue={this.props.description} />
      </Common.FieldsSection>
      <div className="row-fields-section">
        <Common.FieldsSection>
          <label hmtlFor={fieldName("price")}>
            Price
          </label>
          <CurrencyInputField
            initialValue={this.props.price || 0}
            name={fieldName("price")} />
        </Common.FieldsSection>
        <Common.FieldsSection>
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
          className="remove-text-red remove-option-button"
          href="#">
          Remove
        </a>
      </div>
      <input type="hidden"
        name={fieldName("id")}
        value={this.props.id} />
    </li>;
  }
}

export default CategoryFields;
