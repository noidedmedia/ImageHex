class ListingDisplay extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }
  render() {
    var cost = this.props.listing.calculateCost(this.props);
    var costInfo = "";
    if (cost) {
      costInfo = <span className="commission-listing-total-cost">
        Total Cost of ${(cost / 100).toFixed(2)}
      </span>;
    }
    var examples = this.props.listing.example_images.map((img) => {
      return <li className="listing-example-images-item"
        key={img.id}>
        <a href={`/images/${img.id}`} target="_blank">
          <img src={img.thumbnail} />
        </a>
      </li>;
    });
    return <li className="commission-products-list-item">
      <a onClick={this.props.clickTitle}>
        <h2>
          {this.props.listing.name}
        </h2>
      </a>
      <ListingDisplay.UserBox {...this.props.listing.user} />
      {costInfo}
      <ul className="product-example-images">
        {examples}
      </ul>
    </li>;
  }
}

ListingDisplay.UserBox = (props) => {
  return <span className="product-user-container">
    <span className="product-user-avatar">
      <img src={props.avatar_path} />
    </span>
    <span className="product-user-name">
      <a href={`/@${props.slug}`} target="_blank">
        {props.name}
      </a>
    </span>
  </span>;
};
