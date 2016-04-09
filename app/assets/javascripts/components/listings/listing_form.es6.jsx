import PriceSection from './price_section.es6.jsx';
import OptionSection from './option_section.es6.jsx'; 

class ListingForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = props;
  }

  render() {
    return <div>
      <PriceSection {...this.state} 
        toggleCheck={this.toggleCheck.bind(this)}
        />
      <OptionSection options={this.props.options} 
        quoteOnly={this.state.quote_only}
        />
    </div>;
  }

  toggleCheck() {
    this.setState({
      quote_only: ! this.state.quote_only
    });
  }
}

window.ListingForm = ListingForm;

export default ListingForm;
