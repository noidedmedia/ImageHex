class CommissionProductDisplay extends React.Component{
  constructor(props){
    super(props);
    this.state = {};
  }
  render(){
    console.log("Displaying a product:",this.props.product);
    var cost = this.props.product.calculateCost(this.props);
    console.log(`In product display, found a cost of ${cost}`);
    var costInfo = "";
    if(cost){
      costInfo = <span className="commission-product-total-cost">
        Total Cost of ${(cost / 100).toFixed(2)}
      </span>
    }
    return <div className="commission-product-display">
      <h2 onClick={this.props.clickTitle}>
        {this.props.product.name}
      </h2>
      <CommissionProductDisplay.UserBox {...this.props.product.user} />
      {costInfo}
    </div>;
  }
}

CommissionProductDisplay.UserBox = (props) => {
  console.log("UserBox gets props:",props);
  return <div className="product-user-display">
    <img src={props.avatar_path} />
    <span>
      <a href={`/@${props.slug}`} target="_blank">
        {props.name}
      </a>
    </span>
  </div>;
}
