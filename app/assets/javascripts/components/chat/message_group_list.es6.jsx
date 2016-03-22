import { fetchBefore } from './actions.es6';

class MessageGroupList extends React.Component {
  constructor(props){
    super(props);
    this.state = {};
  }
  render() {
    var groups = this.props.messageGroups.map((group) => {
      var user = this.props.users[group[0]];
      var messages = group[1];
      var key = messages.map((m) => m.id).join("-");
      var lastMessageAt = messages[messages.length - 1].created_at;
      return <MessageGroupList.MessageGroup  
        user={user}
        messages={messages} 
        lastMessageAt={lastMessageAt}
        key={key}
        />;
    });
    return <ul className="conversation-message-groups in-react"
      onScroll={this.scroll.bind(this)}
      ref="scrollBox">
      {groups}
    </ul>;
  }

  componentDidMount( ){
    this.refs.scrollBox.scrollTop = this.refs.scrollBox.scrollHeight;
  }

  scroll(event) {
    this.checkScroll();
  }

  checkScroll() {
    if(this.refs.scrollBox.scrollTop < 100 && ! this.props.fetching) {
      this.props.dispatch(fetchBefore());
    }
  }

  // Preserve scroll position
  componentWillUpdate() {
    var node = this.refs.scrollBox;
    this.scrollHeight = node.scrollHeight;
    this.scrollTop = node.scrollTop;
  }

  // Preserve scroll position
  componentDidUpdate() {
    var node = this.refs.scrollBox;
    node.scrollTop = this.scrollTop + (node.scrollHeight - this.scrollHeight);
  }
}

MessageGroupList.MessageGroup = (group) => {
  return <li className="conversation-message-group">
    <div className="message-group-avatar">
      <img src={group.user.avatar_path} />
    </div>
    <div className="message-group-body">
      <div className="message-group-user-section">
        <span className="user-name">{group.user.name}</span>
        <time dateTime={group.lastMessageAt}>
          {group.lastMessageAt.toLocaleString()}
        </time>
      </div>
      <ul className="message-group-messages">
        {group.messages.map((m) => <MessageGroupList.Message {...m} 
          key={m.id} />)}
      </ul>
    </div>
  </li>
}

MessageGroupList.Message = (m) => {
  return <li>
    {m.body}
  </li>
}

export default MessageGroupList;
