class OrderForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    return <div>
      This is an order for {this.props.listing.name}
    </div>;
  }

}

window.OrderForm = OrderForm;
export default OrderForm;
