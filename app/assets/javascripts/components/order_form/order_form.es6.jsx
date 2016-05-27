import OptionsForm from './options_form.es6.jsx';

class OrderForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      orderOptions: (props.order_options) || []
    };
  }

  render() {
    return <div>
      <OptionsForm
        options={this.props.listing.options}
        orderOptions={this.state.orderOptions}
        addOrderOption={this.addOrderOption.bind(this)}
        removeOrderOption={this.removeOrderOption.bind(this)}
      />
      {this.getPrice()}
    </div>
  }

  addOrderOption(option_id) {
    const n = {listing_option_id: option_id}
    this.setState({
      orderOptions: [...this.state.orderOptions, n]
    });
  }

  removeOrderOption(index) {
    this.state.orderOptions.splice(index, 1);
    this.setState({
      orderOptions: this.state.orderOptions
    });
  }

  getPrice() {
    if(this.props.listing.quote_only) {
      return <div>
        Artist will give a quote on the price
      </div>;
    }
    var price = this.props.listing.base_price;
    const oprice = this.optionPrice();
    price += oprice;
    return <div>
      Price: ${price / 100}
    </div>;
  }

  optionPrice() {
    var prices = this.props.listing.options.map((option) => {
      var o = this.state.orderOptions.filter((oo) => (
        oo.listing_option_id === option.id
      ));
      if(o.length != 0) {
        return option.price;
      }
      else {
        return 0;
      }
    });
    const sum = prices.reduce((a, b) => a + b);
    return sum;
  }
}

window.OrderForm = OrderForm;
export default OrderForm;
