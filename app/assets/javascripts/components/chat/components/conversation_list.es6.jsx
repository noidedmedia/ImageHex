import { changeConversation } from '../actions.es6';

export default class ConversationList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    return <ul className={this.getClassName()}>
      {this.conversations()}
    </ul>;
  }

  getClassName() {
    var cn = "conversation-list";
    if(this.props.active) {
      cn += " active";
    }
    else {
      cn += " inactive";
    }
    return cn;
  }

  conversations() {
    var c = [];
    for(var i in this.props.conversations) {
      let conv = this.props.conversations[i];
      let users = this.usersForConversation(conv);
      console.log("Got users for conversation",users);
      c.push(<ConversationItem
        key={i}
        conversation={conv}
        hasUnread={this.props.unreadMap[i]}
        users={users}
        acitvate={this.activate.bind(this, i)}
        active={i === this.props.activeConversation} />);
    }
    return c;
  }

  usersForConversation(conv) {
    console.log("Got users",this.props.users);
    console.log("Got user ids",conv.userIds);
    return conv.userIds.map((id) => this.props.users[id]);
  }

  activate(id) {
    this.context.dispatch(changeConversation(id));
  }
}

ConversationList.contextTypes = {
  store: React.PropTypes.object,
  dispatch: React.PropTypes.func
};

const ConversationItem = (props) => {
  var className = "conversation-item";
  var click = () => {};
  if(props.active) {
    className += " active";
  }
  else {
    console.log("Setting click to activation");
    click = props.activate;
  }
  if(props.hasUnread) {
    className += " has-unread";
  }
  let ud = props.users.map(userDisplay);
  return <li className={className}
    onClick={click}>
    <h4>{props.conversation.name}</h4>
    <ul className="conversation-users-list">
      {ud}
    </ul>
  </li>;
};

function userDisplay(u, index) {
  if(u) {
    return <li key={u.id}>
      <img src={u.avatar_path} />
    </li>
  }
  else {
    return <li key={index}>
    </li>;
  }
}
