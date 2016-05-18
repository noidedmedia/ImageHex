class CurrencyInput extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      value: props.centValue / 100,
      centValue: props.centValue
    };
  }
  render() {
    return <input type="number"
      min={this.props.min}
      step="0.01"
      value={this.state.value}
      onChange={this.handleChange.bind(this)} />;
  }
  handleChange(event) {
    var value = event.target.value;
    if(value === "") {
      this.setState({
        value: "",
        centValue: 0
      });
        
    }
    var parse = value;
    console.log(value, parse);
    if(value.endsWith(".")) {
      parse = parse.substring(0, parse.length - 1);
    }
    else if(! value.match(/\d$/)) {
      console.log("Last thing is not a digit");
      value = value.substring(0, value.length - 1);
      parse = parse.substring(0, parse.length - 1);
      console.log("New value:", value);
      console.log("New parse:",parse);
    }
    var centValue = Math.round(parseFloat(value) * 100);
    this.setState({
      value: value
    });
    this.props.onChange(centValue);
  }
  componentWillReceiveProps(props) {
    if (props.centValue !== Math.round(parseFloat(this.state.value) * 100)) {
      console.log("Changing value because it was changed on us");
      this.setState({
        value: props.centValue / 100
      });
    }
  }
}

/*
 * Wrap a currency input field in an actual form field, to
 * make it easier to render on a page.
 */
class CurrencyInputField extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      centValue: this.props.initialValue || 0
    };
  }
  render() {
    return <div>
      <label>
        {this.props.label}
      </label>
      <CurrencyInput centValue={this.state.centValue}
        onChange={this.changeCentValue.bind(this)} 
        min={this.props.min} />
      <input type="hidden"
        name={this.props.name}
        value={this.state.centValue} />
    </div>;
  }

  changeCentValue(value) {
    this.setState({
      centValue: value
    });
  }

}

export { CurrencyInput, CurrencyInputField };
