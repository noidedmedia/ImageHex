import NM from '../../../api/global.es6';
import MessageGroup from './message_group.es6.jsx';
import {
  getHistoryBefore, 
  startUpdate, 
  endUpdate, 
  markRead,
  changeConversation
} from '../actions.es6';

const seperator = (u) => {
  let lastRead = new Date(u.last_active_at);
    return <div className="read-seperator" key="seperator">
      Unread since <span> </span>
      <date dateTime={lastRead}>
        {lastRead.toLocaleString()}
      </date>
    </div>;
};

function groupChunk(messages, users) {
  if(messages.length === 0) {
    return "";
  }
  let userId = messages[0].user_id;
  let components = [];
  let msgBuffer = [];
  if(userId === "unread_active") {
    components.push(seperator(messages[0]));
  }
  // Dump the message buffer in as a group
  function flushBuffer() {
    if(msgBuffer.length > 0) {
      components.push(<MessageGroup
        messages={msgBuffer}
        user={users[userId]}
        key={msgBuffer[0].id} />);
    }
    msgBuffer = [];
  }
  for(var i = 0; i < messages.length; i++) {
    let message = messages[i];
    if(message.user_id === userId) {
      msgBuffer.push(message);
    }
    // unread message seperator
    else if(message.user_id === "unread_active") {
      // ignore seperator entirely
      if((i + 3) > messages.length) {
        continue;
      }
      // add seperator
      else {
        flushBuffer();
        userId = "unread_active";
        components.push(seperator(message));
      }
    }
    else {
      // Flush to an actual group
      flushBuffer();
      // set current user id to new user id
      userId = message.user_id;
      // append current message to new buffer
      msgBuffer.push(message);
    }
    // if msgBuffer is too long, flush it to a group again
    if(msgBuffer.length > 6) {
      flushBuffer();
    }
  }
  flushBuffer();
  return components;
}

class Conversation extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    var upperSuffix = "";
    let mapped = groupChunk(this.props.messages, this.props.users);
    if(this.props.updating) {
      upperSuffix = " updating";
    }
    return <div className="active-conversation">
      <div className={"conversation-upper" + upperSuffix} >
        <h5>{this.props.conversation.name}</h5>
        <a href="#"
          className="close-chat"
          onClick={() => this.context.dispatch(changeConversation(null))} />

      </div>
      <ul className="message-group-list"
        ref={(i) => this._list = i}
        onScroll={this.onScroll.bind(this)}>
        {mapped}
      </ul>
      <input className="message-input"
        ref={(e) => this._input = e}
        onKeyUp={this.keyUp.bind(this)} />
    </div>;
  }

  componentDidMount() {
    if(this.props.messages.length < 15) {
      this.fetchOlder();
    }
  }

  componentWillUpdate(nextProps, nextState) {
    let list = this._list;
    if(! list) {
      return;
    }
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
        console.log("We don't have enough stuff in update, fetching older");
        this.fetchOlder();
      }
      this.checkForRead();
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
      this.clearInput();
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
      let eldestMessage = this.props.messages[0];
      if(eldestMessage.user_id === "unread_active") {
        eldestMessage = this.props.messages[1];
      }
      return new Date(eldestMessage.created_at);
    }
  }

  onScroll(event) {
    let list = event.target;
    if(list.scrollTop < 50) {
      this.fetchOlder();
    }
    this.checkForRead();
  }

  checkForRead() {
    if(! this.props.hasUnread || this.checkingForUnread) {
      console.log("We either have no unread messages or are checking already");
      return;
    }
    let list = this._list;
    let sT = list.scrollTop;
    let oH = list.offsetHeight;
    let sH = list.scrollHeight;
    // If we're not at the bottom, return
    if(sT > 0 && Math.abs(((sT + oH) - sH)) > 4) {
      return;
    }
    this.checkingForUnread = true;
    App.chat.perform("read", {cid: 1});
    window.setTimeout(() => {this.checkingForUnread = false}, 1000);
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
    var data = {message: {body: this._input.value}};
    this.context.dispatch(startUpdate());
    try {
      let cb = NM.postJSON(`/conversations/${cid}/messages`, data);
    }
    catch(err) {
      console.log("Got an erorr while posting:",err);
    }
    finally {
 
      this.context.dispatch(endUpdate());
      this.clearInput();
    }
  }

  clearInput() {
    if(this._input) {
      this._input.value = "";
    }
  }
}

Conversation.contextTypes = {
  store: React.PropTypes.object,
  dispatch: React.PropTypes.func
};

export default Conversation;
