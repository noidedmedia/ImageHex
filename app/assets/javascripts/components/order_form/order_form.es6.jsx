import CategoryForm from './category_form.es6.jsx';
import OptionForm from './option_form.es6.jsx';

function aspectSort(a, b) {
  var o = a.option_id - b.option_id;
  return o ? o : a.id - b.id;
}

class OrderForm extends React.Component {
  constructor(props) {
    super(props);
    var checkedOptions = {};
    for(var i = 0; i < (props.aspects || []).length; i++) {
      checkedOptions[props.aspects[i].id] = true;
    }
    this.state = {
      aspects: (props.aspects || []),
      aspectKey: -1,
      checkedOptions: checkedOptions
    };
  }

  render() {
    var aspects = this.state.aspects
      .sort(aspectSort);
    var options = this.props.listing.options
      .sort((a, b) => a.id - b.id)
      .map((o, i) => {
        var underAspects = aspects.filter((a) => a.option_id === o.id);
        if(o.reference_category) {
          return <CategoryForm
            index={i}
            key={o.id}
            {...o}
            aspects={underAspects}
            addAspect={this.addAspect.bind(this, o)} />
        }
        else {
          var originallyChecked = underAspects.length !== 0;
          return <OptionForm
            key={o.id}
            {...o}
            originallyChecked={originallyChecked}
            originalAspects={underAspects}
            index={i}
            checked={this.state.checkedOptions[o.id]}
            toggleCheck={this.toggleOptionCheck.bind(this, o.id)} />;
        }
      });
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
    var price = this.props.listing.options.filter((o) => o.reference_category)
      .map((o) => {
        var listings = this.state.aspects.filter(a => a.option_id == o.id);
        return Math.max(listings.length - o.free_count,0) * o.price;
      }).reduce((a, b) => a + b, 0);
    price += this.props.listing.base_price;
    var optionPrice = this.props.listing.options.filter((l) => {
      return ! l.reference_category;
    })
    .map((o) => this.state.checkedOptions[o.id] ? o.price : 0);
    price += optionPrice;
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

  toggleOptionCheck(id, event) {
    this.state.checkedOptions[id] = event.target.checked;
    this.setState({
      checkedOptions: checkedOptions
    });
  }
}

window.OrderForm = OrderForm;
export default OrderForm;
