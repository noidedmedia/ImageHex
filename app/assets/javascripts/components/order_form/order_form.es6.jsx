import OptionForm from './option_form.es6.jsx';

function aspectSort(a, b) {
  var o = a.option_id - b.option_id;
  return o ? o : a.id - b.id;
}

class OrderForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      aspects: (props.aspects || []),
      aspectKey: -1
    };
  }

  render() {
    var aspects = this.state.aspects
      .sort(aspectSort);
    var options = this.props.listing.options
      .sort((a, b) => a.id - b.id)
      .map((o) => {
        var underAspects = aspects.filter((a) => a.option_id === o.id);
        return <OptionForm
          key={o.id}
          {...o}
          aspects={underAspects}
          addAspect={this.addAspect.bind(this, o)} />
      });
    console.log(options);
    return <div>
      <div className="options-container">
        {options}
      </div>
      <div className="total-price-container">
        {this.totalPrice()}
      </div>
    </div>;
  }

  totalPrice() {
    if(this.props.listing.quote_only) {
      return <div>
        Artist will decide price
      </div>;
    }
    var price = this.props.listing.options.map((o) => {
      var listings = this.state.aspects.filter(a => a.option_id == o.id);
      return Math.max(listings.length - o.free_count,0) * o.price;
    }).reduce((a, b) => a + b, 0);
    price += this.props.listing.base_price;
    return <div>
      ${price/100}
    </div>;
  }

  addAspect(option) {
    var k = this.state.aspectKey;
    var n = {
      option_id: option.id,
      key: k
    };
    this.setState({
      aspects: [...this.state.aspects, n],
      aspectKey: k - 1
    });
  }
}

window.OrderForm = OrderForm;
export default OrderForm;
