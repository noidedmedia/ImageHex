class ListingPicker extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      page: 1,
      fetched: false,
    };
    console.log("In product picker, got props",props);
    this.fetchData(props);
  }
  render() {
    if (this.state.fetched) {
      var listings = this.state.listings.map((l) => {
        return <ListingDisplay
            listing={l}
            clickTitle={this.onAdd.bind(this, l)}
            {...this.props} />;
      });
      return <ul className="commission-products-list">
        {listings}
      </ul>;
    }
    else { 
      return <div>
        <progress></progress>
      </div>;
    }
  }
  componentWillReceiveProps(nextProps) {
    console.log("Commission product picker is receiving new props",nextProps);
    if ((this.props.subjectsCount == nextProps.subjectsCount &&
        this.props.hasBackground == nextProps.hasBackgroud)) {
      console.log("subjectsCount or hasBackground has not changed.");
      return;
    }
    this.setState({
      page: 1
    });
    this.fetchData(nextProps);
  }

  onAdd(listing) {
    this.props.onAdd(listing);
  }

  // Get a new list products we can use
  fetchData(props) {
    console.log("Fetching new data");
    Listing.withCriteria(props, this.state.page, (listings) => {
      this.setState({
        fetched: true,
        listings: listings
      });
    });
  }
}

ListingPicker.propTypes = {
  onAdd: React.PropTypes.func
};
