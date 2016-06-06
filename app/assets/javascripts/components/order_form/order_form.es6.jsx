import OptionsForm from './options_form.es6.jsx';
import ReferenceSection from './reference_section.es6.jsx';

class OrderForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      orderOptions: (props.order_options) || [],
      references: (props.references) || []
    };
    this.refKey = 0;
  }

  render() {
    return <div>
      <OptionsForm
        options={this.props.listing.options}
        orderOptions={this.state.orderOptions}
        addOrderOption={this.addOrderOption.bind(this)}
        removeOrderOption={this.removeOrderOption.bind(this)}
      />
      <ReferenceSection
        categories={this.props.listing.categories}
        references={this.state.references}
        addReference={this.addReference.bind(this)}
        removeReference={this.removeReference.bind(this)} />
      <div className="order-form-footer">
        {this.getPrice()}
        {this.submitButton()}
      </div>
    </div>
  }

  submitButton() {
    if(this.state.references.length > 0) {
      return <button 
        type="submit">
        Submit
      </button>;
    }
    return <button
      disabled="true">
      Add some reference material to submit
    </button>;
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

  addReference(category_id) {
    const n = {
      listing_category_id: category_id,
      key: this.refKey
    };
    this.refKey = this.refKey - 1;
    this.setState({
      references: [...this.state.references, n]
    });
  }

  removeReference(index) {
    var {references} = this.state;
    references.splice(index, 1);
    this.setState({
      references
    });
  }

  getPrice() {
    if(this.props.listing.quote_only) {
      return <div className="quoted-price">
        Artist will give a quote on the price
      </div>;
    }
    var price = this.props.listing.base_price;
    const oprice = this.optionsPrice();
    const refprice = this.referencesPrice();
    console.log("Prices:",{price, oprice, refprice});
    price += oprice + refprice;
    return <div className="price">
      Price: ${price / 100}
    </div>;
  }

  optionsPrice() {
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

  referencesPrice() {
    return this.props.listing.categories.map((cat) => {
      const refsUnder = this.refsUnder(cat);
      const refCount = refsUnder.length;
      const paidRefs = (refCount - cat.free_count);
      if(paidRefs <= 0) {
        return 0;
      }
      else {
        return paidRefs * cat.price;
      }
    }).reduce((a, b) => a + b);
  }

  refsUnder(category) {
    return this.state.references.filter((r) => (
      r.listing_category_id === category.id
    ));
  }
}

window.OrderForm = OrderForm;
export default OrderForm;
