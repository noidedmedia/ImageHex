class ListingPicker extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      listings: []
    };
  }

  render() {
    if(this.state.listings){
      return <div></div>;
    }
    else {
      return <progress></progress>;
    }
  }

  componentWillMount() {
    this.getEligableListings();
  }

  componentWillRecieveProps(props) {
    if(this.props.subjects.length != props.subjects.length) {
      this.getEligableListings();
    }
  }

  getEligableListings(){

  }
}
