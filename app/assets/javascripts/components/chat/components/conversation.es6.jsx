import NM from '../../../api/global.es6';
import MessageGroup from './message_group.es6.jsx';
import {getHistoryBefore, startUpdate, endUpdate} from '../actions.es6';
import 'babel-polyfill';

class Conversation extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      inputValue: ""
    };
  }

  render() {
    let chunked = NM.chunk(this.props.messages, "user_id");
    let mapped = chunked.map((chunk) => (
      <MessageGroup
        messages={chunk[1]}
        user={this.props.users[chunk[0]]} 
        key={chunk[1][0].id} />
    ));
    var upperSuffix = "";
    if(this.props.updating) {
      upperSuffix = " updating";
    }
    return <div className="active-conversation">
      <div className={"conversation-upper" + upperSuffix} >
        <h5>{this.props.conversation.name}</h5>
      </div>
      <ul className="message-group-list"
        ref={(i) => this._list = i}
        onScroll={this.onScroll.bind(this)}>
        {mapped}
      </ul>
      <input className="message-input"
        onChange={this.changeInput.bind(this)}
        onKeyUp={this.keyUp.bind(this)}
        value={this.state.inputValue} />

    </div>;
  }

  componentDidMount() {
    if(this.props.messages.length === 0) {
      this.fetchOlder();
    }
  }

  componentWillUpdate(nextProps, nextState) {
    let list = this._list;
    let sT = list.scrollTop;
    let oH = list.offsetHeight;
    let sH = list.scrollHeight;
    this.shouldScrollToBottom = (Math.abs(((sT + oH) - sH)) < 4);
    this.scrollHeight = sH;
    this.scrollTop = sT;
  }

  componentDidUpdate(prevProps, prevState) {
    if(this.props.conversation.id !== prevProps.conversation.id) {
      if(this.props.messages.length < 15) {
        console.log("We don't have enough stuff in update, failing");
        this.fetchOlder();
      }
    }
    else {
      let list = this._list;
      if(this.shouldScrollToBottom) {
        list.scrollTop = list.scrollHeight;
      }
    }
  }

  componentWillReceiveProps(nextProps) {
    if(this.props.conversation.id !== nextProps.conversation.id) {
      this.setState({
        inputValue: ""
      });
    }
  }

  fetchOlder() {
    if(this.props.depletedHistory) {
      return false;
    }
    else {
      let cid = this.props.conversation.id;
      let beforeDate = this.getEldestDate();
      this.context.dispatch(getHistoryBefore(beforeDate, cid));
    }
  }

  getEldestDate() {
    if(this.props.messages.length === 0) {
      return new Date();
    }
    else {
      return new Date(this.props.messages[0].created_at);
    }
  }

  onScroll(event) {
    var t = event.target;
    if(t.scrollTop < 50) {
      this.fetchOlder();
    }
  }

  changeInput(event) {
    this.setState({
      inputValue: event.target.value
    });
  }

  keyUp(event) {
    if(event.shiftKey) {
      return;
    }
    else {
      // Enter key sends message
      if(event.keyCode === 13) {
        this.sendMessage();
      }
    }
  }

  async sendMessage() {
    var cid = this.props.conversation.id;
    var data = {message: {body: this.state.inputValue}};
    console.log("Sending data:",data);
    this.context.dispatch(startUpdate());
    try {
      let cb = NM.postJSON(`/conversations/${cid}/messages`, data);
      console.log("Posted Json?");
    }
    catch(err) {
      console.log("Got an erorr while posting:",err);
    }
    finally {
      console.log("Finally block runs");
      this.context.dispatch(endUpdate());
      this.setState({
        inputValue: ""
      });
    }
  }
}

Conversation.contextTypes = {
  store: React.PropTypes.object,
  dispatch: React.PropTypes.func
};

export default Conversation;
