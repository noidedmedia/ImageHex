class ListingDisplay extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    return <div className="listing-display">
      <span className="listing-header">
        <div>{this.props.name}</div>
        <div>${Math.floor(this.props.base_price / 100)}</div>
      </span>
      <div className="listing-included-section">
        <h3>Included</h3>
        <ul>
          {/* TODO: make this handle the one-subject case correctly */}
          <li>{this.props.included_subjects} subjects</li>
          { this.props.include_background ? <li>Background</li> : "" }
        </ul>
      </div>
    </div>
  }
}

export default ListingDisplay;
