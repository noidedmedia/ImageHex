class CommissionCalculatorResults extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      value: ""
    }
  }

  render() {
    var input = <input type="number"
      value={this.state.value}
      min="3"
      id="commission-calculator-input"
      onChange={this.updateValue.bind(this)}
    />;
    total = this.state.value * 100;

    var stripeFees = Math.floor((total * 0.029) + 30);
    var imagehexFees = Math.floor((total * 0.091));
    var artistEarnings = total - stripeFees - imagehexFees;

    if (total >= 300) {
      return <div>
        {input}
        <p>Stripe: ${(stripeFees / 100).toFixed(2)}</p>
        <p>ImageHex: ${(imagehexFees / 100).toFixed(2)}</p>
        <p>Artist Earnings: ${(artistEarnings / 100).toFixed(2)}</p>
      </div>;
    }

    return <div>
      {input}
      <p></p>
    </div>;
  }
  updateValue(event){
    this.setState({
      value: event.target.value
    });
  }
}

var ready = function() {
  var x;
  if (x = document.getElementById("commission-calculator-input-container")) {
    ReactDOM.render(<CommissionCalculatorResults/>,
                    x);
  }
};

document.addEventListener('page:change', ready);
