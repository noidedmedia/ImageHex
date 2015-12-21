class ProductBackgroundInput extends React.Component{
  constructor(props){
    super(props)
    var type;
    if(! props.offerBackground && ! props.includeBackground){
      type = "no-background";
    }
    else if(props.offerBackground){
      type = "charged-background";
    }
    else{
      type = "free-background";
    }
    this.state = {
      offerBackground: props.allowBackground,
      includesBackground: props.includesBackground,
      price: props.price,
      type: type
    };
  }
  render(){
    if(this.state.type === "no-background"){
      return <div>
        <h3>No Background</h3>
        Customers cannot add a background to this image.
        You can also chose to <a onClick={this.moveToCharge.bind(this)}>charge for a background</a>
        or <a onClick={this.moveToFree.bind(this)}>include a background in the base price</a> instead.
        <input type="hidden"
          name="commission_product[offer_background]"
          value="false" />
        <input type="hidden"
          name="commission_product[includes_background]"
          value="false" />
      </div>
    }
    else if(this.state.type === "free-background"){
      return <div>
        <h3>Free Background</h3>
        Customers will recieve a background included in the base price of the image.
        You can also chose to <a onClick={this.moveToCharge.bind(this)}>charge for a background</a> or <a onClick={this.moveToNone.bind(this)}>disallow backgrounds entirely</a> instead.
        <input type="hidden"
          name="commission_product[include_background]"
          value="true" />
        <input type="hidden"
          name="commission_product[offer_backgroud]"
          value="false" />
      </div>
    }
    else if(this.state.type === "charged-background"){
      return <div>
        <h3>Charged Backgrounds</h3>
        Customers will pay a fee of
        <CurrencyInputField
          min={1.00}
          initialValue={this.props.price}
          name="commission_product[background_price]" />
        for a background.
        You can also choose to <a onClick={this.moveToFree.bind(this)}>offer free backgrounds</a> or <a onClick={this.moveToNone.bind(this)}>disallow backgrounds entirely.</a>
        <input type="hidden"
          name="commission_product[offer_background]"
          value="true" />
        <input type="hidden"
          name="commission_product[includes_background]"
          value="false" />
      </div>
    }
    return <div>
      This should never happen.
    </div>;
  }
  moveToCharge(){
    this.setState({
      type: "charged-background"
    })
  }
  moveToFree(){
    this.setState({
      type: "free-background"
    });
  }
  moveToNone(){
    this.setState({
      type: "no-background"
    });
  }
}
