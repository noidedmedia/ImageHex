import PriceSection from './price_section.es6.jsx';
import OptionSection from './option_section.es6.jsx'; 

class ListingForm extends React.Component {
  constructor(props) {
    super(props);
    var rcount = props.options.filter((o) => o.reference_category).length;
    this.state = {
      ...props,
      refCatCount: rcount
    };
  }

  render() {
    return <div>
      <PriceSection {...this.state} 
        toggleCheck={this.toggleCheck.bind(this)}
        />
      <OptionSection options={this.props.options} 
        quoteOnly={this.state.quote_only}
        addRefCat={this.addRefCat.bind(this)}
        removeRefCat={this.removeRefCat.bind(this)}
      />

    <button type="submit"
      disabled={this.state.refCatCount == 0}
      >
      Submit
    </button>
    </div>;
  }

  toggleCheck() {
    this.setState({
      quote_only: ! this.state.quote_only
    });
  }

  addRefCat() {
    this.setState({
      refCatCount: this.state.refCatCount + 1
    });
  }

  removeRefCat() {
    console.log(`Removing a refcat with a current count of ${this.state.refCatCount}`);
    this.setState({
      refCatCount: this.state.refCatCount - 1
    });
  }
}

window.ListingForm = ListingForm;

export default ListingForm;
