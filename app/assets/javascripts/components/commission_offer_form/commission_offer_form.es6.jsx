import ListingForm from './listing_form.es6.jsx';
import SubjectForm from './subject_form.es6.jsx';

class CommissionOfferForm extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      subjects: props.subjects,
      listing: props.initialListing,
      background: props.background
    };
  }

  render() {
    return <div className="commission-offer-form-react">
      <ListingForm 
        listing={this.state.listing}
        subjects={this.state.subjects}
        addListing={this.addListing.bind(this)}
        removeListing={this.removeListing.bind(this)} />

      <SubjectForm
        subjects={this.state.subjects}
        removeSubject={this.removeSubject.bind(this)}
        addSubject={this.addSubject.bind(this)} />
    </div>
  }

  addSubject() {
    this.state.subjects.push({});
    this.setState({
      subjects: this.state.subjects
    });
  }

  removeSubject(index) {
    this.state.subjects[index].removed = true;
    this.setState({
      subjects: this.state.subjects
    });
  }

  addListing(listing) {
    this.setState({
      listing: listing
    });
  }


  removeListing() {
    this.setState({
      listing: null
    });
  }
}

window.CommissionOfferForm = CommissionOfferForm;
