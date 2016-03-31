import { sendMessage } from './actions.es6';

class MessageInput extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      inputValue: ""
    };
  }
  render(){
    var isSending = <span></span>
    if(this.props.sending) {
      isSending = <progress></progress>;
    }
    return <div className="message-input-container">
      <textarea
        onChange={this.change.bind(this)}
        value={this.state.inputValue} />
      <button type="button"
        onClick={this.submit.bind(this)}>
        Submit
      </button>
      {isSending}
    </div>;
  }
  change(event) {
    this.setState({
      inputValue: event.target.value
    });
  }

  submit(event) {
    this.props.dispatch(sendMessage(this.state.inputValue));
    this.setState({
      inputValue: ""
    });
  }
}

export default MessageInput;
