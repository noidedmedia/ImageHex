import React, { Component } from 'react';

// Renders a "dumb" text input component
// This does not keep track of what is input for the user, but will keep
// track of if there is text, and adjust labels accordingly
class TextareaInput extends Component {
  constructor(props) {
    super(props);
    this.state = {
      hasInput: !! props.defaultValue
    };
  }

  get labelClass() {
    if(this.state.hasInput) {
      return "label";
    }
    else {
      return "label input-empty";
    }
  }

  render() {
    return <div className="field-container">
      <label className={this.labelClass} htmlFor={this.props.name}>
        {this.props.label}
      </label>
      <textarea className="input react-input" 
        name={this.props.name} 
        defaultValue={this.props.defaultValue}
        required={this.props.required}
        onInput={this.input.bind(this)} />
    </div>;
  }

  input(event) {
    if(event.target.value != "" && ! this.state.hasInput) {
      this.setState({
        hasInput: true
      });
    }
    else if(this.state.hasInput && event.target.value == "") {
      this.setState({
        hasInput: false
      });
    }
  }
}

export default TextareaInput;
