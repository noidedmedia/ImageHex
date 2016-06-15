import { CurrencyInputField } from '../currency_input.es6.jsx';

function optionFieldName(index, name) {
  return `listing[options_attributes][${index}][${name}]`;
}


const FieldsSection = ({children}) => (
  <div className="fields-section">
    {children}
  </div>
);


const NameField = ({defaultValue, index}) => (
  <FieldsSection>
    <label>
      Name
    </label>
    <input type="text"
      name={optionFieldName(index, "name")}
      defaultValue={defaultValue} />
  </FieldsSection>
);

const DescriptionField = ({defaultValue, index}) => (
  <FieldsSection>
    <label>
      Description
    </label>
    <textarea
      defaultValue={defaultValue}
      name={optionFieldName(index, "description")}
    />
  </FieldsSection>
);

function priceFieldClass(qo) {
  var c = "fields-section price-fields-section";
  if(qo) {
    return c + " active";
  }
  else {
    return c + " inactive";
  }
}

const PriceField = ({defaultValue, index, quoteOnly}) => (
  <div className={priceFieldClass(quoteOnly)}>
    <label>
      Price
    </label>
    <CurrencyInputField
      initialValue={defaultValue}
      minimum={0}
      name={optionFieldName(index, "price")} />
  </div>
);

const IDField = ({id, index}) => {
  if(! id) {
    return <span></span>;
  } 
  else {
    return <input type="hidden"
      name={optionFieldName(index, "id")}
      value={id} />;
  }
};

export {optionFieldName, 
  NameField, 
  DescriptionField, 
  PriceField,
  IDField,
  FieldsSection
};
