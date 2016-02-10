class CommissionProductDisplay extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }
  render() {
    var cost = this.props.product.calculateCost(this.props);
    var costInfo = "";
    if (cost) {
      costInfo = <span className="commission-product-total-cost">
        Total Cost of ${(cost / 100).toFixed(2)}
      </span>;
    }
    var examples = this.props.product.example_images.map((img) => {
      return <li className="product-example-images-item"
        key={img.id}>
        <a href={`/images/${img.id}`} target="_blank">
          <img src={img.thumbnail} />
        </a>
      </li>;
    });
    return <li className="commission-products-list-item">
      <a onClick={this.props.clickTitle}>
        <h2>
          {this.props.product.name}
        </h2>
      </a>
      <CommissionProductDisplay.UserBox {...this.props.product.user} />
      {costInfo}
      <ul className="product-example-images">
        {examples}
      </ul>
    </li>;
  }
}

CommissionProductDisplay.UserBox = (props) => {
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
