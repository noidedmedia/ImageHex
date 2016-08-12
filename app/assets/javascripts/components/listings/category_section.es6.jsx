import CategoryFields from './category_fields.es6.jsx';


let RemovedCategory = ({id, index}) => (
  <div>
    <input type="hidden"
      name={`listing[categories_attributes][${0 - id}][id]`}
      value={id} />
    <input type="hidden"
      name={`listing[categories_attributes][${0 - id}][_destroy]`}
      value={true} />
  </div>
);

class CategorySection extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    var removedCategories = this.props.removedCategories.map((c, i) => (
      <RemovedCategory
        key={i}
        index={i}
        {...c} />
    ));
    var categories = this.props.categories.map((c, i) => {
      return <CategoryFields
        category={c}
        key={c.id}
        quoteOnly={this.props.quoteOnly}
        index={i}
        removeSelf={this.props.removeCategory.bind(null, i)} />;
    });
    return <div className="listing-form-section">
      <div className="listing-form-section-header">
        <h1>Reference Categories</h1>
        <div className="description">
          Reference categories help you organize your commission into logical parts, such as "characters" or "background".
          Your clients will be able to add items within each category individually, and you can charge per item.
          Each item will also have its own reference material, to help you keep things organized.
        </div>
        <a className="green-add-button add-category-button"
          onClick={this.props.addCategory}>
          Add a Category
        </a>
      </div>
      <ul>
        {categories}
        {removedCategories}
      </ul>
    </div>
  }
}

CategorySection.contextTypes = {
  quoteOnly: React.PropTypes.bool
};


export default CategorySection;
