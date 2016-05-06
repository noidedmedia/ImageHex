import ListingArtistDisplay from './listing_artist_display.es6.jsx';
import ListingDisplay from './listing_display.es6.jsx';
import Listing from '../../api/listing.es6';

class CommissionOfferForm extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      subjects: props.subjects,
      listing: props.listing,
      background: props.background
    };
  }

  render() {
    return <div className="commission-offer-form-react">
      <ListingArtistDisplay {...this.state.listing.user} />
      <ListingDisplay {...this.state.listing} />
    </div>;
  }
}
window.CommissionOfferForm = CommissionOfferForm;
export default CommissionOfferForm;
