import PriceSection from './price_section.es6.jsx';
import OptionSection from './option_section.es6.jsx'; 
import CategorySection from './category_section.es6.jsx';
import ExampleImageSection from './example_image_section.es6.jsx';

class ListingForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      ...props,
      removedCategories: []
    };
    this.categoryFakeId = -1;
  }

  render() {
    return <div id="listing-form">
      <PriceSection {...this.state} 
        toggleCheck={this.toggleCheck.bind(this)} />
      <CategorySection
        categories={this.state.categories}
        addCategory={this.addCategory.bind(this)}
        removedCategories={this.state.removedCategories}
        removeCategory={this.removeCategory.bind(this)} />
      <OptionSection
        quoteOnly={this.state.quote_only}
        addOption={this.addOption.bind(this)}
        removeOption={this.removeOption.bind(this)}
        options={this.state.options} />
      <ExampleImageSection />
        {this.submitSection}
      </div>
    }

  get submitSection() {
    if(this.state.categories.length == 0) {
      return <div className="warning-dialogue">
        <span className="warning-dialogue-icon" />
        <span className="warning-dialogue-inner">
          You must add one reference category, which ImageHex uses to organize reference material.
          Typically, this will represent objects or characters in the image.
        </span>
      </div>;
    }
    else {
      return  <button type="submit"
        className="checkmark-submit-button">
        Save Listing
      </button>;
    }
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
      categories: [...this.state.categories, {id: this.categoryFakeId}]
    });
    this.categoryFakeId = this.categoryFakeId - 1;
  }

  removeCategory(index) {
    let removed = this.state.categories.splice(index, 1)[0];
    console.log("Removed category",removed);
    let removedCategories = removed.id > 0 ? (
      [...this.state.removedCategories, removed]) : (
        this.state.removedCategories);
    console.log("After removal, removed categories are",removedCategories);
    this.setState({
      categories: this.state.categories,
      removedCategories
    });
  }
}

ListingForm.childContextTypes = {
  quoteOnly: React.PropTypes.bool
};


window.ListingForm = ListingForm;

export default ListingForm;
