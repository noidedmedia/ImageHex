import ReferenceForm from './reference_form.es6.jsx';

class CategorySection extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    const {category} = this.props;

    return <div className="category-section">
      <div className="category-header">
        <h3>{category.name}</h3>
        <div className="category-description markdown-description"
          dangerouslySetInnerHTML={this.descriptionHTML()} />
        <div>Describe each {category.name} individually.</div>
        {this.addButton()}

      </div>
      
      <ul className="reference-group-list">
        {this.refFields()}
      </ul>
    </div>
  }

  refFields() {
    const {category} = this.props;
    if(this.props.references.length == 0) {
      // TODO: maybe add a "nothing here" thing?
      return <div></div>; 
    }
    else {
      return this.props.references.map((ref) => {
        return <ReferenceForm
          removeSelf={this.props.removeReference.bind(null, ref.index)}
          reference={ref} 
          key={ref.key}
          category={category}
          />;
      }).reverse();
    }
  }

  addButton() {
    if(this.props.references.length < this.props.category.max_count) {
      return <a
        href="#"
        onClick={this.props.addReference}
        className="green-add-button">
        Add a {this.props.category.name}
      </a>;
    }
    return <div></div>;
  }

  descriptionHTML() {
    return {__html: this.props.category.html_description};
  }
}

export default CategorySection;
