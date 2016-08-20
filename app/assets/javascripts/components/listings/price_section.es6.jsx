import {CurrencyInputField} from '../currency_input.es6.jsx';

class PriceSection extends React.Component {
  constructor(props){
    super(props);
    this.state = props;
  }

  render() {
    return <div className="listing-overall-prices">
      <div className="flex-row-mobile-column big-description">
        <div>
          <label htmlFor="listing[quote_only]"
            className="big-label">
            Quote Prices?
          </label>
          <div className="field-description">
            You will determine the price on a case-by-case basis, 
            and provide the user with a quote.
            This will disable automatic price calculation.
          </div>
        </div>
        <input type="checkbox"
          checked={this.props.quote_only}
          onChange={this.toggleCheck.bind(this)} />
        <input type="hidden"
          name="listing[quote_only]"
          value={this.props.quote_only} />
      </div>
      <div 
        className={"flex-row-mobile-column big-description " + this.priceClass}>
        <div>
          <label htmlFor="listing[base_price]">
            Base Price
          </label>
        </div>
        <CurrencyInputField min={0} 
          initialValue={500}
          name="listing[base_price]" />
      </div>
    </div>;
  }


  get priceClass() {
    return (this.props.quote_only ? " price-inactive" : " price-active");
  }

  toggleCheck() {
    this.props.toggleCheck();
  }
}

export default PriceSection;
