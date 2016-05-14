import * as Common from './option_common.es6.jsx';


class ReferenceCategoryFields extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      checked: props.category.reference_category
    };
  }

  render() {
    var {category, index, quoteOnly, removeSelf} = this.props;
    const fieldName = Common.optionFieldName.bind(null, index);
    return <li className="option-fields-section">
      <Common.NameField
        index={index}
        defaultValue={category.name} />
      <Common.DescriptionField
        index={index}
        defaultValue={category.description} />
      <div className="row-fields-section">
        <Common.PriceField
          defaultValue={category.price}
          index={index}
        />
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
            name={fieldName("max_allowed")}
            min={1}
            defaultValue={category.max_allowed || "1"} />
        </Common.FieldsSection>
        <a onClick={removeSelf}
          className="remove-option-button"
          href="#">
          Remove
        </a>
      </div>
      <input type="hidden"
        name={fieldName("reference_category")}
        value="true" />
      <Common.IDField id={category.id} index={index} />
    </li>;
  }

  componentDidMount() {
    this.props.addRefCat();
  }

  componentWillUnmount() {
    this.props.removeRefCat();
  }
}

export default ReferenceCategoryFields;
