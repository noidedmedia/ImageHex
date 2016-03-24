class ListingForm extends React.Component {
  constructor(props){
    super(props);
  }

  render() {
    if(this.props.listing) {
      return <div>
        <ListingDisplay listing={this.props.listing} 
          removeListing={this.props.removeListing} />
        <input type="hidden"
          name="commission_offers[listing_id]"
          value={this.props.listing.id} />
      </div>;
    }
    else {
      return <ListingPicker
        select={this.props.addListing}
        subjects={this.props.subjects}
      />;
    }
  }
}

ListingDisplay = ({listing, removeListing}) => (
  <div className="offer-listing-display">
    <div className="offer-listing-user">
      <img src={listing.user.avatar_path} />
      <span>{listing.user.name}</span>
    </div>
  </div>
);

export default ListingForm;
