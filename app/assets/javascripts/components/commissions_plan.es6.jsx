class CommissionCalculatorResults extends React.Component {
  constructor(props) {
    super(props);
  }
  
  render() {
    var total = document.getElementById("commission-calculator-input").value;

    total = total * 100;

    var stripeFees = Math.floor((total * 0.029) + 30);
    var imagehexFees = Math.floor((total * 0.091));
    var artistEarnings = total - stripeFees - imagehexFees;

    if (total >= 300) {
      return <div>
        <p>Stripe: ${(stripeFees / 100).toFixed(2)}</p>
        <p>ImageHex: ${(imagehexFees / 100).toFixed(2)}</p>
        <p>Artist Earnings: ${(artistEarnings / 100).toFixed(2)}</p>
      </div>;
    }
    
    return <div>
      <p></p>
    </div>;
  }
}

var ready = function() {
  if (document.getElementById("commission-calculator-input-container")) {
    document.getElementById("commission-calculator-input").addEventListener('input', function() {
      ReactDOM.render(
        <CommissionCalculatorResults/>,
        document.getElementById("commission-calculator-results-container")
      );
    });
  }
};

document.addEventListener('page:change', ready);
