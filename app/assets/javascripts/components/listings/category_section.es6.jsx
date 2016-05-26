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
    return <div>
      <a className="add-option-button"
        href="#"
        onClick={this.props.addCategory}>
        Add a Reference Category
      </a>
      <ul>
        {categories}
      </ul>
    </div>
  }
}

export default CategorySection;
