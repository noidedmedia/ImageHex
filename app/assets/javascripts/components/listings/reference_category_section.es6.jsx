import ReferenceCategoryFields from './reference_category_fields.es6.jsx';

class ReferenceCategorySection extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      categories: (props.categories || []),
      key: 0
    };
  }

  render() {
    var categories = this.state.categories.map((c, i) => {
      return <ReferenceCategoryFields
        category={c}
        key={c.id || c.key}
        quoteOnly={this.props.quoteOnly}
        addRefCat={this.props.addRefCat}
        removeRefCat={this.props.removeRefCat}
        index={i}
        removeSelf={this.removeCategory.bind(this, i)} />;
    });
    return <div>
      <a className="add-option-button"
        href="#"
        onClick={this.addCategory.bind(this)}>
        Add a Reference Category
      </a>
      <ul>
        {categories}
      </ul>
      
    </div>
  }

  addCategory() {
    var {key} = this.state;
    this.setState({
      categories: [...this.state.categories, {key: key}],
      key: key - 1
    });
  }

  removeCategory(index) {
    this.state.categories.splice(index, 1);
    this.setState({
      categories: this.state.categories
    });
  }
}

export default ReferenceCategorySection;
