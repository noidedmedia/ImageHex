class CommissionProductDisplay extends React.Component{
  constructor(props){
    super(props);
    this.state = {};
    console.log(this.props.product);
  }
  render(){
    return <div className="commission-product-display">
      <h2>{this.props.product.name}</h2>
      <CommissionProductDisplay.UserBox {...this.props.product.user} />
    </div>;
  }
}

CommissionProductDisplay.UserBox = (props) => {
  console.log("UserBox gets props:",props);
  return <div className="product-user-display">
    <img src={props.avatar_path} />
    <span>
      <a href={`/@${props.slug}`}>
        {props.name}
      </a>
    </span>
  </div>;
}
