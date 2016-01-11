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
    var body;
    if(this.state.type === "no-background"){
      body = <ProductBackgroundInput.NoneBackground />;
    }
    else if(this.state.type === "free-background"){
      body = <ProductBackgroundInput.FreeBackground />;
    }
    else if(this.state.type === "charged-background"){
      body = <ProductBackgroundInput.ChargedBackground 
        price={this.state.price} />;
    }
    return <div className="product-background-input">
      <div class="radio-container">
        <label>No Background</label>
        <input type="radio"
          checked={this.state.type === "no-background"}
          onChange={this.moveToNone.bind(this)}/>
      </div>
      <div class="radio-container">
        <label>Free Background</label>
        <input type="radio"
          checked={this.state.type === "free-background"}
          onChange={this.moveToFree.bind(this)} />
      </div>
      <div class="radio-container">
        <label>Paid Background</label>
        <input type="radio"
          checked={this.state.type === "charged-background"}
          onChange={this.moveToCharged.bind(this)} />
      </div>
      <div class="background-input-body">
        {body}
      </div>
    </div>;
  }
  moveToCharged(){
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


ProductBackgroundInput.NoneBackground = () => {
  return <div>
    <h3>No Background</h3>
    Customers cannot add a background to this image.
    <input type="hidden"
      name="commission_product[offer_background]"
      value="false" />
    <input type="hidden"
      name="commission_product[includes_background]"
      value="false" />
  </div>;
};

ProductBackgroundInput.FreeBackground = () => {
  return <div>
    <h3>Free Background</h3>
    Customers will recieve a background included in the base price of the image.
    <input type="hidden"
      name="commission_product[include_background]"
      value="true" />
    <input type="hidden"
      name="commission_product[offer_backgroud]"
      value="false" />
  </div>;
}

ProductBackgroundInput.ChargedBackground = (props) => {
  return <div>
    <h3>Charged Backgrounds</h3>
    Customers will pay a fee of
    <CurrencyInputField
      min={1.00}
      initialValue={props.price}
      name="commission_product[background_price]" />
    for a background.
    <input type="hidden"
      name="commission_product[offer_background]"
      value="true" />
    <input type="hidden"
      name="commission_product[includes_background]"
      value="false" />
  </div>
}


