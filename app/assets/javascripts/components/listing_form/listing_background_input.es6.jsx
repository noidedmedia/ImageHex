class ListingBackgroundInput extends React.Component {
  constructor(props) {
    super(props);
    var type;
    if (! props.offerBackground && ! props.includeBackground) {
      type = "no-background";
    }
    else if (props.offerBackground) {
      type = "charged-background";
    }
    else {
      type = "free-background";
    }
    this.state = {
      offerBackground: props.allowBackground,
      includesBackground: props.includesBackground,
      price: props.price,
      type: type
    };
  }
  render() {
    var body;
    if (this.state.type === "no-background") {
      body = <ListingBackgroundInput.NoneBackground />;
    }
    else if (this.state.type === "free-background") {
      body = <ListingBackgroundInput.FreeBackground />;
    }
    else if (this.state.type === "charged-background") {
      body = <ListingBackgroundInput.ChargedBackground 
        price={this.state.price} />;
    }
    return <div className="product-background-input">
      <div className="radio-container">
        <input type="radio"
          checked={this.state.type === "no-background"}
          onChange={this.moveToNone.bind(this)}/>
        <label>No Background</label>
      </div>
      <div className="radio-container">
        <input type="radio"
          checked={this.state.type === "free-background"}
          onChange={this.moveToFree.bind(this)} />
        <label>Free Background</label>
      </div>
      <div className="radio-container">
        <input type="radio"
          checked={this.state.type === "charged-background"}
          onChange={this.moveToCharged.bind(this)} />
        <label>Paid Background</label>
      </div>
      <div className="background-input-body">
        {body}
      </div>
    </div>;
  }
  moveToCharged() {
    this.setState({
      type: "charged-background"
    });
  }
  moveToFree() {
    this.setState({
      type: "free-background"
    });
  }
  moveToNone() {
    this.setState({
      type: "no-background"
    });
  }
}


ListingBackgroundInput.NoneBackground = () => {
  return <div>
    <h3>No Background</h3>
    Customers cannot add a background to this image.
    <input type="hidden"
      name="listing[offer_background]"
      value="false" />
    <input type="hidden"
      name="listing[include_background]"
      value="false" />
  </div>;
};

ListingBackgroundInput.FreeBackground = () => {
  return <div>
    <h3>Free Background</h3>
    Customers will recieve a background included in the base price of the image.
    <input type="hidden"
      name="listing[include_background]"
      value="true" />
    <input type="hidden"
      name="listing[offer_backgroud]"
      value="false" />
  </div>;
};

ListingBackgroundInput.ChargedBackground = (props) => {
  return <div>
    <h3>Charged Backgrounds</h3>
    Customers will pay a fee of
    <CurrencyInputField
      min={1.00}
      initialValue={props.price}
      name="listing[background_price]" />
    for a background.
    <input type="hidden"
      name="listing[offer_background]"
      value="true" />
    <input type="hidden"
      name="listing[include_background]"
      value="false" />
  </div>;
};


