import {CurrencyInputField} from './currency_input.es6.jsx';

class QuotePicker extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      centValue: 500
    };
  }

  render(props) {
    const {centValue} = this.state;
    const stripeFees = Math.floor((centValue * 0.029) + 30);
    const imagehexFees = Math.floor(centValue * (0.10 - 0.029));
    const earnings = centValue - (imagehexFees + stripeFees);

    return <div>
      <CurrencyInputField
        onChange={this.changeValue.bind(this)}
        initialValue={500}
        min={3}
        name="quote_value" />
      <div>
        (You get ${earnings / 100})
      </div>
    </div>;
  }

  changeValue(val) {
    this.setState({
      centValue: val
    });
  }
}

window.QuotePicker = QuotePicker;
