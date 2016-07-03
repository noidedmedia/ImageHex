class CommissionPriceCalculator extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      value: "10"
    };
  }

  render() {
    var input = <input type="number"
      value={this.state.value}
      min="3"
      max="999"
      id="commission-calculator-input"
      onChange={this.updateValue.bind(this)}
      className="input"
    />;
    total = this.state.value * 100;

    var stripeFees = Math.floor((total * 0.029) + 30);
    var imagehexFees = Math.floor(total * (0.10 - 0.029));
    var artistEarnings = total - stripeFees - imagehexFees;

    if (total >= 300) {
      return <div>
        <table>
          <tbody>
            <tr>
              <td>Total Commission</td>
              <td><p>${input}</p></td>
            </tr>
            <tr>
              <td>Stripe</td>
              <td>${(stripeFees / 100).toFixed(2)}</td>
            </tr>
            <tr>
              <td>ImageHex</td>
              <td>${(imagehexFees / 100).toFixed(2)}</td>
            </tr>
            <tr>
              <td>Artist</td>
              <td>${(artistEarnings / 100).toFixed(2)}</td>
            </tr>
          </tbody>
        </table>
      </div>;
    }

    return <div>
      <table>
          <tbody>
            <tr>
              <td>Total Commission</td>
              <td><p>${input}</p></td>
            </tr>
          </tbody>
        </table>
    </div>;
  }

  updateValue(event) {
    this.setState({
      value: event.target.value
    });
  }
}

window.CommissionPriceCalculator = CommissionPriceCalculator;
