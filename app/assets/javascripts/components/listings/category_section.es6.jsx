import CategoryFields from './category_fields.es6.jsx';

class CategorySection extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    var categories = this.props.categories.map((c, i) => {
      // We pretend that the index is much larger than it actually is
      // to avoid over-writing the fields from options
      // if a user has over 10K options this breaks, but...
      // that should never happen
      return <CategoryFields
        category={c}
        key={c.id || i}
        quoteOnly={this.props.quoteOnly}
        index={i}
        removeSelf={this.props.removeCategory.bind(null, i)} />;
    });
    return <div className="listing-form-section">
      <div className="listing-form-section-header">
        <h1>Categories</h1>
        <div className="description">
          Categories provide a way for your clients to 
          organize their reference material, and for you to manage prices.
          Typically, an artist will provide one category 
          for characters in their image, and optionally one for a background.
          You may create as many categories as you like, and may charge
          for things in that category—for example, a set price per character.
        </div>
        <a className="green-add-button add-category-button"
          onClick={this.props.addCategory}>
          Add a Category
        </a>
      </div>
      <ul>
        {categories}
      </ul>
    </div>
  }
}

CategorySection.contextTypes = {
  quoteOnly: React.PropTypes.bool
};


export default CategorySection;
