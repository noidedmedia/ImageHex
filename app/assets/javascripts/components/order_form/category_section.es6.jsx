import ReferenceForm from './reference_form.es6.jsx';

class CategorySection extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    const {category} = this.props;
    const refs = this.props.references.map((ref) => {
      return <ReferenceForm
        removeSelf={this.props.removeReference.bind(ref.index)}
        reference={ref} 
        key={ref.index}
        category={category}
        />;
    });

    return <div className="category-section">
      <div className="category-header">
        <h3>{category.name}</h3>
        <div className="category-description"
          dangerouslySetInnerHTML={this.descriptionHTML()} />
        {this.addButton()}
      </div>
      <ul className="reference-group-list">
        {refs}
      </ul>
    </div>
  }

  addButton() {
    if(this.props.references.length < this.props.category.max_count) {
      return <button
        onClick={this.props.addReference}
        type="button">
        Add Another
      </button>;
    }
    return <div></div>;
  }

  descriptionHTML() {
    return {__html: this.props.category.html_description};
  }
}

export default CategorySection;
