class MessageInput extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      inputValue: ""
    };
  }
  render(){
    return <div className="message-input-container">
      <textarea
        onChange={this.change.bind(this)}
        value={this.state.inputValue} />
      <button type="button"
        onClick={this.submit.bind(this)}>
        Submit
      </button>
    </div>;
  }
  change(event) {
    this.setState({
      inputValue: event.target.value
    });
  }

  submit(event) {
    this.props.onAdd(this.state.inputValue);
    this.setState({
      inputValue: ""
    });
  }
}
