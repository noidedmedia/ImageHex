import PriceSection from './price_section.es6.jsx';
import OptionSection from './option_section.es6.jsx'; 
import CategorySection from './category_section.es6.jsx';

class ListingForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      ...props
    };
  }

  render() {
    var warningMessageClass = "warning-message";
    return <div id="listing-form">
      <PriceSection {...this.state} 
        toggleCheck={this.toggleCheck.bind(this)} />
      <OptionSection
        quoteOnly={this.state.quote_only}
        addOption={this.addOption.bind(this)}
        removeOption={this.removeOption.bind(this)}
        options={this.state.options} />
      <CategorySection
        categories={this.state.categories}
        addCategory={this.addCategory.bind(this)}
        removeCategory={this.removeCategory.bind(this)} />
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

  getChildContext() {
    return {
      quoteOnly: this.state.quote_only
    };
  }

  toggleCheck() {
    this.setState({
      quote_only: ! this.state.quote_only
    });
  }

  addOption() {
    this.setState({
      options: [...this.state.options, {}]
    });
  }

  removeOption(index) {
    this.state.options.splice(index, 1);
    this.setState({
      options: this.state.options
    });
  }

  addCategory() {
    this.setState({
      categories: [...this.state.categories, {}]
    });
  }

  removeCategory(index) {
    this.state.categories.splice(index, 1);
    this.setState({
      categories: this.state.categories
    });
  }
}

ListingForm.childContextTypes = {
  quoteOnly: React.PropTypes.bool
};


window.ListingForm = ListingForm;

export default ListingForm;
