import NM from '../../../api/global.es6';
import MessageGroup from './message_group.es6.jsx';
import {
  getHistoryBefore, 
  startUpdate, 
  endUpdate, 
  markRead
} from '../actions.es6';

class Conversation extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    let chunked = NM.chunk(this.props.messages, "user_id");
    let mapped = chunked.map((chunk) => {
      if(chunk[0] !== "unread_active") {
        return <MessageGroup
          messages={chunk[1]}
          user={this.props.users[chunk[0]]} 
          key={chunk[1][0].id} />
      }
      else {
        let lastRead = chunk[1][0].last_active_at;
        return <div className="read-seperator" key="seperator">
          Unread since <span> </span>
          <date dateTime={lastRead}>
            {lastRead.toLocaleString()}
          </date>
        </div>
      }
    });
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
      console.log("Eldest message:",eldestMessage);
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
