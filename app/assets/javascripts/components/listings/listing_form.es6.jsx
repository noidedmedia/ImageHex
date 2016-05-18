import PriceSection from './price_section.es6.jsx';
import OptionSection from './option_section.es6.jsx'; 
import ReferenceCategorySection from './reference_category_section.es6.jsx';

class ListingForm extends React.Component {
  constructor(props) {
    super(props);
    var rcount = props.options.filter((o) => o.reference_category).length;
    console.log("rcount is", rcount);
    this.state = {
      ...props,
      refCatCount: rcount
    };
  }

  render() {
    var warningMessageClass = "warning-message";
    if(this.state.refCatCount == 0) {
      warningMessageClass += " active";
    }
    var options = this.state.options.filter((o) => ! o.reference_category);
    var categories = this.state.options.filter((o) => o.reference_category);
    return <div>
      <PriceSection {...this.state} 
        toggleCheck={this.toggleCheck.bind(this)} />
      <OptionSection options={this.props.options} 
        quoteOnly={this.state.quote_only}
        options={options} />
      <ReferenceCategorySection
        addRefCat={this.addRefCat.bind(this)}
        removeRefCat={this.removeRefCat.bind(this)}
        catories={categories} />
      <button type="submit"
        disabled={this.state.refCatCount == 0}>
        Submit
      </button>
      <div className={warningMessageClass}>
        <span className="warning-message-icon"/>

        <span className="warning-message-inner">
          You must add one reference category, which ImageHex uses to organize reference material.
          Typically, this will represent objects or characters in the image.
        </span>
      </div>
    </div>;
  }

  toggleCheck() {
    this.setState({
      quote_only: ! this.state.quote_only
    });
  }

  addRefCat() {
    console.log("Adding a ref cat");
    this.setState({
      refCatCount: this.state.refCatCount + 1
    });
  }

  removeRefCat() {
    console.log("Removing a ref cat");
    this.setState({
      refCatCount: this.state.refCatCount - 1
    });
  }
}

window.ListingForm = ListingForm;

export default ListingForm;
