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
    if (this.isNone) {
      body = <ListingBackgroundInput.NoneBackground />;
    }
    else if (this.isFree) {
      body = <ListingBackgroundInput.FreeBackground />;
    }
    else if (this.isCharged) {
      body = <ListingBackgroundInput.ChargedBackground 
        price={this.state.price} />;
    }
    var btype = "background-type ";
    return <div className="product-background-input">
      <div className="background-type-section">
        <div className={this.isNone ? btype + "active" : btype}
          onClick={this.moveToNone.bind(this)}>
          No Background
        </div>
        <div className={this.isFree ? btype + "active" : btype}
          onClick={this.moveToFree.bind(this)}>
          Free Background
        </div>
        <div className={this.isCharged ? btype + " active" : btype}
          onClick={this.moveToCharged.bind(this)}>
          Charged Background
        </div>
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
  get isFree() {
    return this.state.type === "free-background";
  }

  get isCharged() {
    return this.state.type === "charged-background";
  }

  get isNone() {
    return this.state.type === "no-background";
  }
}


ListingBackgroundInput.NoneBackground = () => {
  return <div>
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


