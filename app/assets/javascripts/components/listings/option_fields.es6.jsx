import {CurrencyInputField} from '../currency_input.es6.jsx';

var OptionFields = ({option, index, quoteOnly, removeSelf}) => {
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
    <a onClick={removeSelf}
      className="remove-option-button"
      href="#">
      Remove
    </a>
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
    {idField}
  </li>;
};

export default OptionFields;
