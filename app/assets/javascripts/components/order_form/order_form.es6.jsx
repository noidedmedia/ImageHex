import OptionsForm from './options_form.es6.jsx';
import ReferenceSection from './reference_section.es6.jsx';

class OrderForm extends React.Component {
  constructor(props) {
    super(props);
    var optionIds = (props.order_options || []).map(o => o.listing_option_id);
    this.state = {
      optionIds,
      references: (props.references) || []
    };
    this.refKey = 0;
  }

  render() {
    return <div>
      <div className="order-form-overall-description">
        <div className="heading">
          <label htmlFor="order[description]">
            Description
          </label>
          <div className="description-squared">
            Provide an overall description of what you would like
            {" " + this.props.listing.username} to create. 
          </div>
        </div>
        <div className="lower-section fields-section">
          <textarea 
            name="order[description]"
            defaultValue={this.props.description} />
        </div>
      </div>
      <ReferenceSection
        categories={this.props.listing.categories}
        references={this.state.references}
        addReference={this.addReference.bind(this)}
        removeReference={this.removeReference.bind(this)} />
      <OptionsForm
        options={this.props.listing.options}
        optionIds={this.state.optionIds}
        addOption={this.addOption.bind(this)}
        removeOption={this.removeOption.bind(this)}
      />
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

  addOption(option_id) {
    var ar = [...this.state.optionIds, option_id];
    var uniq = ar.filter((item, pos) => ar.indexOf(item) == pos);
    this.setState({
      optionIds: uniq
    });
  }

  removeOption(option_id) {
    var o = this.state.optionIds.filter((id) => id != option_id);
    this.setState({
      optionIds: o
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
      var selected = this.state.optionIds.indexOf(option.id) != -1;
      if(selected) {
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
