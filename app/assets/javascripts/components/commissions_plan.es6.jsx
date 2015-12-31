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
      min="3.00"
      step="0.01"
      id="commission-calculator-input"
      onChange={this.updateValue.bind(this)}
      className="input"
    />;
    total = this.state.value * 100;

    var stripeFees = Math.floor((total * 0.029) + 30);
    var imagehexFees = Math.floor((total * 0.091));
    var artistEarnings = total - stripeFees - imagehexFees;

    if (total >= 300) {
      return <div>
        {input}
        <table>
          <tbody>
            <tr>
              <td>Stripe</td>
              <td>${(stripeFees / 100).toFixed(2)}</td>
            </tr>
            <tr>
              <td>ImageHex</td>
              <td>${(imagehexFees / 100).toFixed(2)}</td>
            </tr>
            <tr>
              <td>Artist Earnings</td>
              <td>${(artistEarnings / 100).toFixed(2)}</td>
            </tr>
          </tbody>
        </table>
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
