import NM from '../api/global.es6';
import React from 'react';

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
    if(value.endsWith(".")) {
      parse = parse.substring(0, parse.length - 1);
    }
    else if(! value.match(/\d$/)) {
      value = value.substring(0, value.length - 1);
      parse = parse.substring(0, parse.length - 1);
    }
    var centValue = Math.round(parseFloat(value) * 100);
    this.setState({
      value: value
    });
    this.props.onChange(centValue);
  }

  componentWillReceiveProps(props) {
    if (props.centValue !== Math.round(parseFloat(this.state.value) * 100)) {
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
    if(this.props.onChange) {
      this.props.onChange(value);
    }
  }

}

export { CurrencyInput, CurrencyInputField };
