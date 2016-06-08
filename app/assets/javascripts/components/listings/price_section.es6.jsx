import {CurrencyInputField} from '../currency_input.es6.jsx';

class PriceSection extends React.Component {
  constructor(props){
    super(props);
    this.state = props;
  }

  render() {
    return <div className="row-fields-section">
      <div>
        <label htmlFor="listing[quote_only]">
          Quote only?
        </label>
        <input type="checkbox"
          name="listing[quote_only]"
          state={this.props.quote_only}
          onChange={this.toggleCheck.bind(this)} />
      </div>
      <div className={this.inputClassName}>
        <label htmlFor="listing[base_price]">
          Base Price
        </label>
        <CurrencyInputField min={0} 
          initialValue={500}
          name="listing[base_price]" />
      </div>
    </div>;
  }

  get inputClassName() {
    var base = "price-field-section";
    if(this.props.quote_only) {
      return base + " inactive";
    }
    else {
      return base + " active";
    }
  }

  toggleCheck() {
    this.props.toggleCheck();
  }
}

export default PriceSection;