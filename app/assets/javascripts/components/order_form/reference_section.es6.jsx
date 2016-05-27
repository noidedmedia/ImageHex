import CategorySection from './category_section.es6.jsx';

class ReferenceSection extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    var rs = this.props.categories.map((cat, i) => {
      var refs = this.refsForCategory(cat);
      return <CategorySection
        key={i}
        category={cat}
        references={refs}
        addReference={this.props.addReference.bind(null, cat.id)}
        removeReference={this.props.removeReference} />;
    });
    return <ul className="categories">
      {rs}
    </ul>
  }

  refsForCategory(cat) {
    var refs = [];
    this.props.references.forEach((ref, i) => {
      if(ref.listing_category_id === cat.id) {
        refs.push(Object.assign({}, ref, {index: i}));
      }
    });
    return refs;
  }
}

export default ReferenceSection;
