import { CurrencyInputField } from '../currency_input.es6.jsx';

function optionFieldName(index, name) {
  return `listing[options_attributes][${index}][${name}]`;
}


const FieldsSection = ({children, priceRelevant}, {quoteOnly}) => {
  let cn = "fields-section";
  if(priceRelevant) {
    cn += " price-relevant";
    if(quoteOnly) {
      cn += " inactive";
    }
  }
  return <div className={cn}>
    {children}
  </div>;
}

FieldsSection.contextTypes = {
  quoteOnly: React.PropTypes.bool
};


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

const PriceField = ({defaultValue, index}) => (
  <FieldsSection
    priceRelevant={true}>
    <label>
      Price
    </label>
    <CurrencyInputField
      initialValue={defaultValue}
      minimum={0}
      priceRelevant={true}
      name={optionFieldName(index, "price")} />
  </FieldsSection>
);

PriceField.contextTypes = {
  quoteOnly: React.PropTypes.bool
};

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
